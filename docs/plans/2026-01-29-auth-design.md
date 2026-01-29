# 인증 시스템 설계

> 작성일: 2026-01-29
> 상태: 승인됨

## 개요

RunningMate 앱의 인증 시스템 설계 문서입니다. Supabase Auth 기반 소셜 로그인을 제공합니다.

### 핵심 요구사항

- 소셜 로그인만 지원 (Google + Apple + 카카오)
- 로그인 후 프로필 설정 (닉네임 + 체중 + 목표)
- 자동 로그인 유지 (명시적 로그아웃까지)
- 탈퇴 시 7일 유예 후 영구 삭제
- 권한은 필요 시점에 설명 화면 후 요청

---

## 1. 데이터 모델

### UserProfile

```dart
class UserProfile {
  String id;                    // Supabase auth.users.id
  String email;                 // 소셜에서 가져옴
  String? nickname;             // 사용자 입력
  String? avatarUrl;            // 소셜 프로필 이미지

  // 러닝 프로필
  double? weightKg;             // 체중 (칼로리 계산용)
  RunningGoal? goal;            // 목표

  // 메타데이터
  AuthProvider provider;        // google, apple, kakao
  DateTime createdAt;
  DateTime? lastLoginAt;

  // 탈퇴 관련
  bool isDeleted;
  DateTime? deletionRequestedAt;
}
```

### AuthProvider

```dart
enum AuthProvider {
  google,
  apple,
  kakao,
}
```

### OnboardingStatus

```dart
enum OnboardingStatus {
  needsProfile,      // 프로필 입력 필요
  needsPermissions,  // 권한 설정 필요 (선택적)
  completed,         // 완료
}
```

### AuthState

```dart
enum AuthState {
  initial,           // 초기화 중
  unauthenticated,   // 로그인 필요
  needsOnboarding,   // 로그인됨, 프로필 설정 필요
  authenticated,     // 완전히 인증됨
}
```

### Supabase 테이블

```sql
create table user_profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text,
  nickname text,
  avatar_url text,

  weight_kg decimal(4,1),
  goal text,

  provider text not null,

  is_deleted boolean default false,
  deletion_requested_at timestamptz,

  created_at timestamptz default now(),
  last_login_at timestamptz
);

-- RLS 정책
alter table user_profiles enable row level security;

create policy "Users can view own profile"
  on user_profiles for select
  using (auth.uid() = id);

create policy "Users can update own profile"
  on user_profiles for update
  using (auth.uid() = id);
```

---

## 2. 인증 플로우

### 전체 플로우

```
앱 시작 → 세션 체크 → [세션 있음] → 프로필 체크 → 홈 화면
                   → [세션 없음] → 로그인 화면
                                      │
                              ┌───────┼───────┐
                              ▼       ▼       ▼
                           Google   Apple   카카오
                              │       │       │
                              └───────┴───────┘
                                      │
                                신규/기존 판단
                                      │
                              ┌───────┴───────┐
                              ▼               ▼
                           [신규]          [기존]
                              │               │
                              ▼               │
                         프로필 설정          │
                              │               │
                              └───────┬───────┘
                                      │
                                      ▼
                                  홈 화면
```

### Supabase OAuth 설정

```dart
// Google
await supabase.auth.signInWithOAuth(
  OAuthProvider.google,
  redirectTo: 'com.runningmate.app://callback',
);

// Apple
await supabase.auth.signInWithOAuth(
  OAuthProvider.apple,
  redirectTo: 'com.runningmate.app://callback',
);

// 카카오 (Custom OIDC Provider)
await supabase.auth.signInWithOAuth(
  OAuthProvider.kakao,
  redirectTo: 'com.runningmate.app://callback',
);
```

### 딥링크 설정

| 플랫폼 | Scheme |
|--------|--------|
| Android | `com.runningmate.app://callback` |
| iOS | `com.runningmate.app://callback` |

---

## 3. 온보딩 플로우

