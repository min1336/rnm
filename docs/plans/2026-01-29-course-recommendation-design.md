# 러닝 코스 추천 시스템 설계

> 작성일: 2026-01-29
> 상태: 승인됨

## 개요

RunningMate 앱의 핵심 기능인 맞춤형 러닝 코스 추천 시스템 설계 문서입니다.

### 핵심 요구사항

- 위치 + 실력 + 목표를 복합적으로 고려한 추천
- 상황에 따라 우선순위 자동 감지, 애매하면 1-tap 확인
- 공식 코스 + 사용자 공유 코스 (자유 공유, 별점 필터링)
- 코스 정보는 기본만 (거리, 시간, 경로, 난이도)
- 실력은 러닝 기록에서 자동 산출, 신규 사용자는 10분 테스트
- 목표는 선택적
- 게이미피케이션: 업적/배지, 레벨/XP, 챌린지, 리더보드

---

## 1. 데이터 모델

### Course (코스)

```dart
class Course {
  String id;
  String name;
  String? description;

  // 경로 데이터
  List<LatLng> routePoints;      // 경로 좌표들
  double distanceKm;             // 총 거리
  int estimatedMinutes;          // 예상 소요 시간

  // 난이도 (1-5)
  int difficulty;

  // 메타데이터
  String creatorId;              // 생성자 (null이면 공식 코스)
  bool isOfficial;               // 공식 코스 여부
  double averageRating;          // 평균 별점
  int totalRuns;                 // 총 완주 횟수

  DateTime createdAt;
}
```

### UserRunningProfile (사용자 러닝 프로필)

```dart
class UserRunningProfile {
  String userId;

  // 자동 산출되는 실력 지표
  double averagePaceMinPerKm;    // 평균 페이스 (분/km)
  double averageDistanceKm;      // 평균 러닝 거리
  int weeklyRunCount;            // 주간 러닝 횟수
  int calculatedLevel;           // 산출된 레벨 (1-5)

  // 선택적 목표
  String? goal;                  // "marathon", "diet", "health", "stress" 등

  DateTime lastRunAt;
  DateTime levelUpdatedAt;
}
```

### RunHistory (러닝 기록)

```dart
class RunHistory {
  String id;
  String odString odString userId;
  String? courseId;              // 코스 러닝이면 ID, 자유 러닝이면 null

  double distanceKm;
  int durationMinutes;
  double paceMinPerKm;

  DateTime runAt;
}
```

### 게이미피케이션 엔티티

```dart
// 업적/배지
class Achievement {
  String id;
  String name;              // "첫 발걸음"
  String description;       // "첫 러닝 완료"
  String iconUrl;
  AchievementType type;     // distance, streak, speed, exploration
  int threshold;            // 달성 조건 수치
}

class UserAchievement {
  String odString odString userId;
  String achievementId;
  DateTime unlockedAt;
}

// 레벨/경험치
class UserLevel {
  String userId;
  int currentXp;
  int level;               // 1부터 시작
  int xpToNextLevel;       // 다음 레벨까지 필요 XP
}

// 챌린지
class Challenge {
  String id;
  String title;            // "이번 주 30km 도전"
  ChallengeType type;      // weekly, monthly, special
  int targetValue;         // 목표 수치
  String unit;             // "km", "runs", "minutes"
  DateTime startAt;
  DateTime endAt;
}

class UserChallenge {
  String userId;
  String challengeId;
  int currentProgress;
  bool isCompleted;
}

// 리더보드 (실시간 계산)
class LeaderboardEntry {
  String userId;
  String userName;
  double value;            // 거리 or 페이스
  int rank;
}
```

---

## 2. 추천 알고리즘

### 점수 계산 공식

각 코스는 0-100점으로 평가됩니다:

```
총점 = (거리점수 × W_거리) + (난이도점수 × W_난이도) + (목표점수 × W_목표) + (인기점수 × W_인기)
```

### 개별 점수 산출

**거리 점수 (0-100)**
- 사용자 현재 위치에서 코스 시작점까지의 거리 기반
- 1km 이내: 100점 → 10km 이상: 0점 (선형 감소)

