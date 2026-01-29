# Auth 구현 계획

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Supabase Auth 기반 소셜 로그인(Google, Apple, 카카오) 및 온보딩 플로우 구현

**Architecture:** Clean Architecture - Domain(entities, usecases) → Data(datasources, repositories) → Presentation(providers, screens)

**Tech Stack:** Supabase Auth, Riverpod, GoRouter, Freezed

---

## Phase 1: Domain Layer - Entities & Repository Interface

### Task 1.1: AuthState enum 생성

**Files:**
- Create: `lib/features/auth/domain/entities/auth_state.dart`
- Test: `test/features/auth/domain/entities/auth_state_test.dart`

**Step 1: Write the failing test**

```dart
// test/features/auth/domain/entities/auth_state_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:runningmate/features/auth/domain/entities/auth_state.dart';

void main() {
  group('AuthState', () {
    test('should have initial state', () {
      expect(AuthState.initial.name, 'initial');
    });

    test('should have unauthenticated state', () {
      expect(AuthState.unauthenticated.name, 'unauthenticated');
    });

    test('should have needsOnboarding state', () {
      expect(AuthState.needsOnboarding.name, 'needsOnboarding');
    });

    test('should have authenticated state', () {
      expect(AuthState.authenticated.name, 'authenticated');
    });
  });
}
```

**Step 2: Run test to verify it fails**

Run: `flutter test test/features/auth/domain/entities/auth_state_test.dart`
Expected: FAIL - file not found

**Step 3: Write minimal implementation**

```dart
// lib/features/auth/domain/entities/auth_state.dart
enum AuthState {
  initial,        // 앱 초기화 중
  unauthenticated, // 로그인 필요
  needsOnboarding, // 프로필 설정 필요
  authenticated,   // 완전히 인증됨
}
```

**Step 4: Run test to verify it passes**

Run: `flutter test test/features/auth/domain/entities/auth_state_test.dart`
Expected: PASS

**Step 5: Commit**

```bash
git add lib/features/auth/domain/entities/auth_state.dart test/features/auth/domain/entities/auth_state_test.dart
git commit -m "feat(auth): add AuthState enum"
```

---

### Task 1.2: AuthProvider enum 생성

**Files:**
- Create: `lib/features/auth/domain/entities/auth_provider.dart`
- Test: `test/features/auth/domain/entities/auth_provider_test.dart`

**Step 1: Write the failing test**

```dart
// test/features/auth/domain/entities/auth_provider_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:runningmate/features/auth/domain/entities/auth_provider.dart';

void main() {
  group('AuthProvider', () {
    test('should have google provider', () {
      expect(AuthProvider.google.name, 'google');
    });

    test('should have apple provider', () {
      expect(AuthProvider.apple.name, 'apple');
    });

    test('should have kakao provider', () {
      expect(AuthProvider.kakao.name, 'kakao');
    });
  });
}
```

**Step 2: Run test to verify it fails**

Run: `flutter test test/features/auth/domain/entities/auth_provider_test.dart`
Expected: FAIL

**Step 3: Write minimal implementation**

```dart
// lib/features/auth/domain/entities/auth_provider.dart
enum AuthProvider {
  google,
  apple,
  kakao,
}
```

**Step 4: Run test to verify it passes**

Run: `flutter test test/features/auth/domain/entities/auth_provider_test.dart`
Expected: PASS

**Step 5: Commit**

```bash
git add lib/features/auth/domain/entities/auth_provider.dart test/features/auth/domain/entities/auth_provider_test.dart
git commit -m "feat(auth): add AuthProvider enum"
```

---

### Task 1.3: RunningGoal enum 생성

**Files:**
- Create: `lib/features/auth/domain/entities/running_goal.dart`
- Test: `test/features/auth/domain/entities/running_goal_test.dart`

**Step 1: Write the failing test**

```dart
// test/features/auth/domain/entities/running_goal_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:runningmate/features/auth/domain/entities/running_goal.dart';

void main() {
  group('RunningGoal', () {
    test('should have marathon goal with correct label', () {
      expect(RunningGoal.marathon.label, '마라톤 완주');
    });

    test('should have diet goal with correct label', () {
      expect(RunningGoal.diet.label, '다이어트');
    });

    test('should have fitness goal with correct label', () {
      expect(RunningGoal.fitness.label, '체력 향상');
    });

    test('should have stress goal with correct label', () {
      expect(RunningGoal.stress.label, '스트레스 해소');
    });
  });
}
```

**Step 2: Run test to verify it fails**

Run: `flutter test test/features/auth/domain/entities/running_goal_test.dart`
Expected: FAIL

**Step 3: Write minimal implementation**

```dart
// lib/features/auth/domain/entities/running_goal.dart
enum RunningGoal {
  marathon('마라톤 완주'),
  diet('다이어트'),
  fitness('체력 향상'),
  stress('스트레스 해소');

  final String label;
  const RunningGoal(this.label);
}
```

**Step 4: Run test to verify it passes**

Run: `flutter test test/features/auth/domain/entities/running_goal_test.dart`
Expected: PASS

**Step 5: Commit**

```bash
git add lib/features/auth/domain/entities/running_goal.dart test/features/auth/domain/entities/running_goal_test.dart
git commit -m "feat(auth): add RunningGoal enum with labels"
```

---

### Task 1.4: UserProfile entity (Freezed)

**Files:**
- Create: `lib/features/auth/domain/entities/user_profile.dart`
- Test: `test/features/auth/domain/entities/user_profile_test.dart`

**Step 1: Write the failing test**

```dart
// test/features/auth/domain/entities/user_profile_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:runningmate/features/auth/domain/entities/user_profile.dart';
import 'package:runningmate/features/auth/domain/entities/auth_provider.dart';
import 'package:runningmate/features/auth/domain/entities/running_goal.dart';

void main() {
  group('UserProfile', () {
    test('should create UserProfile with required fields', () {
      final profile = UserProfile(
        id: 'user-123',
        email: 'test@example.com',
        provider: AuthProvider.google,
        createdAt: DateTime(2026, 1, 29),
      );

      expect(profile.id, 'user-123');
      expect(profile.email, 'test@example.com');
      expect(profile.provider, AuthProvider.google);
      expect(profile.nickname, isNull);
    });

    test('should create UserProfile with optional fields', () {
      final profile = UserProfile(
        id: 'user-123',
        email: 'test@example.com',
        provider: AuthProvider.apple,
        createdAt: DateTime(2026, 1, 29),
        nickname: '러너킴',
        avatarUrl: 'https://example.com/avatar.jpg',
        weightKg: 70.5,
        goal: RunningGoal.marathon,
      );

      expect(profile.nickname, '러너킴');
      expect(profile.weightKg, 70.5);
      expect(profile.goal, RunningGoal.marathon);
    });

    test('should have isProfileComplete getter', () {
      final incompleteProfile = UserProfile(
        id: 'user-123',
        email: 'test@example.com',
        provider: AuthProvider.google,
        createdAt: DateTime(2026, 1, 29),
      );

      final completeProfile = UserProfile(
        id: 'user-123',
        email: 'test@example.com',
        provider: AuthProvider.google,
        createdAt: DateTime(2026, 1, 29),
        nickname: '러너킴',
      );

      expect(incompleteProfile.isProfileComplete, false);
      expect(completeProfile.isProfileComplete, true);
    });

    test('should support deletion state', () {
      final deletedProfile = UserProfile(
        id: 'user-123',
        email: 'test@example.com',
        provider: AuthProvider.google,
        createdAt: DateTime(2026, 1, 29),
        isDeleted: true,
        deletionRequestedAt: DateTime(2026, 1, 29),
      );

      expect(deletedProfile.isDeleted, true);
      expect(deletedProfile.deletionRequestedAt, isNotNull);
    });
  });
}
```

**Step 2: Run test to verify it fails**

Run: `flutter test test/features/auth/domain/entities/user_profile_test.dart`
Expected: FAIL

**Step 3: Write minimal implementation**

```dart
// lib/features/auth/domain/entities/user_profile.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'auth_provider.dart';
import 'running_goal.dart';

part 'user_profile.freezed.dart';

@freezed
class UserProfile with _$UserProfile {
  const UserProfile._();

  const factory UserProfile({
    required String id,
    required String email,
    String? nickname,
    String? avatarUrl,
    double? weightKg,
    RunningGoal? goal,
    required AuthProvider provider,
    required DateTime createdAt,
    DateTime? lastLoginAt,
    @Default(false) bool isDeleted,
    DateTime? deletionRequestedAt,
  }) = _UserProfile;

  bool get isProfileComplete => nickname != null && nickname!.isNotEmpty;
}
```

**Step 4: Run build_runner**

Run: `dart run build_runner build --delete-conflicting-outputs`

**Step 5: Run test to verify it passes**

Run: `flutter test test/features/auth/domain/entities/user_profile_test.dart`
Expected: PASS

**Step 6: Commit**

```bash
git add lib/features/auth/domain/entities/user_profile.dart lib/features/auth/domain/entities/user_profile.freezed.dart test/features/auth/domain/entities/user_profile_test.dart
git commit -m "feat(auth): add UserProfile entity with Freezed"
```

---

### Task 1.5: AuthRepository interface

**Files:**
- Create: `lib/features/auth/domain/repositories/auth_repository.dart`
- Test: N/A (interface only)

**Step 1: Write the interface**