### 3단계 프로필 설정

**Step 1: 닉네임**
- 필수 입력
- 2-10자, 한글/영문/숫자만
- 중복 체크

**Step 2: 체중**
- 선택 입력 (나중에 가능)
- 30-200kg 범위
- 칼로리 계산용

**Step 3: 목표**
- 선택 입력 (나중에 가능)
- 마라톤 완주 / 다이어트 / 체력 향상 / 스트레스 해소

### 유효성 검사

| 필드 | 규칙 |
|------|------|
| 닉네임 | 필수, 2-10자, 한글/영문/숫자만, 중복 체크 |
| 체중 | 선택, 30-200kg 범위 |
| 목표 | 선택, 미선택 시 null |

---

## 4. 세션 관리

### AuthService 인터페이스

```dart
abstract class AuthService {
  Stream<AuthState> get authStateStream;
  User? get currentUser;
  bool get isLoggedIn;

  Future<AuthResult> signInWithGoogle();
  Future<AuthResult> signInWithApple();
  Future<AuthResult> signInWithKakao();

  Future<void> signOut();

  Future<void> requestAccountDeletion();
  Future<void> cancelAccountDeletion();
}
```

### 앱 시작 시 체크 로직

```dart
Future<AuthState> checkAuthState() async {
  // 1. Supabase 세션 체크
  final session = supabase.auth.currentSession;
  if (session == null) return AuthState.unauthenticated;

  // 2. 토큰 만료 체크 (자동 갱신)
  if (session.isExpired) {
    final refreshed = await supabase.auth.refreshSession();
    if (refreshed.session == null) return AuthState.unauthenticated;
  }

  // 3. 프로필 완성 여부 체크
  final profile = await getProfile(session.user.id);
  if (profile == null || profile.nickname == null) {
    return AuthState.needsOnboarding;
  }

  // 4. 탈퇴 요청 상태 체크
  if (profile.isDeleted) return AuthState.unauthenticated;

  return AuthState.authenticated;
}
```

### 토큰 관리

- Access Token 만료 시 자동 갱신 (Supabase 처리)
- Refresh Token 저장 (secure storage, Supabase 처리)
- 세션 유지 (앱 재시작 시 자동 복구)

---

## 5. 계정 삭제

### 탈퇴 플로우

```
탈퇴 요청 → 확인 다이얼로그 → is_deleted = true
                           → deletion_requested_at = now()
                           → 로그아웃
                                │
                        ┌───────┴───────┐
                        ▼               ▼
                   [7일 내 복구]     [7일 후]
                        │               │
                        ▼               ▼
                    재로그인        영구 삭제
                    복구 완료      (Cron Job)
```

### Edge Function (자동 삭제)

```typescript
// 매일 실행
// 7일 지난 탈퇴 계정 영구 삭제
const { data: expiredUsers } = await supabase
  .from('user_profiles')
  .select('id')
  .eq('is_deleted', true)
  .lt('deletion_requested_at', new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toISOString())

for (const user of expiredUsers ?? []) {
  await supabase.auth.admin.deleteUser(user.id)
}
```

### 삭제되는 데이터 (CASCADE)

- auth.users
- user_profiles
- run_sessions
- run_track_points
- user_achievements
- user_challenges
- course_ratings

---

## 6. 권한 요청

### 권한 종류 및 시점

| 권한 | 필요 시점 | 필수 여부 |
|------|----------|----------|
| 위치 (foreground) | 러닝 시작 시 | 필수 |
| 위치 (background) | 러닝 시작 시 | 필수 |
| 알림 | 코칭 설정 시 | 선택 |
| 활동 인식 | 자동 일시정지 사용 시 | 선택 |

### 권한 요청 플로우

```
기능 사용 시도 → 권한 상태 체크 → [허용됨] → 진행
                              → [미요청/거부] → 설명 화면
                                                   │
                                              시스템 권한 요청
                                                   │
                                           ┌───────┴───────┐
                                           ▼               ▼
                                        [허용]          [거부]
                                           │               │
                                           ▼               ▼
                                         진행       기능 제한 안내
```