**난이도 점수 (0-100)**
- 사용자 레벨과 코스 난이도 차이 기반
- 정확히 일치: 100점
- 1단계 차이: 70점, 2단계: 40점, 3단계 이상: 10점

**목표 점수 (0-100)**
- 목표 미설정 시: 모든 코스 50점 (중립)
- 목표 설정 시: 코스 특성과 목표 매칭

**인기 점수 (0-100)**
- 평균 별점 × 20 (5점 만점 → 100점)

### 상황별 가중치 조정

| 상황 | W_거리 | W_난이도 | W_목표 | W_인기 |
|------|--------|----------|--------|--------|
| 기본값 | 0.3 | 0.3 | 0.2 | 0.2 |
| "지금 바로 뛰고 싶어" | 0.5 | 0.2 | 0.1 | 0.2 |
| "훈련 모드" | 0.2 | 0.4 | 0.3 | 0.1 |
| "새로운 코스 탐험" | 0.3 | 0.2 | 0.1 | 0.4 |

### 상황 자동 감지 로직

```
if (시간 == 출근 전 or 점심) → "지금 바로" 모드
if (요일 == 주말 && 최근러닝 < 3일전) → "훈련" 모드
if (최근 같은 코스 3회 이상) → "새로운 코스" 모드
else → 기본값 + 1-tap 확인
```

---

## 3. 아키텍처

### 폴더 구조

```
lib/features/course/
├── data/
│   ├── datasources/
│   │   └── course_remote_datasource.dart
│   ├── models/
│   │   ├── course_model.dart
│   │   └── user_running_profile_model.dart
│   └── repositories/
│       └── course_repository_impl.dart
│
├── domain/
│   ├── entities/
│   │   ├── course.dart
│   │   └── user_running_profile.dart
│   ├── repositories/
│   │   └── course_repository.dart
│   └── usecases/
│       ├── get_recommended_courses.dart
│       ├── get_course_detail.dart
│       ├── share_course.dart
│       └── rate_course.dart
│
└── presentation/
    ├── providers/
    │   ├── course_providers.dart
    │   └── recommendation_provider.dart
    ├── screens/
    │   ├── course_list_screen.dart
    │   └── course_detail_screen.dart
    └── widgets/
        ├── course_card.dart
        ├── course_map_view.dart
        └── context_confirm_dialog.dart
```

### 핵심 컴포넌트

| 클래스 | 책임 |
|--------|------|
| `ContextDetector` | 시간/요일/패턴 분석 → 상황 판단 |
| `WeightCalculator` | 상황 → 가중치 반환 |
| `CourseScorer` | 코스 + 프로필 + 가중치 → 점수 |
| `RecommendationEngine` | 위 3개 조합하여 최종 추천 |

---

## 4. 데이터베이스 스키마 (Supabase)

### courses

```sql
create table courses (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  description text,

  route_points jsonb not null,
  distance_km decimal(5,2) not null,
  estimated_minutes int not null,
  difficulty int not null check (difficulty between 1 and 5),

  creator_id uuid references auth.users(id),
  is_official boolean default false,

  average_rating decimal(2,1) default 0,
  total_runs int default 0,

  created_at timestamptz default now()
);
```

### user_running_profiles

```sql
create table user_running_profiles (
  user_id uuid primary key references auth.users(id),

  average_pace_min_per_km decimal(4,2),
  average_distance_km decimal(5,2),
  weekly_run_count int default 0,
  calculated_level int default 1 check (calculated_level between 1 and 5),

  goal text,

  last_run_at timestamptz,
  level_updated_at timestamptz default now()
);
```

### run_histories

```sql
create table run_histories (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id),
  course_id uuid references courses(id),

  distance_km decimal(5,2) not null,
  duration_minutes int not null,
  pace_min_per_km decimal(4,2) not null,

  run_at timestamptz default now()
);
```

### course_ratings