```dart
// lib/features/auth/domain/repositories/auth_repository.dart
import '../entities/auth_provider.dart';
import '../entities/auth_state.dart' as app;
import '../entities/user_profile.dart';

abstract class AuthRepository {
  /// 현재 인증 상태 스트림
  Stream<app.AuthState> get authStateStream;

  /// 현재 사용자 프로필
  UserProfile? get currentUser;

  /// 로그인 여부
  bool get isLoggedIn;

  /// 소셜 로그인
  Future<UserProfile> signInWithProvider(AuthProvider provider);

  /// 로그아웃
  Future<void> signOut();

  /// 프로필 조회
  Future<UserProfile?> getProfile(String userId);

  /// 프로필 업데이트
  Future<UserProfile> updateProfile(UserProfile profile);

  /// 닉네임 중복 체크
  Future<bool> isNicknameAvailable(String nickname);

  /// 계정 삭제 요청
  Future<void> requestAccountDeletion();

  /// 계정 삭제 취소
  Future<void> cancelAccountDeletion();

  /// 인증 상태 체크
  Future<app.AuthState> checkAuthState();
}
```

**Step 2: Commit**

```bash
git add lib/features/auth/domain/repositories/auth_repository.dart
git commit -m "feat(auth): add AuthRepository interface"
```

---

## Phase 2: Domain Layer - Use Cases

### Task 2.1: SignInWithSocial use case

**Files:**
- Create: `lib/features/auth/domain/usecases/sign_in_with_social.dart`
- Test: `test/features/auth/domain/usecases/sign_in_with_social_test.dart`

**Step 1: Write the failing test**

```dart
// test/features/auth/domain/usecases/sign_in_with_social_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:runningmate/features/auth/domain/entities/auth_provider.dart';
import 'package:runningmate/features/auth/domain/entities/user_profile.dart';
import 'package:runningmate/features/auth/domain/repositories/auth_repository.dart';
import 'package:runningmate/features/auth/domain/usecases/sign_in_with_social.dart';

import 'sign_in_with_social_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late SignInWithSocial useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = SignInWithSocial(mockRepository);
  });

  group('SignInWithSocial', () {
    final testProfile = UserProfile(
      id: 'user-123',
      email: 'test@example.com',
      provider: AuthProvider.google,
      createdAt: DateTime(2026, 1, 29),
    );

    test('should call repository signInWithProvider', () async {
      when(mockRepository.signInWithProvider(AuthProvider.google))
          .thenAnswer((_) async => testProfile);

      final result = await useCase(AuthProvider.google);

      expect(result, testProfile);
      verify(mockRepository.signInWithProvider(AuthProvider.google)).called(1);
    });

    test('should work with different providers', () async {
      when(mockRepository.signInWithProvider(AuthProvider.apple))
          .thenAnswer((_) async => testProfile.copyWith(provider: AuthProvider.apple));

      final result = await useCase(AuthProvider.apple);

      expect(result.provider, AuthProvider.apple);
    });
  });
}
```

**Step 2: Run test to verify it fails**

Run: `flutter test test/features/auth/domain/usecases/sign_in_with_social_test.dart`
Expected: FAIL

**Step 3: Write minimal implementation**

```dart
// lib/features/auth/domain/usecases/sign_in_with_social.dart
import '../entities/auth_provider.dart';
import '../entities/user_profile.dart';
import '../repositories/auth_repository.dart';

class SignInWithSocial {
  final AuthRepository _repository;

  SignInWithSocial(this._repository);

  Future<UserProfile> call(AuthProvider provider) {
    return _repository.signInWithProvider(provider);
  }
}
```

**Step 4: Generate mocks and run test**

Run: `dart run build_runner build --delete-conflicting-outputs`
Run: `flutter test test/features/auth/domain/usecases/sign_in_with_social_test.dart`
Expected: PASS

**Step 5: Commit**

```bash
git add lib/features/auth/domain/usecases/sign_in_with_social.dart test/features/auth/domain/usecases/sign_in_with_social_test.dart test/features/auth/domain/usecases/sign_in_with_social_test.mocks.dart
git commit -m "feat(auth): add SignInWithSocial use case"
```

---

### Task 2.2: UpdateProfile use case

**Files:**
- Create: `lib/features/auth/domain/usecases/update_profile.dart`
- Test: `test/features/auth/domain/usecases/update_profile_test.dart`

**Step 1: Write the failing test**

```dart
// test/features/auth/domain/usecases/update_profile_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:runningmate/features/auth/domain/entities/auth_provider.dart';
import 'package:runningmate/features/auth/domain/entities/running_goal.dart';
import 'package:runningmate/features/auth/domain/entities/user_profile.dart';
import 'package:runningmate/features/auth/domain/repositories/auth_repository.dart';
import 'package:runningmate/features/auth/domain/usecases/update_profile.dart';

import 'update_profile_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late UpdateProfile useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = UpdateProfile(mockRepository);
  });

  group('UpdateProfile', () {
    final baseProfile = UserProfile(
      id: 'user-123',
      email: 'test@example.com',
      provider: AuthProvider.google,
      createdAt: DateTime(2026, 1, 29),
    );

    test('should update nickname', () async {
      final updatedProfile = baseProfile.copyWith(nickname: '러너킴');
      when(mockRepository.updateProfile(any))
          .thenAnswer((_) async => updatedProfile);

      final result = await useCase(
        profile: baseProfile,
        nickname: '러너킴',
      );

      expect(result.nickname, '러너킴');
    });

    test('should update weight', () async {
      final updatedProfile = baseProfile.copyWith(weightKg: 70.5);
      when(mockRepository.updateProfile(any))
          .thenAnswer((_) async => updatedProfile);

      final result = await useCase(
        profile: baseProfile,
        weightKg: 70.5,
      );

      expect(result.weightKg, 70.5);
    });

    test('should update goal', () async {
      final updatedProfile = baseProfile.copyWith(goal: RunningGoal.marathon);
      when(mockRepository.updateProfile(any))
          .thenAnswer((_) async => updatedProfile);

      final result = await useCase(
        profile: baseProfile,
        goal: RunningGoal.marathon,
      );

      expect(result.goal, RunningGoal.marathon);
    });
  });
}
```

**Step 2: Run test to verify it fails**

Run: `flutter test test/features/auth/domain/usecases/update_profile_test.dart`
Expected: FAIL

**Step 3: Write minimal implementation**

```dart
// lib/features/auth/domain/usecases/update_profile.dart
import '../entities/running_goal.dart';
import '../entities/user_profile.dart';
import '../repositories/auth_repository.dart';

class UpdateProfile {
  final AuthRepository _repository;

  UpdateProfile(this._repository);

  Future<UserProfile> call({
    required UserProfile profile,
    String? nickname,
    double? weightKg,
    RunningGoal? goal,
  }) {
    final updatedProfile = profile.copyWith(
      nickname: nickname ?? profile.nickname,
      weightKg: weightKg ?? profile.weightKg,
      goal: goal ?? profile.goal,
    );
    return _repository.updateProfile(updatedProfile);
  }
}
```

**Step 4: Generate mocks and run test**

Run: `dart run build_runner build --delete-conflicting-outputs`
Run: `flutter test test/features/auth/domain/usecases/update_profile_test.dart`
Expected: PASS

**Step 5: Commit**

```bash
git add lib/features/auth/domain/usecases/update_profile.dart test/features/auth/domain/usecases/update_profile_test.dart test/features/auth/domain/usecases/update_profile_test.mocks.dart
git commit -m "feat(auth): add UpdateProfile use case"
```

---

### Task 2.3: CheckAuthState use case

**Files:**
- Create: `lib/features/auth/domain/usecases/check_auth_state.dart`
- Test: `test/features/auth/domain/usecases/check_auth_state_test.dart`

**Step 1: Write the failing test**

```dart
// test/features/auth/domain/usecases/check_auth_state_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:runningmate/features/auth/domain/entities/auth_state.dart';
import 'package:runningmate/features/auth/domain/repositories/auth_repository.dart';
import 'package:runningmate/features/auth/domain/usecases/check_auth_state.dart';

import 'check_auth_state_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late CheckAuthState useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = CheckAuthState(mockRepository);
  });

  group('CheckAuthState', () {
    test('should return unauthenticated when no session', () async {
      when(mockRepository.checkAuthState())
          .thenAnswer((_) async => AuthState.unauthenticated);

      final result = await useCase();

      expect(result, AuthState.unauthenticated);
    });

    test('should return needsOnboarding when profile incomplete', () async {
      when(mockRepository.checkAuthState())
          .thenAnswer((_) async => AuthState.needsOnboarding);

      final result = await useCase();

      expect(result, AuthState.needsOnboarding);
    });

    test('should return authenticated when fully authenticated', () async {
      when(mockRepository.checkAuthState())
          .thenAnswer((_) async => AuthState.authenticated);

      final result = await useCase();

      expect(result, AuthState.authenticated);
    });
  });
}
```

**Step 2: Run test to verify it fails**

Run: `flutter test test/features/auth/domain/usecases/check_auth_state_test.dart`
Expected: FAIL

**Step 3: Write minimal implementation**

```dart
// lib/features/auth/domain/usecases/check_auth_state.dart
import '../entities/auth_state.dart';
import '../repositories/auth_repository.dart';

class CheckAuthState {
  final AuthRepository _repository;

  CheckAuthState(this._repository);

  Future<AuthState> call() {
    return _repository.checkAuthState();
  }
}
```

**Step 4: Generate mocks and run test**

Run: `dart run build_runner build --delete-conflicting-outputs`
Run: `flutter test test/features/auth/domain/usecases/check_auth_state_test.dart`
Expected: PASS

**Step 5: Commit**