### 영구 거부 처리

- 설정 앱으로 이동 안내
- "다음에 할게요" 옵션 제공

---

## 7. 에러 처리

### 소셜 로그인 에러

| 상황 | 처리 |
|------|------|
| 사용자 취소 | 로그인 화면 유지, 메시지 없음 |
| 네트워크 오류 | "인터넷 연결을 확인해주세요" |
| 소셜 서버 오류 | "잠시 후 다시 시도해주세요" + 재시도 |
| 이미 다른 방식으로 가입 | "Google로 가입된 계정이에요" 안내 |

### 에러 코드 매핑

```dart
String getMessage(AuthException error) {
  return switch (error.code) {
    'invalid_credentials' => '로그인 정보가 올바르지 않아요',
    'user_not_found' => '가입되지 않은 계정이에요',
    'network_error' => '인터넷 연결을 확인해주세요',
    'too_many_requests' => '잠시 후 다시 시도해주세요',
    _ => '문제가 발생했어요. 다시 시도해주세요',
  };
}
```

---

## 8. 아키텍처

### 폴더 구조

```
lib/features/auth/
├── data/
│   ├── datasources/
│   │   └── auth_remote_datasource.dart
│   ├── models/
│   │   └── user_profile_model.dart
│   └── repositories/
│       └── auth_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── user_profile.dart
│   │   └── auth_state.dart
│   ├── repositories/
│   │   └── auth_repository.dart
│   └── usecases/
│       ├── sign_in_with_social.dart
│       ├── sign_out.dart
│       ├── check_auth_state.dart
│       ├── update_profile.dart
│       ├── request_account_deletion.dart
│       └── cancel_account_deletion.dart
└── presentation/
    ├── providers/
    │   ├── auth_providers.dart
    │   └── onboarding_provider.dart
    ├── screens/
    │   ├── login_screen.dart
    │   ├── onboarding_screen.dart
    │   └── account_settings_screen.dart
    └── widgets/
        ├── social_login_button.dart
        ├── nickname_input.dart
        ├── weight_picker.dart
        ├── goal_selector.dart
        └── permission_request_dialog.dart
```

### GoRouter 리다이렉트

```dart
GoRouter(
  redirect: (context, state) {
    final isLoggedIn = authState == AuthState.authenticated;
    final isOnboarding = authState == AuthState.needsOnboarding;

    if (!isLoggedIn && !isOnboarding) return '/login';
    if (isOnboarding) return '/onboarding';
    if (isLoggedIn && state.matchedLocation == '/login') return '/';

    return null;
  },
)
```

---

## 9. 테스트 전략

### 우선순위

| 우선순위 | 영역 | 이유 |
|----------|------|------|
| 🔴 높음 | AuthRepository | 인증 핵심 로직 |
| 🔴 높음 | NicknameValidator | 사용자 입력 검증 |
| 🟡 중간 | AccountDeletion | 법적 요구사항 |
| 🟡 중간 | OnboardingScreen | 첫 사용자 경험 |
| 🟢 낮음 | LoginScreen | 단순 UI |

### 주요 테스트 케이스

- 소셜 로그인 성공/실패
- 닉네임 유효성 검사
- 온보딩 단계 진행
- 계정 삭제 및 복구
- 세션 만료 및 갱신

---

## 기술 스택

| 영역 | 기술 |
|------|------|
| 인증 | Supabase Auth (OAuth) |
| 토큰 저장 | flutter_secure_storage (Supabase 내장) |
| 상태 관리 | Riverpod |
| 라우팅 | GoRouter (redirect) |
| 권한 | permission_handler |

---

## 다음 단계

1. 코스 추천 구현 완료 후 Auth 구현 진행
2. Git worktree로 격리된 작업 환경 생성
3. 구현 계획 상세 작성