```sql
create table course_ratings (
  id uuid primary key default gen_random_uuid(),
  course_id uuid not null references courses(id),
  user_id uuid not null references auth.users(id),

  rating int not null check (rating between 1 and 5),

  created_at timestamptz default now(),
  unique(course_id, user_id)
);
```

### 게이미피케이션 테이블

```sql
-- achievements
create table achievements (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  description text not null,
  icon_url text,

  type text not null,
  threshold int not null,
  xp_reward int default 50,

  created_at timestamptz default now()
);

-- user_achievements
create table user_achievements (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id),
  achievement_id uuid not null references achievements(id),

  unlocked_at timestamptz default now(),

  unique(user_id, achievement_id)
);

-- user_levels
create table user_levels (
  user_id uuid primary key references auth.users(id),

  current_xp int default 0,
  level int default 1,

  updated_at timestamptz default now()
);

-- challenges
create table challenges (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text,

  type text not null,
  target_value int not null,
  unit text not null,
  xp_reward int default 100,

  start_at timestamptz not null,
  end_at timestamptz not null,

  created_at timestamptz default now()
);

-- user_challenges
create table user_challenges (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id),
  challenge_id uuid not null references challenges(id),

  current_progress int default 0,
  is_completed boolean default false,
  completed_at timestamptz,

  joined_at timestamptz default now(),

  unique(user_id, challenge_id)
);

-- 주간 거리 리더보드 뷰
create view weekly_distance_leaderboard as
select
  user_id,
  sum(distance_km) as total_distance,
  rank() over (order by sum(distance_km) desc) as rank
from run_histories
where run_at >= date_trunc('week', now())
group by user_id;
```

### 인덱스

```sql
create index idx_courses_official on courses(is_official);
create index idx_courses_difficulty on courses(difficulty);
create index idx_run_histories_user on run_histories(user_id, run_at desc);
create index idx_user_achievements_user on user_achievements(user_id);
create index idx_user_challenges_user on user_challenges(user_id, is_completed);
create index idx_challenges_active on challenges(start_at, end_at);
```

---

## 5. UI/UX 플로우

### 메인 화면 진입 플로우

```
앱 시작 → 상황 자동 감지 → [확신 있음] → 바로 추천
                        → [불확실] → 1-tap 확인 → 추천
```

### 화면 구성

**코스 목록 화면**
- 상황 기반 헤더 ("출근 전 가볍게 뛰기 좋은")
- 코스 카드 리스트 (거리, 시간, 별점, 추천 이유)
- 빠른 필터 버튼 (근처/훈련/새로운)

**코스 상세 화면**
- Mapbox 지도에 경로 표시
- 코스 정보 (거리, 시간, 난이도, 별점)
- "이 코스로 달리기" CTA 버튼

**1-tap 확인 다이얼로그**
- "오늘은 가볍게 뛸까요?"
- [네] / [훈련할래요] 버튼

### 게이미피케이션 UI

**홈 화면**
- 레벨 + XP 바
- 스트릭 표시
- 진행 중인 챌린지

**러닝 완료 결과**
- 획득 XP
- 업적 달성 팝업
- 챌린지 진행률

**프로필 - 업적 탭**
- 업적 그리드 (달성/미달성)
- 상세 팝업

**리더보드**
- 주간/월간/내 주변 탭
- 순위 리스트 + 내 순위 하이라이트

---

## 6. 신규 사용자 온보딩

### 플로우

1. 환영 화면
2. 테스트 안내 (10분 자유 러닝)
3. 테스트 러닝 진행
4. 결과 및 레벨 산정

### 레벨 산정 기준

| 페이스 (분/km) | 레벨 | 등급명 |
|----------------|------|--------|
| 7:30 이상 | 1 | 입문자 |
| 6:30 ~ 7:30 | 2 | 초급 |
| 5:30 ~ 6:30 | 3 | 중급 |
| 4:30 ~ 5:30 | 4 | 고급 |
| 4:30 미만 | 5 | 엘리트 |

### 예외 처리

- 10분 전 중단: 5분 이상 시 측정 가능
- GPS 불안정: 시간 기준 완료, 페이스 추후 보정
- 테스트 건너뛰기: 레벨 3(중급) 시작, 자동 조정