```bash
git add lib/features/auth/domain/usecases/check_auth_state.dart test/features/auth/domain/usecases/check_auth_state_test.dart test/features/auth/domain/usecases/check_auth_state_test.mocks.dart
git commit -m "feat(auth): add CheckAuthState use case"
```

---

### Task 2.4: ValidateNickname use case

**Files:**
- Create: `lib/features/auth/domain/usecases/validate_nickname.dart`
- Test: `test/features/auth/domain/usecases/validate_nickname_test.dart`

**Step 1: Write the failing test**

```dart
// test/features/auth/domain/usecases/validate_nickname_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:runningmate/features/auth/domain/repositories/auth_repository.dart';
import 'package:runningmate/features/auth/domain/usecases/validate_nickname.dart';

import 'validate_nickname_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late ValidateNickname useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = ValidateNickname(mockRepository);
  });

  group('ValidateNickname', () {
    test('should return error for empty nickname', () async {
      final result = await useCase('');
      expect(result, NicknameValidationResult.empty);
    });

    test('should return error for too short nickname (< 2 chars)', () async {
      final result = await useCase('A');
      expect(result, NicknameValidationResult.tooShort);
    });

    test('should return error for too long nickname (> 10 chars)', () async {
      final result = await useCase('러너닉네임너무길어요');
      expect(result, NicknameValidationResult.tooLong);
    });

    test('should return error for invalid characters', () async {
      final result = await useCase('러너@킴');
      expect(result, NicknameValidationResult.invalidCharacters);
    });

    test('should return duplicate when nickname taken', () async {
      when(mockRepository.isNicknameAvailable('러너킴'))
          .thenAnswer((_) async => false);

      final result = await useCase('러너킴');
      expect(result, NicknameValidationResult.duplicate);
    });

    test('should return valid for available nickname', () async {
      when(mockRepository.isNicknameAvailable('러너킴'))
          .thenAnswer((_) async => true);

      final result = await useCase('러너킴');
      expect(result, NicknameValidationResult.valid);
    });

    test('should accept Korean characters', () async {
      when(mockRepository.isNicknameAvailable('한글닉네임'))
          .thenAnswer((_) async => true);

      final result = await useCase('한글닉네임');
      expect(result, NicknameValidationResult.valid);
    });

    test('should accept English characters', () async {
      when(mockRepository.isNicknameAvailable('Runner'))
          .thenAnswer((_) async => true);

      final result = await useCase('Runner');
      expect(result, NicknameValidationResult.valid);
    });

    test('should accept numbers', () async {
      when(mockRepository.isNicknameAvailable('러너123'))
          .thenAnswer((_) async => true);

      final result = await useCase('러너123');
      expect(result, NicknameValidationResult.valid);
    });
  });
}
```

**Step 2: Run test to verify it fails**

Run: `flutter test test/features/auth/domain/usecases/validate_nickname_test.dart`
Expected: FAIL

**Step 3: Write minimal implementation**

```dart
// lib/features/auth/domain/usecases/validate_nickname.dart
import '../repositories/auth_repository.dart';

enum NicknameValidationResult {
  valid,
  empty,
  tooShort,
  tooLong,
  invalidCharacters,
  duplicate,
}

class ValidateNickname {
  final AuthRepository _repository;

  // 한글, 영문, 숫자만 허용
  static final _validPattern = RegExp(r'^[가-힣a-zA-Z0-9]+$');
  static const _minLength = 2;
  static const _maxLength = 10;

  ValidateNickname(this._repository);

  Future<NicknameValidationResult> call(String nickname) async {
    // 빈 문자열 체크
    if (nickname.isEmpty) {
      return NicknameValidationResult.empty;
    }

    // 길이 체크
    if (nickname.length < _minLength) {
      return NicknameValidationResult.tooShort;
    }
    if (nickname.length > _maxLength) {
      return NicknameValidationResult.tooLong;
    }

    // 문자 패턴 체크
    if (!_validPattern.hasMatch(nickname)) {
      return NicknameValidationResult.invalidCharacters;
    }

    // 중복 체크
    final isAvailable = await _repository.isNicknameAvailable(nickname);
    if (!isAvailable) {
      return NicknameValidationResult.duplicate;
    }

    return NicknameValidationResult.valid;
  }
}
```

**Step 4: Generate mocks and run test**

Run: `dart run build_runner build --delete-conflicting-outputs`
Run: `flutter test test/features/auth/domain/usecases/validate_nickname_test.dart`
Expected: PASS

**Step 5: Commit**

```bash
git add lib/features/auth/domain/usecases/validate_nickname.dart test/features/auth/domain/usecases/validate_nickname_test.dart test/features/auth/domain/usecases/validate_nickname_test.mocks.dart
git commit -m "feat(auth): add ValidateNickname use case with validation rules"
```

---

### Task 2.5: RequestAccountDeletion use case

**Files:**
- Create: `lib/features/auth/domain/usecases/request_account_deletion.dart`
- Test: `test/features/auth/domain/usecases/request_account_deletion_test.dart`

**Step 1: Write the failing test**

```dart
// test/features/auth/domain/usecases/request_account_deletion_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:runningmate/features/auth/domain/repositories/auth_repository.dart';
import 'package:runningmate/features/auth/domain/usecases/request_account_deletion.dart';

import 'request_account_deletion_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late RequestAccountDeletion useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = RequestAccountDeletion(mockRepository);
  });

  group('RequestAccountDeletion', () {
    test('should call repository requestAccountDeletion', () async {
      when(mockRepository.requestAccountDeletion())
          .thenAnswer((_) async {});
      when(mockRepository.signOut())
          .thenAnswer((_) async {});

      await useCase();

      verify(mockRepository.requestAccountDeletion()).called(1);
      verify(mockRepository.signOut()).called(1);
    });
  });
}
```

**Step 2: Run test to verify it fails**

Run: `flutter test test/features/auth/domain/usecases/request_account_deletion_test.dart`
Expected: FAIL

**Step 3: Write minimal implementation**

```dart
// lib/features/auth/domain/usecases/request_account_deletion.dart
import '../repositories/auth_repository.dart';

class RequestAccountDeletion {
  final AuthRepository _repository;

  RequestAccountDeletion(this._repository);

  Future<void> call() async {
    await _repository.requestAccountDeletion();
    await _repository.signOut();
  }
}
```

**Step 4: Generate mocks and run test**

Run: `dart run build_runner build --delete-conflicting-outputs`
Run: `flutter test test/features/auth/domain/usecases/request_account_deletion_test.dart`
Expected: PASS

**Step 5: Commit**

```bash
git add lib/features/auth/domain/usecases/request_account_deletion.dart test/features/auth/domain/usecases/request_account_deletion_test.dart test/features/auth/domain/usecases/request_account_deletion_test.mocks.dart
git commit -m "feat(auth): add RequestAccountDeletion use case"
```

---

## Phase 3: Data Layer - Models & DataSource

### Task 3.1: UserProfileModel (JSON serialization)

**Files:**
- Create: `lib/features/auth/data/models/user_profile_model.dart`
- Test: `test/features/auth/data/models/user_profile_model_test.dart`

**Step 1: Write the failing test**

```dart
// test/features/auth/data/models/user_profile_model_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:runningmate/features/auth/data/models/user_profile_model.dart';
import 'package:runningmate/features/auth/domain/entities/auth_provider.dart';
import 'package:runningmate/features/auth/domain/entities/running_goal.dart';

void main() {
  group('UserProfileModel', () {
    final testJson = {
      'id': 'user-123',
      'email': 'test@example.com',
      'nickname': '러너킴',
      'avatar_url': 'https://example.com/avatar.jpg',
      'weight_kg': 70.5,
      'goal': 'marathon',
      'provider': 'google',
      'created_at': '2026-01-29T00:00:00.000Z',
      'last_login_at': '2026-01-29T12:00:00.000Z',
      'is_deleted': false,
      'deletion_requested_at': null,
    };

    test('should parse from JSON correctly', () {
      final model = UserProfileModel.fromJson(testJson);

      expect(model.id, 'user-123');
      expect(model.email, 'test@example.com');
      expect(model.nickname, '러너킴');
      expect(model.avatarUrl, 'https://example.com/avatar.jpg');
      expect(model.weightKg, 70.5);
      expect(model.goal, 'marathon');
      expect(model.provider, 'google');
    });

    test('should convert to entity correctly', () {
      final model = UserProfileModel.fromJson(testJson);
      final entity = model.toEntity();

      expect(entity.id, 'user-123');
      expect(entity.nickname, '러너킴');
      expect(entity.provider, AuthProvider.google);
      expect(entity.goal, RunningGoal.marathon);
    });

    test('should convert to JSON correctly', () {
      final model = UserProfileModel.fromJson(testJson);
      final json = model.toJson();

      expect(json['id'], 'user-123');
      expect(json['nickname'], '러너킴');
      expect(json['weight_kg'], 70.5);
    });

    test('should create from entity', () {
      final model = UserProfileModel.fromEntity(
        id: 'user-123',
        email: 'test@example.com',
        provider: AuthProvider.google,
        createdAt: DateTime(2026, 1, 29),
        nickname: '러너킴',
        weightKg: 70.5,
        goal: RunningGoal.marathon,
      );

      expect(model.id, 'user-123');
      expect(model.nickname, '러너킴');
      expect(model.goal, 'marathon');
    });
  });
}
```

**Step 2: Run test to verify it fails**

Run: `flutter test test/features/auth/data/models/user_profile_model_test.dart`
Expected: FAIL

**Step 3: Write minimal implementation**

```dart
// lib/features/auth/data/models/user_profile_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/auth_provider.dart';
import '../../domain/entities/running_goal.dart';
import '../../domain/entities/user_profile.dart';

part 'user_profile_model.freezed.dart';
part 'user_profile_model.g.dart';

@freezed
class UserProfileModel with _$UserProfileModel {
  const UserProfileModel._();

  const factory UserProfileModel({
    required String id,
    required String email,
    String? nickname,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'weight_kg') double? weightKg,
    String? goal,
    required String provider,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'last_login_at') DateTime? lastLoginAt,
    @JsonKey(name: 'is_deleted') @Default(false) bool isDeleted,
    @JsonKey(name: 'deletion_requested_at') DateTime? deletionRequestedAt,
  }) = _UserProfileModel;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  factory UserProfileModel.fromEntity({
    required String id,
    required String email,
    required AuthProvider provider,
    required DateTime createdAt,
    String? nickname,
    String? avatarUrl,
    double? weightKg,
    RunningGoal? goal,
    DateTime? lastLoginAt,
    bool isDeleted = false,
    DateTime? deletionRequestedAt,
  }) {
    return UserProfileModel(
      id: id,
      email: email,
      nickname: nickname,
      avatarUrl: avatarUrl,
      weightKg: weightKg,
      goal: goal?.name,
      provider: provider.name,
      createdAt: createdAt,
      lastLoginAt: lastLoginAt,
      isDeleted: isDeleted,
      deletionRequestedAt: deletionRequestedAt,
    );
  }

  UserProfile toEntity() {
    return UserProfile(
      id: id,
      email: email,
      nickname: nickname,
      avatarUrl: avatarUrl,
      weightKg: weightKg,
      goal: goal != null ? RunningGoal.values.byName(goal!) : null,
      provider: AuthProvider.values.byName(provider),
      createdAt: createdAt,
      lastLoginAt: lastLoginAt,
      isDeleted: isDeleted,
      deletionRequestedAt: deletionRequestedAt,
    );
  }
}
```

**Step 4: Run build_runner**

Run: `dart run build_runner build --delete-conflicting-outputs`

**Step 5: Run test to verify it passes**

Run: `flutter test test/features/auth/data/models/user_profile_model_test.dart`
Expected: PASS

**Step 6: Commit**

```bash
git add lib/features/auth/data/models/user_profile_model.dart lib/features/auth/data/models/user_profile_model.freezed.dart lib/features/auth/data/models/user_profile_model.g.dart test/features/auth/data/models/user_profile_model_test.dart
git commit -m "feat(auth): add UserProfileModel with JSON serialization"
```

---

### Task 3.2: AuthRemoteDataSource

**Files:**
- Create: `lib/features/auth/data/datasources/auth_remote_datasource.dart`
- Test: Integration test (later)

**Step 1: Write the implementation**

```dart
// lib/features/auth/data/datasources/auth_remote_datasource.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/auth_provider.dart' as app;
import '../models/user_profile_model.dart';

abstract class AuthRemoteDataSource {
  Stream<AuthState> get authStateStream;
  Session? get currentSession;
  User? get currentUser;

  Future<User> signInWithProvider(app.AuthProvider provider);
  Future<void> signOut();
  Future<UserProfileModel?> getProfile(String userId);
  Future<UserProfileModel> upsertProfile(UserProfileModel profile);
  Future<bool> isNicknameAvailable(String nickname);
  Future<void> requestAccountDeletion(String userId);
  Future<void> cancelAccountDeletion(String userId);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient _supabase;

  AuthRemoteDataSourceImpl(this._supabase);

  @override
  Stream<AuthState> get authStateStream =>
      _supabase.auth.onAuthStateChange.map((event) => event.session != null
          ? AuthState.authenticated
          : AuthState.unauthenticated);

  @override
  Session? get currentSession => _supabase.auth.currentSession;

  @override
  User? get currentUser => _supabase.auth.currentUser;

  @override
  Future<User> signInWithProvider(app.AuthProvider provider) async {
    final oAuthProvider = switch (provider) {
      app.AuthProvider.google => OAuthProvider.google,
      app.AuthProvider.apple => OAuthProvider.apple,
      app.AuthProvider.kakao => OAuthProvider.kakao,
    };

    final response = await _supabase.auth.signInWithOAuth(
      oAuthProvider,
      redirectTo: 'com.runningmate.app://callback',
    );

    if (!response) {
      throw Exception('OAuth sign in failed');
    }

    // Wait for auth state change
    await _supabase.auth.onAuthStateChange.firstWhere(
      (event) => event.session != null,
    );

    return _supabase.auth.currentUser!;
  }

  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  @override
  Future<UserProfileModel?> getProfile(String userId) async {
    final response = await _supabase
        .from('user_profiles')
        .select()
        .eq('id', userId)
        .maybeSingle();

    if (response == null) return null;
    return UserProfileModel.fromJson(response);
  }

  @override
  Future<UserProfileModel> upsertProfile(UserProfileModel profile) async {
    final response = await _supabase
        .from('user_profiles')
        .upsert(profile.toJson())
        .select()
        .single();

    return UserProfileModel.fromJson(response);
  }

  @override
  Future<bool> isNicknameAvailable(String nickname) async {
    final response = await _supabase
        .from('user_profiles')
        .select('id')
        .eq('nickname', nickname)
        .maybeSingle();

    return response == null;
  }

  @override
  Future<void> requestAccountDeletion(String userId) async {
    await _supabase.from('user_profiles').update({
      'is_deleted': true,
      'deletion_requested_at': DateTime.now().toIso8601String(),
    }).eq('id', userId);
  }

  @override
  Future<void> cancelAccountDeletion(String userId) async {
    await _supabase.from('user_profiles').update({
      'is_deleted': false,
      'deletion_requested_at': null,
    }).eq('id', userId);
  }
}
```

**Step 2: Commit**

```bash
git add lib/features/auth/data/datasources/auth_remote_datasource.dart
git commit -m "feat(auth): add AuthRemoteDataSource with Supabase integration"
```

---

### Task 3.3: AuthRepositoryImpl

**Files:**
- Create: `lib/features/auth/data/repositories/auth_repository_impl.dart`
- Test: `test/features/auth/data/repositories/auth_repository_impl_test.dart`

**Step 1: Write the failing test**

```dart
// test/features/auth/data/repositories/auth_repository_impl_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:runningmate/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:runningmate/features/auth/data/models/user_profile_model.dart';
import 'package:runningmate/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:runningmate/features/auth/domain/entities/auth_provider.dart';
import 'package:runningmate/features/auth/domain/entities/auth_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource, supabase.User])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(mockDataSource);
  });

  group('AuthRepositoryImpl', () {
    test('checkAuthState should return unauthenticated when no session', () async {
      when(mockDataSource.currentSession).thenReturn(null);

      final result = await repository.checkAuthState();

      expect(result, AuthState.unauthenticated);
    });

    test('checkAuthState should return needsOnboarding when profile incomplete', () async {
      final mockUser = MockUser();
      when(mockUser.id).thenReturn('user-123');
      when(mockUser.email).thenReturn('test@example.com');

      final mockSession = _createMockSession();
      when(mockDataSource.currentSession).thenReturn(mockSession);
      when(mockDataSource.currentUser).thenReturn(mockUser);

      final profileModel = UserProfileModel(
        id: 'user-123',
        email: 'test@example.com',
        provider: 'google',
        createdAt: DateTime(2026, 1, 29),
        nickname: null, // incomplete
      );
      when(mockDataSource.getProfile('user-123'))
          .thenAnswer((_) async => profileModel);

      final result = await repository.checkAuthState();

      expect(result, AuthState.needsOnboarding);
    });

    test('checkAuthState should return authenticated when profile complete', () async {
      final mockUser = MockUser();
      when(mockUser.id).thenReturn('user-123');
      when(mockUser.email).thenReturn('test@example.com');

      final mockSession = _createMockSession();
      when(mockDataSource.currentSession).thenReturn(mockSession);
      when(mockDataSource.currentUser).thenReturn(mockUser);

      final profileModel = UserProfileModel(
        id: 'user-123',
        email: 'test@example.com',
        provider: 'google',
        createdAt: DateTime(2026, 1, 29),
        nickname: '러너킴', // complete
      );
      when(mockDataSource.getProfile('user-123'))
          .thenAnswer((_) async => profileModel);

      final result = await repository.checkAuthState();

      expect(result, AuthState.authenticated);
    });

    test('isNicknameAvailable should delegate to datasource', () async {
      when(mockDataSource.isNicknameAvailable('러너킴'))
          .thenAnswer((_) async => true);

      final result = await repository.isNicknameAvailable('러너킴');

      expect(result, true);
      verify(mockDataSource.isNicknameAvailable('러너킴')).called(1);
    });
  });
}

// Helper to create mock session
supabase.Session _createMockSession() {
  // This is a simplified mock - in real tests you might need more setup
  return supabase.Session(
    accessToken: 'mock-token',
    tokenType: 'bearer',
    user: supabase.User(
      id: 'user-123',
      appMetadata: {},
      userMetadata: {},
      aud: 'authenticated',
      createdAt: DateTime.now().toIso8601String(),
    ),
  );
}
```

**Step 2: Run test to verify it fails**

Run: `flutter test test/features/auth/data/repositories/auth_repository_impl_test.dart`
Expected: FAIL

**Step 3: Write minimal implementation**