---

## 7. 게이미피케이션 상세

### XP 획득 규칙

| 활동 | XP |
|------|-----|
| 러닝 완료 | 거리(km) × 10 |
| 코스 첫 완주 | +20 보너스 |
| 업적 달성 | +50 |
| 챌린지 완료 | +100 |

### 레벨 테이블

| 레벨 | 필요 누적 XP |
|------|-------------|
| 1 | 0 |
| 2 | 100 |
| 3 | 300 |
| 4 | 600 |
| 5 | 1000 |
| ... | +500씩 증가 |

### 업적 목록 (MVP)

**거리 업적**
- 첫 발걸음 (첫 러닝)
- 5K 러너 (누적 5km)
- 하프 마라토너 (누적 21km)
- 마라토너 (누적 42km)
- 100km 클럽 (누적 100km)

**연속 업적**
- 3일 연속
- 주간 전사 (7일 연속)
- 한 달 습관 (30일 연속)

**탐험 업적**
- 탐험가 (5개 코스 완주)
- 코스 마스터 (20개 코스 완주)
- 첫 공유 (코스 첫 공유)

### 챌린지

**주간** (매주 월요일 갱신)
- 이번 주 15km 달리기
- 이번 주 3회 러닝
- 새로운 코스 2개 도전

**월간** (매월 1일 갱신)
- 이번 달 50km 달리기
- 이번 달 10개 코스 완주

---

## 8. 에러 처리

### 네트워크/서버

| 상황 | 처리 |
|------|------|
| 코스 목록 로딩 실패 | 캐시된 코스 + 새로고침 버튼 |
| 추천 알고리즘 실패 | 인기순 폴백 |
| 평점 저장 실패 | 로컬 저장 후 동기화 |

### 위치 관련

| 상황 | 처리 |
|------|------|
| 위치 권한 거부 | 위치 점수 제외, 권한 요청 배너 |
| GPS 신호 약함 | 수동 위치 선택 옵션 |
| 주변 코스 없음 | 인기 코스 대신 표시 |

### 게이미피케이션

| 상황 | 처리 |
|------|------|
| 스트릭 자정 기준 | 사용자 타임존 기준 |
| 동점 순위 | 같은 순위 표시 (1, 1, 3) |
| XP 롤백 | XP 차감, 레벨 유지 |

---

## 9. 테스트 전략

### 단위 테스트 (우선순위 높음)

- `CourseScorer` - 추천 핵심 로직
- `XpCalculator` - 게임 경제 기반
- `ContextDetector` - 자동 감지 정확도
- `AchievementChecker` - 업적 판정

### 위젯 테스트

- `CourseCard` - 정보 표시
- `ContextConfirmDialog` - 1-tap 동작

### 통합 테스트

- 온보딩 → 테스트 러닝 → 추천 플로우
- 러닝 완료 → XP 획득 → 업적 달성 플로우

---

## 10. 기술 스택

### 클라이언트

| 영역 | 기술 |
|------|------|
| Framework | Flutter 3.x + Dart |
| IDE | Android Studio (+ VS Code) |
| 상태관리 | Riverpod |
| 지도 | Mapbox Maps Flutter |
| GPS | geolocator + permission_handler |
| 백그라운드 | flutter_background_geolocation |
| 로컬 캐시 | Hive 또는 Isar |

### 백엔드

| 영역 | 기술 |
|------|------|
| BaaS | Supabase |
| DB | PostgreSQL + PostGIS |
| 인증 | Supabase Auth |
| 스토리지 | Supabase Storage |
| 실시간 | Supabase Realtime |

### 부가 서비스

| 영역 | 기술 |
|------|------|
| 푸시 | Firebase Cloud Messaging |
| 분석 | Firebase Analytics |
| 크래시 | Firebase Crashlytics |

---

## 다음 단계

1. Git worktree로 격리된 작업 환경 생성
2. 구현 계획 상세 작성
3. 단계별 구현 진행