```dart
// lib/features/auth/data/repositories/auth_repository_impl.dart
import '../../domain/entities/auth_provider.dart' as app;
import '../../domain/entities/auth_state.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_profile_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _dataSource;
  UserProfile? _cachedProfile;

  AuthRepositoryImpl(this._dataSource);

  @override
  Stream<AuthState> get authStateStream =>
      _dataSource.authStateStream.asyncMap((_) => checkAuthState());

  @override
  UserProfile? get currentUser => _cachedProfile;

  @override
  bool get isLoggedIn => _dataSource.currentSession != null;

  @override
  Future<UserProfile> signInWithProvider(app.AuthProvider provider) async {
    final user = await _dataSource.signInWithProvider(provider);

    // Check if profile exists
    var profile = await _dataSource.getProfile(user.id);

    if (profile == null) {
      // Create new profile
      profile = UserProfileModel.fromEntity(
        id: user.id,
        email: user.email ?? '',
        provider: provider,
        createdAt: DateTime.now(),
        avatarUrl: user.userMetadata?['avatar_url'] as String?,
      );
      profile = await _dataSource.upsertProfile(profile);
    }

    _cachedProfile = profile.toEntity();
    return _cachedProfile!;
  }

  @override
  Future<void> signOut() async {
    await _dataSource.signOut();
    _cachedProfile = null;
  }

  @override
  Future<UserProfile?> getProfile(String userId) async {
    final profile = await _dataSource.getProfile(userId);
    if (profile == null) return null;
    _cachedProfile = profile.toEntity();
    return _cachedProfile;
  }

  @override
  Future<UserProfile> updateProfile(UserProfile profile) async {
    final model = UserProfileModel.fromEntity(
      id: profile.id,
      email: profile.email,
      provider: profile.provider,
      createdAt: profile.createdAt,
      nickname: profile.nickname,
      avatarUrl: profile.avatarUrl,
      weightKg: profile.weightKg,
      goal: profile.goal,
      lastLoginAt: profile.lastLoginAt,
      isDeleted: profile.isDeleted,
      deletionRequestedAt: profile.deletionRequestedAt,
    );

    final updated = await _dataSource.upsertProfile(model);
    _cachedProfile = updated.toEntity();
    return _cachedProfile!;
  }

  @override
  Future<bool> isNicknameAvailable(String nickname) {
    return _dataSource.isNicknameAvailable(nickname);
  }

  @override
  Future<void> requestAccountDeletion() async {
    final userId = _dataSource.currentUser?.id;
    if (userId == null) throw Exception('User not logged in');
    await _dataSource.requestAccountDeletion(userId);
  }

  @override
  Future<void> cancelAccountDeletion() async {
    final userId = _dataSource.currentUser?.id;
    if (userId == null) throw Exception('User not logged in');
    await _dataSource.cancelAccountDeletion(userId);
  }

  @override
  Future<AuthState> checkAuthState() async {
    // 1. Check session
    final session = _dataSource.currentSession;
    if (session == null) return AuthState.unauthenticated;

    // 2. Get user
    final user = _dataSource.currentUser;
    if (user == null) return AuthState.unauthenticated;

    // 3. Get profile
    final profile = await _dataSource.getProfile(user.id);

    // 4. Check profile completion
    if (profile == null || profile.nickname == null) {
      return AuthState.needsOnboarding;
    }

    // 5. Check deletion status
    if (profile.isDeleted) return AuthState.unauthenticated;

    _cachedProfile = profile.toEntity();
    return AuthState.authenticated;
  }
}
```

**Step 4: Generate mocks and run test**

Run: `dart run build_runner build --delete-conflicting-outputs`
Run: `flutter test test/features/auth/data/repositories/auth_repository_impl_test.dart`
Expected: PASS

**Step 5: Commit**

```bash
git add lib/features/auth/data/repositories/auth_repository_impl.dart test/features/auth/data/repositories/auth_repository_impl_test.dart test/features/auth/data/repositories/auth_repository_impl_test.mocks.dart
git commit -m "feat(auth): add AuthRepositoryImpl"
```

---

## Phase 4: Presentation Layer - Providers

### Task 4.1: Auth Providers (Riverpod)

**Files:**
- Create: `lib/features/auth/presentation/providers/auth_providers.dart`
- Test: `test/features/auth/presentation/providers/auth_providers_test.dart`

**Step 1: Write the failing test**

```dart
// test/features/auth/presentation/providers/auth_providers_test.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:runningmate/features/auth/domain/entities/auth_provider.dart';
import 'package:runningmate/features/auth/domain/entities/auth_state.dart';
import 'package:runningmate/features/auth/domain/entities/user_profile.dart';
import 'package:runningmate/features/auth/domain/repositories/auth_repository.dart';
import 'package:runningmate/features/auth/presentation/providers/auth_providers.dart';

import 'auth_providers_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository mockRepository;
  late ProviderContainer container;

  setUp(() {
    mockRepository = MockAuthRepository();
    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('authStateProvider', () {
    test('should return initial state initially', () async {
      when(mockRepository.checkAuthState())
          .thenAnswer((_) async => AuthState.unauthenticated);

      final authNotifier = container.read(authStateProvider.notifier);

      // Initial state
      expect(container.read(authStateProvider), AuthState.initial);
    });

    test('should update state after checkAuthState', () async {
      when(mockRepository.checkAuthState())
          .thenAnswer((_) async => AuthState.authenticated);

      final authNotifier = container.read(authStateProvider.notifier);
      await authNotifier.checkAuthState();

      expect(container.read(authStateProvider), AuthState.authenticated);
    });
  });

  group('signIn', () {
    test('should update state to authenticated after sign in', () async {
      final testProfile = UserProfile(
        id: 'user-123',
        email: 'test@example.com',
        provider: AuthProvider.google,
        createdAt: DateTime(2026, 1, 29),
        nickname: '러너킴',
      );

      when(mockRepository.signInWithProvider(AuthProvider.google))
          .thenAnswer((_) async => testProfile);

      final authNotifier = container.read(authStateProvider.notifier);
      await authNotifier.signIn(AuthProvider.google);

      expect(container.read(authStateProvider), AuthState.authenticated);
      expect(container.read(currentUserProvider), testProfile);
    });

    test('should update state to needsOnboarding for new user', () async {
      final testProfile = UserProfile(
        id: 'user-123',
        email: 'test@example.com',
        provider: AuthProvider.google,
        createdAt: DateTime(2026, 1, 29),
        // no nickname - needs onboarding
      );

      when(mockRepository.signInWithProvider(AuthProvider.google))
          .thenAnswer((_) async => testProfile);

      final authNotifier = container.read(authStateProvider.notifier);
      await authNotifier.signIn(AuthProvider.google);

      expect(container.read(authStateProvider), AuthState.needsOnboarding);
    });
  });
}
```

**Step 2: Run test to verify it fails**

Run: `flutter test test/features/auth/presentation/providers/auth_providers_test.dart`
Expected: FAIL

**Step 3: Write minimal implementation**

```dart
// lib/features/auth/presentation/providers/auth_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/auth_provider.dart' as app;
import '../../domain/entities/auth_state.dart' as app;
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_providers.g.dart';

// DataSource provider
@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  return AuthRemoteDataSourceImpl(Supabase.instance.client);
}

// Repository provider
@riverpod
AuthRepository authRepository(Ref ref) {
  final dataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(dataSource);
}

// Current user provider
@riverpod
class CurrentUser extends _$CurrentUser {
  @override
  UserProfile? build() => null;

  void setUser(UserProfile? user) {
    state = user;
  }
}

// Auth state notifier
@riverpod
class AuthStateNotifier extends _$AuthStateNotifier {
  @override
  app.AuthState build() => app.AuthState.initial;

  Future<void> checkAuthState() async {
    final repository = ref.read(authRepositoryProvider);
    final authState = await repository.checkAuthState();
    state = authState;

    if (authState == app.AuthState.authenticated) {
      ref.read(currentUserProvider.notifier).setUser(repository.currentUser);
    }
  }

  Future<void> signIn(app.AuthProvider provider) async {
    try {
      final repository = ref.read(authRepositoryProvider);
      final profile = await repository.signInWithProvider(provider);

      ref.read(currentUserProvider.notifier).setUser(profile);

      if (profile.isProfileComplete) {
        state = app.AuthState.authenticated;
      } else {
        state = app.AuthState.needsOnboarding;
      }
    } catch (e) {
      state = app.AuthState.unauthenticated;
      rethrow;
    }
  }

  Future<void> signOut() async {
    final repository = ref.read(authRepositoryProvider);
    await repository.signOut();
    ref.read(currentUserProvider.notifier).setUser(null);
    state = app.AuthState.unauthenticated;
  }

  void completeOnboarding(UserProfile profile) {
    ref.read(currentUserProvider.notifier).setUser(profile);
    state = app.AuthState.authenticated;
  }
}

// Legacy provider name for compatibility
final authStateProvider = authStateNotifierProvider;
```

**Step 4: Run build_runner**

Run: `dart run build_runner build --delete-conflicting-outputs`

**Step 5: Run test to verify it passes**

Run: `flutter test test/features/auth/presentation/providers/auth_providers_test.dart`
Expected: PASS

**Step 6: Commit**

```bash
git add lib/features/auth/presentation/providers/auth_providers.dart lib/features/auth/presentation/providers/auth_providers.g.dart test/features/auth/presentation/providers/auth_providers_test.dart test/features/auth/presentation/providers/auth_providers_test.mocks.dart
git commit -m "feat(auth): add Riverpod auth providers"
```

---

### Task 4.2: Onboarding Provider

**Files:**
- Create: `lib/features/auth/presentation/providers/onboarding_provider.dart`
- Test: `test/features/auth/presentation/providers/onboarding_provider_test.dart`

**Step 1: Write the failing test**

```dart
// test/features/auth/presentation/providers/onboarding_provider_test.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:runningmate/features/auth/domain/entities/auth_provider.dart';
import 'package:runningmate/features/auth/domain/entities/running_goal.dart';
import 'package:runningmate/features/auth/domain/entities/user_profile.dart';
import 'package:runningmate/features/auth/domain/repositories/auth_repository.dart';
import 'package:runningmate/features/auth/domain/usecases/validate_nickname.dart';
import 'package:runningmate/features/auth/presentation/providers/auth_providers.dart';
import 'package:runningmate/features/auth/presentation/providers/onboarding_provider.dart';

import 'onboarding_provider_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository mockRepository;
  late ProviderContainer container;

  final testProfile = UserProfile(
    id: 'user-123',
    email: 'test@example.com',
    provider: AuthProvider.google,
    createdAt: DateTime(2026, 1, 29),
  );

  setUp(() {
    mockRepository = MockAuthRepository();
    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockRepository),
        currentUserProvider.overrideWith((ref) => testProfile),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('OnboardingProvider', () {
    test('initial step should be 0', () {
      final state = container.read(onboardingProvider);
      expect(state.currentStep, 0);
    });

    test('should validate nickname', () async {
      when(mockRepository.isNicknameAvailable('러너킴'))
          .thenAnswer((_) async => true);

      final notifier = container.read(onboardingProvider.notifier);
      final result = await notifier.validateNickname('러너킴');

      expect(result, NicknameValidationResult.valid);
    });

    test('should update nickname and move to next step', () async {
      when(mockRepository.isNicknameAvailable('러너킴'))
          .thenAnswer((_) async => true);

      final notifier = container.read(onboardingProvider.notifier);
      await notifier.setNickname('러너킴');

      final state = container.read(onboardingProvider);
      expect(state.nickname, '러너킴');
      expect(state.currentStep, 1);
    });

    test('should update weight and move to next step', () {
      final notifier = container.read(onboardingProvider.notifier);
      notifier.setWeight(70.5);

      final state = container.read(onboardingProvider);
      expect(state.weightKg, 70.5);
      expect(state.currentStep, 2);
    });

    test('should update goal', () {
      final notifier = container.read(onboardingProvider.notifier);
      notifier.setGoal(RunningGoal.marathon);

      final state = container.read(onboardingProvider);
      expect(state.goal, RunningGoal.marathon);
    });

    test('should complete onboarding', () async {
      final updatedProfile = testProfile.copyWith(
        nickname: '러너킴',
        weightKg: 70.5,
        goal: RunningGoal.marathon,
      );

      when(mockRepository.updateProfile(any))
          .thenAnswer((_) async => updatedProfile);

      final notifier = container.read(onboardingProvider.notifier);

      // Set onboarding data
      when(mockRepository.isNicknameAvailable('러너킴'))
          .thenAnswer((_) async => true);
      await notifier.setNickname('러너킴');
      notifier.setWeight(70.5);
      notifier.setGoal(RunningGoal.marathon);

      final result = await notifier.completeOnboarding();

      expect(result.nickname, '러너킴');
      expect(result.weightKg, 70.5);
      expect(result.goal, RunningGoal.marathon);
    });
  });
}
```

**Step 2: Run test to verify it fails**

Run: `flutter test test/features/auth/presentation/providers/onboarding_provider_test.dart`
Expected: FAIL

**Step 3: Write minimal implementation**

```dart
// lib/features/auth/presentation/providers/onboarding_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/running_goal.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/usecases/validate_nickname.dart';
import 'auth_providers.dart';

part 'onboarding_provider.freezed.dart';
part 'onboarding_provider.g.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(0) int currentStep,
    String? nickname,
    double? weightKg,
    RunningGoal? goal,
    @Default(false) bool isLoading,
    String? error,
  }) = _OnboardingState;
}

@riverpod
class Onboarding extends _$Onboarding {
  late ValidateNickname _validateNickname;

  @override
  OnboardingState build() {
    final repository = ref.watch(authRepositoryProvider);
    _validateNickname = ValidateNickname(repository);
    return const OnboardingState();
  }

  Future<NicknameValidationResult> validateNickname(String nickname) {
    return _validateNickname(nickname);
  }

  Future<void> setNickname(String nickname) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await validateNickname(nickname);
    if (result != NicknameValidationResult.valid) {
      state = state.copyWith(
        isLoading: false,
        error: _getErrorMessage(result),
      );
      return;
    }

    state = state.copyWith(
      nickname: nickname,
      currentStep: 1,
      isLoading: false,
    );
  }

  void setWeight(double? weight) {
    state = state.copyWith(
      weightKg: weight,
      currentStep: 2,
    );
  }

  void setGoal(RunningGoal? goal) {
    state = state.copyWith(goal: goal);
  }

  void skipWeight() {
    state = state.copyWith(currentStep: 2);
  }

  void goBack() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  Future<UserProfile> completeOnboarding() async {
    state = state.copyWith(isLoading: true);

    final repository = ref.read(authRepositoryProvider);
    final currentUser = ref.read(currentUserProvider);

    if (currentUser == null) {
      throw Exception('User not logged in');
    }

    final updatedProfile = currentUser.copyWith(
      nickname: state.nickname,
      weightKg: state.weightKg,
      goal: state.goal,
    );

    final result = await repository.updateProfile(updatedProfile);

    ref.read(authStateNotifierProvider.notifier).completeOnboarding(result);
    state = state.copyWith(isLoading: false);

    return result;
  }

  String _getErrorMessage(NicknameValidationResult result) {
    return switch (result) {
      NicknameValidationResult.empty => '닉네임을 입력해주세요',
      NicknameValidationResult.tooShort => '닉네임은 2자 이상이어야 해요',
      NicknameValidationResult.tooLong => '닉네임은 10자 이하여야 해요',
      NicknameValidationResult.invalidCharacters => '한글, 영문, 숫자만 사용할 수 있어요',
      NicknameValidationResult.duplicate => '이미 사용 중인 닉네임이에요',
      NicknameValidationResult.valid => '',
    };
  }
}
```

**Step 4: Run build_runner**

Run: `dart run build_runner build --delete-conflicting-outputs`

**Step 5: Run test to verify it passes**

Run: `flutter test test/features/auth/presentation/providers/onboarding_provider_test.dart`
Expected: PASS

**Step 6: Commit**

```bash
git add lib/features/auth/presentation/providers/onboarding_provider.dart lib/features/auth/presentation/providers/onboarding_provider.freezed.dart lib/features/auth/presentation/providers/onboarding_provider.g.dart test/features/auth/presentation/providers/onboarding_provider_test.dart test/features/auth/presentation/providers/onboarding_provider_test.mocks.dart
git commit -m "feat(auth): add OnboardingProvider with step management"
```

---

## Phase 5: Presentation Layer - UI

### Task 5.1: SocialLoginButton widget

**Files:**
- Create: `lib/features/auth/presentation/widgets/social_login_button.dart`
- Test: `test/features/auth/presentation/widgets/social_login_button_test.dart`

**Step 1: Write the failing test**

```dart
// test/features/auth/presentation/widgets/social_login_button_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:runningmate/features/auth/domain/entities/auth_provider.dart';
import 'package:runningmate/features/auth/presentation/widgets/social_login_button.dart';

void main() {
  group('SocialLoginButton', () {
    testWidgets('should display Google login button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialLoginButton(
              provider: AuthProvider.google,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Google로 계속하기'), findsOneWidget);
    });

    testWidgets('should display Apple login button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialLoginButton(
              provider: AuthProvider.apple,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Apple로 계속하기'), findsOneWidget);
    });

    testWidgets('should display Kakao login button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialLoginButton(
              provider: AuthProvider.kakao,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('카카오로 계속하기'), findsOneWidget);
    });

    testWidgets('should call onPressed when tapped', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialLoginButton(
              provider: AuthProvider.google,
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(SocialLoginButton));
      expect(pressed, true);
    });

    testWidgets('should show loading indicator', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SocialLoginButton(
              provider: AuthProvider.google,
              onPressed: () {},
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
```

**Step 2: Run test to verify it fails**

Run: `flutter test test/features/auth/presentation/widgets/social_login_button_test.dart`
Expected: FAIL

**Step 3: Write minimal implementation**

```dart
// lib/features/auth/presentation/widgets/social_login_button.dart
import 'package:flutter/material.dart';
import '../../domain/entities/auth_provider.dart';

class SocialLoginButton extends StatelessWidget {
  final AuthProvider provider;
  final VoidCallback onPressed;
  final bool isLoading;

  const SocialLoginButton({
    super.key,
    required this.provider,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getConfig(provider);

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: config.backgroundColor,
          foregroundColor: config.foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: config.borderColor != null
                ? BorderSide(color: config.borderColor!)
                : BorderSide.none,
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: config.foregroundColor,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(config.icon, size: 24),
                  const SizedBox(width: 12),
                  Text(
                    config.label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  _ButtonConfig _getConfig(AuthProvider provider) {
    return switch (provider) {
      AuthProvider.google => _ButtonConfig(
          label: 'Google로 계속하기',
          icon: Icons.g_mobiledata,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          borderColor: Colors.grey[300],
        ),
      AuthProvider.apple => _ButtonConfig(
          label: 'Apple로 계속하기',
          icon: Icons.apple,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      AuthProvider.kakao => _ButtonConfig(
          label: '카카오로 계속하기',
          icon: Icons.chat_bubble,
          backgroundColor: const Color(0xFFFEE500),
          foregroundColor: Colors.black87,
        ),
    };
  }
}

class _ButtonConfig {
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;

  _ButtonConfig({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor,
  });
}
```

**Step 4: Run test to verify it passes**

Run: `flutter test test/features/auth/presentation/widgets/social_login_button_test.dart`
Expected: PASS

**Step 5: Commit**

```bash
git add lib/features/auth/presentation/widgets/social_login_button.dart test/features/auth/presentation/widgets/social_login_button_test.dart
git commit -m "feat(auth): add SocialLoginButton widget"
```

---

### Task 5.2: LoginScreen

**Files:**
- Create: `lib/features/auth/presentation/screens/login_screen.dart`
- Test: `test/features/auth/presentation/screens/login_screen_test.dart`

**Step 1: Write the failing test**

```dart
// test/features/auth/presentation/screens/login_screen_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:runningmate/features/auth/presentation/screens/login_screen.dart';

void main() {
  group('LoginScreen', () {
    testWidgets('should display app title', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      expect(find.text('RunningMate'), findsOneWidget);
    });

    testWidgets('should display all social login buttons', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      expect(find.text('Google로 계속하기'), findsOneWidget);
      expect(find.text('Apple로 계속하기'), findsOneWidget);
      expect(find.text('카카오로 계속하기'), findsOneWidget);
    });

    testWidgets('should display terms and privacy links', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      expect(find.text('이용약관'), findsOneWidget);
      expect(find.text('개인정보처리방침'), findsOneWidget);
    });
  });
}
```

**Step 2: Run test to verify it fails**

Run: `flutter test test/features/auth/presentation/screens/login_screen_test.dart`
Expected: FAIL

**Step 3: Write minimal implementation**

```dart
// lib/features/auth/presentation/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/auth_provider.dart';
import '../providers/auth_providers.dart';
import '../widgets/social_login_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  AuthProvider? _loadingProvider;

  Future<void> _signIn(AuthProvider provider) async {
    setState(() => _loadingProvider = provider);

    try {
      await ref.read(authStateNotifierProvider.notifier).signIn(provider);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_getErrorMessage(e))),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _loadingProvider = null);
      }
    }
  }

  String _getErrorMessage(Object error) {
    // TODO: Map specific errors to user-friendly messages
    return '로그인에 실패했어요. 다시 시도해주세요.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Logo and title
              Icon(
                Icons.directions_run,
                size: 80,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 16),
              Text(
                'RunningMate',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                '나에게 맞는 러닝 코스를 찾아보세요',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),

              const Spacer(flex: 2),

              // Social login buttons
              SocialLoginButton(
                provider: AuthProvider.google,
                onPressed: () => _signIn(AuthProvider.google),
                isLoading: _loadingProvider == AuthProvider.google,
              ),
              const SizedBox(height: 12),
              SocialLoginButton(
                provider: AuthProvider.apple,
                onPressed: () => _signIn(AuthProvider.apple),
                isLoading: _loadingProvider == AuthProvider.apple,
              ),
              const SizedBox(height: 12),
              SocialLoginButton(
                provider: AuthProvider.kakao,
                onPressed: () => _signIn(AuthProvider.kakao),
                isLoading: _loadingProvider == AuthProvider.kakao,
              ),

              const Spacer(),

              // Terms and privacy
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // TODO: Open terms
                    },
                    child: const Text('이용약관'),
                  ),
                  Text(
                    ' | ',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Open privacy policy
                    },
                    child: const Text('개인정보처리방침'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
```

**Step 4: Run test to verify it passes**

Run: `flutter test test/features/auth/presentation/screens/login_screen_test.dart`
Expected: PASS

**Step 5: Commit**

```bash
git add lib/features/auth/presentation/screens/login_screen.dart test/features/auth/presentation/screens/login_screen_test.dart
git commit -m "feat(auth): add LoginScreen with social login buttons"
```

---

### Task 5.3: OnboardingScreen

**Files:**
- Create: `lib/features/auth/presentation/screens/onboarding_screen.dart`
- Create: `lib/features/auth/presentation/widgets/nickname_input.dart`
- Create: `lib/features/auth/presentation/widgets/weight_picker.dart`
- Create: `lib/features/auth/presentation/widgets/goal_selector.dart`
- Test: `test/features/auth/presentation/screens/onboarding_screen_test.dart`

**Step 1: Write the failing test**

```dart
// test/features/auth/presentation/screens/onboarding_screen_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:runningmate/features/auth/domain/entities/auth_provider.dart';
import 'package:runningmate/features/auth/domain/entities/user_profile.dart';
import 'package:runningmate/features/auth/domain/repositories/auth_repository.dart';
import 'package:runningmate/features/auth/presentation/providers/auth_providers.dart';
import 'package:runningmate/features/auth/presentation/screens/onboarding_screen.dart';

import 'onboarding_screen_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository mockRepository;

  final testProfile = UserProfile(
    id: 'user-123',
    email: 'test@example.com',
    provider: AuthProvider.google,
    createdAt: DateTime(2026, 1, 29),
  );

  setUp(() {
    mockRepository = MockAuthRepository();
  });

  group('OnboardingScreen', () {
    testWidgets('should display nickname step initially', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authRepositoryProvider.overrideWithValue(mockRepository),
            currentUserProvider.overrideWith((ref) => testProfile),
          ],
          child: const MaterialApp(
            home: OnboardingScreen(),
          ),
        ),
      );

      expect(find.text('닉네임을 알려주세요'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('should display step indicator', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authRepositoryProvider.overrideWithValue(mockRepository),
            currentUserProvider.overrideWith((ref) => testProfile),
          ],
          child: const MaterialApp(
            home: OnboardingScreen(),
          ),
        ),
      );

      // Should show 3 step indicators
      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('should show next button', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authRepositoryProvider.overrideWithValue(mockRepository),
            currentUserProvider.overrideWith((ref) => testProfile),
          ],
          child: const MaterialApp(
            home: OnboardingScreen(),
          ),
        ),
      );

      expect(find.text('다음'), findsOneWidget);
    });
  });
}
```

**Step 2: Run test to verify it fails**

Run: `flutter test test/features/auth/presentation/screens/onboarding_screen_test.dart`
Expected: FAIL

**Step 3: Write implementations**

```dart
// lib/features/auth/presentation/widgets/nickname_input.dart
import 'package:flutter/material.dart';

class NicknameInput extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final bool isLoading;
  final ValueChanged<String>? onChanged;

  const NicknameInput({
    super.key,
    required this.controller,
    this.errorText,
    this.isLoading = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '닉네임을 알려주세요',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          '2-10자의 한글, 영문, 숫자만 사용할 수 있어요',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: controller,
          enabled: !isLoading,
          decoration: InputDecoration(
            hintText: '닉네임 입력',
            errorText: errorText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: isLoading
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : null,
          ),
          onChanged: onChanged,
          maxLength: 10,
        ),
      ],
    );
  }
}
```

```dart
// lib/features/auth/presentation/widgets/weight_picker.dart
import 'package:flutter/material.dart';

class WeightPicker extends StatelessWidget {
  final double? value;
  final ValueChanged<double?> onChanged;

  const WeightPicker({
    super.key,
    this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '체중을 알려주세요',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          '칼로리 계산에 사용돼요 (나중에 설정해도 돼요)',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 32),
        Center(
          child: Column(
            children: [
              Text(
                value != null ? '${value!.toStringAsFixed(1)} kg' : '-- kg',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),
              Slider(
                value: value ?? 60,
                min: 30,
                max: 200,
                divisions: 170,
                label: value?.toStringAsFixed(1),
                onChanged: (v) => onChanged(v),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => onChanged(null),
                child: const Text('건너뛰기'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
```

```dart
// lib/features/auth/presentation/widgets/goal_selector.dart
import 'package:flutter/material.dart';
import '../../domain/entities/running_goal.dart';

class GoalSelector extends StatelessWidget {
  final RunningGoal? value;
  final ValueChanged<RunningGoal?> onChanged;

  const GoalSelector({
    super.key,
    this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '러닝 목표가 있나요?',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          '목표에 맞는 코스를 추천해드려요 (선택사항)',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 24),
        ...RunningGoal.values.map((goal) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _GoalOption(
                goal: goal,
                isSelected: value == goal,
                onTap: () => onChanged(goal),
              ),
            )),
        const SizedBox(height: 8),
        Center(
          child: TextButton(
            onPressed: () => onChanged(null),
            child: const Text('목표 없이 시작하기'),
          ),
        ),
      ],
    );
  }
}

class _GoalOption extends StatelessWidget {
  final RunningGoal goal;
  final bool isSelected;
  final VoidCallback onTap;

  const _GoalOption({
    required this.goal,
    required this.isSelected,
    required this.onTap,
  });

  IconData get _icon => switch (goal) {
        RunningGoal.marathon => Icons.emoji_events,
        RunningGoal.diet => Icons.monitor_weight,
        RunningGoal.fitness => Icons.fitness_center,
        RunningGoal.stress => Icons.self_improvement,
      };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? Theme.of(context).primaryColor.withOpacity(0.1)
              : null,
        ),
        child: Row(
          children: [
            Icon(
              _icon,
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.grey[600],
            ),
            const SizedBox(width: 16),
            Text(
              goal.label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Theme.of(context).primaryColor,
              ),
          ],
        ),
      ),
    );
  }
}
```

```dart
// lib/features/auth/presentation/screens/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/nickname_input.dart';
import '../widgets/weight_picker.dart';
import '../widgets/goal_selector.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _nicknameController = TextEditingController();

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  Future<void> _handleNext() async {
    final notifier = ref.read(onboardingProvider.notifier);
    final state = ref.read(onboardingProvider);

    switch (state.currentStep) {
      case 0:
        await notifier.setNickname(_nicknameController.text);
        break;
      case 1:
        notifier.setWeight(state.weightKg);
        break;
      case 2:
        await _completeOnboarding();
        break;
    }
  }

  Future<void> _completeOnboarding() async {
    final notifier = ref.read(onboardingProvider.notifier);
    try {
      await notifier.completeOnboarding();
      // Navigation will be handled by router based on auth state
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('프로필 저장에 실패했어요: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingProvider);

    return Scaffold(
      appBar: AppBar(
        leading: state.currentStep > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () =>
                    ref.read(onboardingProvider.notifier).goBack(),
              )
            : null,
        title: _StepIndicator(currentStep: state.currentStep),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: _buildStepContent(state),
              ),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: state.isLoading ? null : _handleNext,
                  child: state.isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(state.currentStep == 2 ? '시작하기' : '다음'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent(OnboardingState state) {
    return switch (state.currentStep) {
      0 => NicknameInput(
          controller: _nicknameController,
          errorText: state.error,
          isLoading: state.isLoading,
        ),
      1 => WeightPicker(
          value: state.weightKg,
          onChanged: (v) {
            ref.read(onboardingProvider.notifier).setWeight(v);
          },
        ),
      2 => GoalSelector(
          value: state.goal,
          onChanged: (v) {
            ref.read(onboardingProvider.notifier).setGoal(v);
          },
        ),
      _ => const SizedBox.shrink(),
    };
  }
}

class _StepIndicator extends StatelessWidget {
  final int currentStep;

  const _StepIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        final isActive = index == currentStep;
        final isCompleted = index < currentStep;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive || isCompleted
                ? Theme.of(context).primaryColor
                : Colors.grey[300],
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        );
      }),
    );
  }
}
```

**Step 4: Run test to verify it passes**

Run: `flutter test test/features/auth/presentation/screens/onboarding_screen_test.dart`
Expected: PASS

**Step 5: Commit**

```bash
git add lib/features/auth/presentation/widgets/nickname_input.dart lib/features/auth/presentation/widgets/weight_picker.dart lib/features/auth/presentation/widgets/goal_selector.dart lib/features/auth/presentation/screens/onboarding_screen.dart test/features/auth/presentation/screens/onboarding_screen_test.dart test/features/auth/presentation/screens/onboarding_screen_test.mocks.dart
git commit -m "feat(auth): add OnboardingScreen with 3-step wizard"
```

---

## Phase 6: Router Integration

### Task 6.1: Update GoRouter with auth redirect

**Files:**
- Modify: `lib/app/routes.dart`
- Test: `test/app/routes_test.dart`

**Step 1: Write the failing test**

```dart
// test/app/routes_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:runningmate/app/routes.dart';
import 'package:runningmate/features/auth/domain/entities/auth_state.dart';
import 'package:runningmate/features/auth/presentation/providers/auth_providers.dart';

void main() {
  group('Router', () {
    testWidgets('should redirect to login when unauthenticated', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authStateNotifierProvider.overrideWith((ref) => AuthState.unauthenticated),
          ],
          child: MaterialApp.router(
            routerConfig: createRouter(AuthState.unauthenticated),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('RunningMate'), findsOneWidget); // Login screen
    });

    testWidgets('should redirect to onboarding when needsOnboarding', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authStateNotifierProvider.overrideWith((ref) => AuthState.needsOnboarding),
          ],
          child: MaterialApp.router(
            routerConfig: createRouter(AuthState.needsOnboarding),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('닉네임을 알려주세요'), findsOneWidget);
    });

    testWidgets('should show home when authenticated', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authStateNotifierProvider.overrideWith((ref) => AuthState.authenticated),
          ],
          child: MaterialApp.router(
            routerConfig: createRouter(AuthState.authenticated),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('오늘 추천 코스'), findsOneWidget); // Home screen
    });
  });
}
```

**Step 2: Run test to verify it fails**

Run: `flutter test test/app/routes_test.dart`
Expected: FAIL

**Step 3: Update routes.dart**

```dart
// lib/app/routes.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/domain/entities/auth_state.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/onboarding_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';

GoRouter createRouter(AuthState authState) {
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isLoggedIn = authState == AuthState.authenticated;
      final isOnboarding = authState == AuthState.needsOnboarding;
      final isLoggingIn = state.matchedLocation == '/login';
      final isOnboardingRoute = state.matchedLocation == '/onboarding';

      // Not authenticated -> login
      if (!isLoggedIn && !isOnboarding && !isLoggingIn) {
        return '/login';
      }

      // Needs onboarding -> onboarding
      if (isOnboarding && !isOnboardingRoute) {
        return '/onboarding';
      }

      // Authenticated but on login/onboarding -> home
      if (isLoggedIn && (isLoggingIn || isOnboardingRoute)) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
    ],
  );
}
```

**Step 4: Run test to verify it passes**

Run: `flutter test test/app/routes_test.dart`
Expected: PASS

**Step 5: Commit**

```bash
git add lib/app/routes.dart test/app/routes_test.dart
git commit -m "feat(auth): add GoRouter auth redirect logic"
```

---

### Task 6.2: Update app.dart to use auth-aware router

**Files:**
- Modify: `lib/app/app.dart`

**Step 1: Update app.dart**

```dart
// lib/app/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/app_theme.dart';
import '../features/auth/domain/entities/auth_state.dart';
import '../features/auth/presentation/providers/auth_providers.dart';
import 'routes.dart';

class RunningMateApp extends ConsumerStatefulWidget {
  const RunningMateApp({super.key});

  @override
  ConsumerState<RunningMateApp> createState() => _RunningMateAppState();
}

class _RunningMateAppState extends ConsumerState<RunningMateApp> {
  @override
  void initState() {
    super.initState();
    // Check auth state on app start
    Future.microtask(() {
      ref.read(authStateNotifierProvider.notifier).checkAuthState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateNotifierProvider);

    // Show loading while checking auth
    if (authState == AuthState.initial) {
      return MaterialApp(
        theme: AppTheme.light,
        home: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp.router(
      title: 'RunningMate',
      theme: AppTheme.light,
      routerConfig: createRouter(authState),
    );
  }
}
```

**Step 2: Commit**

```bash
git add lib/app/app.dart
git commit -m "feat(auth): integrate auth state with app router"
```

---

## Phase 7: Final Integration & Testing

### Task 7.1: Run all tests

**Step 1: Run all tests**

Run: `flutter test`
Expected: All tests pass

**Step 2: Run flutter analyze**

Run: `flutter analyze`
Expected: No issues

**Step 3: Final commit**

```bash
git add -A
git commit -m "feat(auth): complete auth module implementation"
```

---

## Summary

### Files Created

**Domain Layer:**
- `lib/features/auth/domain/entities/auth_state.dart`
- `lib/features/auth/domain/entities/auth_provider.dart`
- `lib/features/auth/domain/entities/running_goal.dart`
- `lib/features/auth/domain/entities/user_profile.dart`
- `lib/features/auth/domain/repositories/auth_repository.dart`
- `lib/features/auth/domain/usecases/sign_in_with_social.dart`
- `lib/features/auth/domain/usecases/update_profile.dart`
- `lib/features/auth/domain/usecases/check_auth_state.dart`
- `lib/features/auth/domain/usecases/validate_nickname.dart`
- `lib/features/auth/domain/usecases/request_account_deletion.dart`

**Data Layer:**
- `lib/features/auth/data/models/user_profile_model.dart`
- `lib/features/auth/data/datasources/auth_remote_datasource.dart`
- `lib/features/auth/data/repositories/auth_repository_impl.dart`

**Presentation Layer:**
- `lib/features/auth/presentation/providers/auth_providers.dart`
- `lib/features/auth/presentation/providers/onboarding_provider.dart`
- `lib/features/auth/presentation/widgets/social_login_button.dart`
- `lib/features/auth/presentation/widgets/nickname_input.dart`
- `lib/features/auth/presentation/widgets/weight_picker.dart`
- `lib/features/auth/presentation/widgets/goal_selector.dart`
- `lib/features/auth/presentation/screens/login_screen.dart`
- `lib/features/auth/presentation/screens/onboarding_screen.dart`

**Router:**
- `lib/app/routes.dart` (modified)
- `lib/app/app.dart` (modified)

### Commits (예상 17개)

1. feat(auth): add AuthState enum
2. feat(auth): add AuthProvider enum
3. feat(auth): add RunningGoal enum with labels
4. feat(auth): add UserProfile entity with Freezed
5. feat(auth): add AuthRepository interface
6. feat(auth): add SignInWithSocial use case
7. feat(auth): add UpdateProfile use case
8. feat(auth): add CheckAuthState use case
9. feat(auth): add ValidateNickname use case with validation rules
10. feat(auth): add RequestAccountDeletion use case
11. feat(auth): add UserProfileModel with JSON serialization
12. feat(auth): add AuthRemoteDataSource with Supabase integration
13. feat(auth): add AuthRepositoryImpl
14. feat(auth): add Riverpod auth providers
15. feat(auth): add OnboardingProvider with step management
16. feat(auth): add SocialLoginButton widget
17. feat(auth): add LoginScreen with social login buttons
18. feat(auth): add OnboardingScreen with 3-step wizard
19. feat(auth): add GoRouter auth redirect logic
20. feat(auth): integrate auth state with app router
21. feat(auth): complete auth module implementation
