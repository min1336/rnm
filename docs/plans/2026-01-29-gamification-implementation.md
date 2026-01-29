# 게이미피케이션 시스템 구현 계획

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** XP/레벨, 업적, 챌린지, 리더보드를 포함한 게이미피케이션 시스템 구현

**Architecture:** Clean Architecture (Domain → Data → Presentation) 레이어 순서로 구현. 핵심 서비스(XpCalculator, AchievementChecker, LevelCalculator, StreakCalculator)를 분리하여 단일 책임 원칙 준수. ProcessRunCompletion UseCase가 모든 게임 로직의 진입점.

**Tech Stack:** Flutter, Dart, Freezed, Riverpod, Supabase

**Design Document:** `docs/plans/2026-01-29-gamification-design.md`

---

## Phase 1: Domain Layer - Entities

### Task 1.1: Achievement Entity 생성

**Files:**
- Create: `lib/features/gamification/domain/entities/achievement.dart`
- Test: `test/features/gamification/domain/entities/achievement_test.dart`

**Step 1: 테스트 파일 생성**

```dart
// test/features/gamification/domain/entities/achievement_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/gamification/domain/entities/achievement.dart';

void main() {
  group('Achievement', () {
    test('should create Achievement with all fields', () {
      final achievement = Achievement(
        id: 'first_step',
        name: '첫 발걸음',
        description: '첫 러닝을 완료했습니다',
        iconName: 'footprints',
        category: AchievementCategory.distance,
        conditionType: ConditionType.firstRun,
        conditionValue: 1,
        xpReward: 50,
      );

      expect(achievement.id, 'first_step');
      expect(achievement.xpReward, 50);
      expect(achievement.category, AchievementCategory.distance);
    });
  });

  group('UserAchievement', () {
    test('should create UserAchievement with achievement', () {
      final achievement = Achievement(
        id: 'first_step',
        name: '첫 발걸음',
        description: '첫 러닝을 완료했습니다',
        iconName: 'footprints',
        category: AchievementCategory.distance,
        conditionType: ConditionType.firstRun,
        conditionValue: 1,
        xpReward: 50,
      );

      final userAchievement = UserAchievement(
        odString odString odString userId: 'user-1',
        achievementId: 'first_step',
        achievement: achievement,
        unlockedAt: DateTime(2026, 1, 29),
      );

      expect(userAchievement.odString odString odString odString userId, 'user-1');
      expect(userAchievement.achievement.name, '첫 발걸음');
    });
  });
}
```

**Step 2: 테스트 실패 확인**

Run: `flutter test test/features/gamification/domain/entities/achievement_test.dart`
Expected: FAIL - "Target of URI hasn't been generated"

**Step 3: Entity 구현**

```dart
// lib/features/gamification/domain/entities/achievement.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'achievement.freezed.dart';

enum AchievementCategory {
  distance,
  streak,
  exploration,
  speed,
  time,
  special,
}

enum ConditionType {
  firstRun,
  totalDistance,
  streakDays,
  courseCount,
  courseShare,
  pace,
  earlyRunCount,
  nightRunCount,
  singleDistance,
  weekendStreak,
}

@freezed
class Achievement with _$Achievement {
  const factory Achievement({
    required String id,
    required String name,
    required String description,
    required String iconName,
    required AchievementCategory category,
    required ConditionType conditionType,
    required int conditionValue,
    required int xpReward,
  }) = _Achievement;
}

@freezed
class UserAchievement with _$UserAchievement {
  const factory UserAchievement({
    required String odString odString odString userId,
    required String achievementId,
    required Achievement achievement,
    required DateTime unlockedAt,
  }) = _UserAchievement;
}
```

**Step 4: 코드 생성**

Run: `dart run build_runner build --delete-conflicting-outputs`

**Step 5: 테스트 통과 확인**

Run: `flutter test test/features/gamification/domain/entities/achievement_test.dart`
Expected: PASS

**Step 6: 커밋**

```bash
git add lib/features/gamification/domain/entities/achievement.dart lib/features/gamification/domain/entities/achievement.freezed.dart test/features/gamification/domain/entities/achievement_test.dart
git commit -m "feat(gamification): Achievement entity 추가"
```

---

### Task 1.2: UserLevel Entity 생성

**Files:**
- Create: `lib/features/gamification/domain/entities/user_level.dart`
- Test: `test/features/gamification/domain/entities/user_level_test.dart`

**Step 1: 테스트 파일 생성**

```dart
// test/features/gamification/domain/entities/user_level_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/gamification/domain/entities/user_level.dart';

void main() {
  group('UserLevel', () {
    test('should calculate progress percent correctly', () {
      final level = UserLevel(
        odString odString odString userId: 'user-1',
        currentXp: 150,
        level: 2,
        updatedAt: DateTime.now(),
      );

      // Level 2: 100 XP, Level 3: 200 XP
      // Progress: (150-100)/(200-100) = 50/100 = 0.5
      expect(level.xpForCurrentLevel, 100);
      expect(level.xpForNextLevel, 200);
      expect(level.xpProgress, 50);
      expect(level.progressPercent, 0.5);
    });

    test('should return correct level name', () {
      final level = UserLevel(
        odString odString odString userId: 'user-1',
        currentXp: 400,
        level: 5,
        updatedAt: DateTime.now(),
      );

      expect(level.levelName, '러너');
    });
  });
}
```

**Step 2: 테스트 실패 확인**

Run: `flutter test test/features/gamification/domain/entities/user_level_test.dart`
Expected: FAIL

**Step 3: Entity 구현**

```dart
// lib/features/gamification/domain/entities/user_level.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../services/level_calculator.dart';

part 'user_level.freezed.dart';

@freezed
class UserLevel with _$UserLevel {
  const UserLevel._();

  const factory UserLevel({
    required String odString odString odString userId,
    required int currentXp,
    required int level,
    required DateTime updatedAt,
  }) = _UserLevel;

  int get xpForCurrentLevel => LevelCalculator.getRequiredXp(level);
  int get xpForNextLevel => LevelCalculator.getRequiredXp(level + 1);
  int get xpProgress => currentXp - xpForCurrentLevel;
  int get xpNeeded => xpForNextLevel - xpForCurrentLevel;
  double get progressPercent => xpNeeded > 0 ? xpProgress / xpNeeded : 1.0;
  String get levelName => LevelCalculator.getLevelName(level);
}
```

**Step 4: LevelCalculator 서비스 생성 (의존성)**

```dart
// lib/features/gamification/domain/services/level_calculator.dart
class LevelCalculator {
  static const _levelNames = [
    '새싹 러너',
    '초보 러너',
    '러닝 입문자',
    '주니어 러너',
    '러너',
    '시니어 러너',
    '베테랑 러너',
    '엘리트 러너',
    '마스터 러너',
    '레전드 러너',
  ];

  static int getRequiredXp(int level) {
    if (level <= 1) return 0;
    if (level <= 5) return (level - 1) * 100;
    return 400 + (level - 5) * 500;
  }

  static int getLevelForXp(int xp) {
    int level = 1;
    while (getRequiredXp(level + 1) <= xp) {
      level++;
    }
    return level;
  }

  static String getLevelName(int level) {
    if (level <= 0) return _levelNames[0];
    if (level <= 10) return _levelNames[level - 1];
    final suffix = level - 9;
    return '레전드 러너 ${_toRoman(suffix)}';
  }

  static String _toRoman(int num) {
    const romans = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'];
    return num <= 10 ? romans[num - 1] : num.toString();
  }
}
```

**Step 5: 코드 생성**

Run: `dart run build_runner build --delete-conflicting-outputs`

**Step 6: 테스트 통과 확인**

Run: `flutter test test/features/gamification/domain/entities/user_level_test.dart`
Expected: PASS

**Step 7: 커밋**

```bash
git add lib/features/gamification/domain/entities/user_level.dart lib/features/gamification/domain/entities/user_level.freezed.dart lib/features/gamification/domain/services/level_calculator.dart test/features/gamification/domain/entities/user_level_test.dart
git commit -m "feat(gamification): UserLevel entity 및 LevelCalculator 추가"
```

---

### Task 1.3: Challenge Entity 생성

**Files:**
- Create: `lib/features/gamification/domain/entities/challenge.dart`
- Test: `test/features/gamification/domain/entities/challenge_test.dart`

**Step 1: 테스트 파일 생성**

```dart
// test/features/gamification/domain/entities/challenge_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/gamification/domain/entities/challenge.dart';

void main() {
  group('Challenge', () {
    test('should create weekly challenge', () {
      final challenge = Challenge(
        id: 'weekly-1',
        title: '이번 주 15km 달리기',
        type: ChallengeType.weekly,
        targetValue: 15,
        unit: 'km',
        xpReward: 100,
        startAt: DateTime(2026, 1, 27),
        endAt: DateTime(2026, 2, 2),
      );

      expect(challenge.type, ChallengeType.weekly);
      expect(challenge.targetValue, 15);
    });
  });

  group('UserChallenge', () {
    test('should calculate progress percent', () {
      final challenge = Challenge(
        id: 'weekly-1',
        title: '이번 주 15km 달리기',
        type: ChallengeType.weekly,
        targetValue: 15,
        unit: 'km',
        xpReward: 100,
        startAt: DateTime(2026, 1, 27),
        endAt: DateTime(2026, 2, 2),
      );

      final userChallenge = UserChallenge(
        odString odString odString userId: 'user-1',
        challengeId: 'weekly-1',
        challenge: challenge,
        currentProgress: 9,
        isCompleted: false,
        joinedAt: DateTime(2026, 1, 27),
      );

      expect(userChallenge.progressPercent, 0.6);
    });
  });
}
```

**Step 2: 테스트 실패 확인**

Run: `flutter test test/features/gamification/domain/entities/challenge_test.dart`
Expected: FAIL

**Step 3: Entity 구현**

```dart
// lib/features/gamification/domain/entities/challenge.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge.freezed.dart';

enum ChallengeType { weekly, monthly, special }

@freezed
class Challenge with _$Challenge {
  const factory Challenge({
    required String id,
    required String title,
    String? description,
    required ChallengeType type,
    required int targetValue,
    required String unit,
    required int xpReward,
    required DateTime startAt,
    required DateTime endAt,
  }) = _Challenge;
}

@freezed
class UserChallenge with _$UserChallenge {
  const UserChallenge._();

  const factory UserChallenge({
    required String odString odString odString userId,
    required String challengeId,
    required Challenge challenge,
    required int currentProgress,
    required bool isCompleted,
    DateTime? completedAt,
    required DateTime joinedAt,
  }) = _UserChallenge;

  double get progressPercent =>
      (currentProgress / challenge.targetValue).clamp(0.0, 1.0);

  bool get isExpired => DateTime.now().isAfter(challenge.endAt);
}
```

**Step 4: 코드 생성**

Run: `dart run build_runner build --delete-conflicting-outputs`

**Step 5: 테스트 통과 확인**

Run: `flutter test test/features/gamification/domain/entities/challenge_test.dart`
Expected: PASS

**Step 6: 커밋**

```bash
git add lib/features/gamification/domain/entities/challenge.dart lib/features/gamification/domain/entities/challenge.freezed.dart test/features/gamification/domain/entities/challenge_test.dart
git commit -m "feat(gamification): Challenge entity 추가"
```

---

### Task 1.4: UserStreak Entity 생성

**Files:**
- Create: `lib/features/gamification/domain/entities/user_streak.dart`
- Test: `test/features/gamification/domain/entities/user_streak_test.dart`

**Step 1: 테스트 파일 생성**

```dart
// test/features/gamification/domain/entities/user_streak_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/gamification/domain/entities/user_streak.dart';

void main() {
  group('UserStreak', () {
    test('should create streak with current and longest', () {
      final streak = UserStreak(
        odString odString odString userId: 'user-1',
        currentStreak: 5,
        longestStreak: 10,
        lastRunDate: DateTime(2026, 1, 29),
        updatedAt: DateTime.now(),
      );

      expect(streak.currentStreak, 5);
      expect(streak.longestStreak, 10);
    });
  });
}
```

**Step 2: 테스트 실패 확인**

Run: `flutter test test/features/gamification/domain/entities/user_streak_test.dart`
Expected: FAIL

**Step 3: Entity 구현**

```dart
// lib/features/gamification/domain/entities/user_streak.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_streak.freezed.dart';

@freezed
class UserStreak with _$UserStreak {
  const factory UserStreak({
    required String odString odString odString userId,
    required int currentStreak,
    required int longestStreak,
    DateTime? lastRunDate,
    required DateTime updatedAt,
  }) = _UserStreak;
}
```

**Step 4: 코드 생성**

Run: `dart run build_runner build --delete-conflicting-outputs`

**Step 5: 테스트 통과 확인**

Run: `flutter test test/features/gamification/domain/entities/user_streak_test.dart`
Expected: PASS

**Step 6: 커밋**

```bash
git add lib/features/gamification/domain/entities/user_streak.dart lib/features/gamification/domain/entities/user_streak.freezed.dart test/features/gamification/domain/entities/user_streak_test.dart
git commit -m "feat(gamification): UserStreak entity 추가"
```

---

### Task 1.5: LeaderboardEntry Entity 생성

**Files:**
- Create: `lib/features/gamification/domain/entities/leaderboard_entry.dart`
- Test: `test/features/gamification/domain/entities/leaderboard_entry_test.dart`

**Step 1: 테스트 파일 생성**

```dart
// test/features/gamification/domain/entities/leaderboard_entry_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/gamification/domain/entities/leaderboard_entry.dart';

void main() {
  group('LeaderboardEntry', () {
    test('should create entry with rank', () {
      final entry = LeaderboardEntry(
        odString odString odString userId: 'user-1',
        displayName: '김철수',
        totalDistance: 42.5,
        runCount: 8,
        rank: 1,
      );

      expect(entry.rank, 1);
      expect(entry.totalDistance, 42.5);
    });
  });
}
```

**Step 2: 테스트 실패 확인**

Run: `flutter test test/features/gamification/domain/entities/leaderboard_entry_test.dart`
Expected: FAIL

**Step 3: Entity 구현**

```dart
// lib/features/gamification/domain/entities/leaderboard_entry.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'leaderboard_entry.freezed.dart';

enum LeaderboardType { weeklyDistance, monthlyDistance }

@freezed
class LeaderboardEntry with _$LeaderboardEntry {
  const factory LeaderboardEntry({
    required String odString odString odString userId,
    required String displayName,
    String? avatarUrl,
    required double totalDistance,
    required int runCount,
    required int rank,
  }) = _LeaderboardEntry;
}
```

**Step 4: 코드 생성**

Run: `dart run build_runner build --delete-conflicting-outputs`

**Step 5: 테스트 통과 확인**

Run: `flutter test test/features/gamification/domain/entities/leaderboard_entry_test.dart`
Expected: PASS

**Step 6: 커밋**

```bash
git add lib/features/gamification/domain/entities/leaderboard_entry.dart lib/features/gamification/domain/entities/leaderboard_entry.freezed.dart test/features/gamification/domain/entities/leaderboard_entry_test.dart
git commit -m "feat(gamification): LeaderboardEntry entity 추가"
```

---

### Task 1.6: UserStats Entity 생성

**Files:**
- Create: `lib/features/gamification/domain/entities/user_stats.dart`
- Test: `test/features/gamification/domain/entities/user_stats_test.dart`

**Step 1: 테스트 파일 생성**

```dart
// test/features/gamification/domain/entities/user_stats_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/gamification/domain/entities/user_stats.dart';

void main() {
  group('UserStats', () {
    test('should create stats for achievement checking', () {
      final stats = UserStats(
        totalRuns: 10,
        totalDistanceKm: 45.5,
        currentStreak: 3,
        uniqueCourseCount: 5,
        sharedCourseCount: 1,
        earlyRunCount: 2,
        nightRunCount: 3,
        weekendStreak: 2,
      );

      expect(stats.totalRuns, 10);
      expect(stats.totalDistanceKm, 45.5);
    });
  });
}
```

**Step 2: 테스트 실패 확인**

Run: `flutter test test/features/gamification/domain/entities/user_stats_test.dart`
Expected: FAIL

**Step 3: Entity 구현**

```dart
// lib/features/gamification/domain/entities/user_stats.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_stats.freezed.dart';

@freezed
class UserStats with _$UserStats {
  const factory UserStats({
    required int totalRuns,
    required double totalDistanceKm,
    required int currentStreak,
    required int uniqueCourseCount,
    required int sharedCourseCount,
    required int earlyRunCount,
    required int nightRunCount,
    required int weekendStreak,
  }) = _UserStats;
}
```

**Step 4: 코드 생성**

Run: `dart run build_runner build --delete-conflicting-outputs`

**Step 5: 테스트 통과 확인**

Run: `flutter test test/features/gamification/domain/entities/user_stats_test.dart`
Expected: PASS

**Step 6: 커밋**

```bash
git add lib/features/gamification/domain/entities/user_stats.dart lib/features/gamification/domain/entities/user_stats.freezed.dart test/features/gamification/domain/entities/user_stats_test.dart
git commit -m "feat(gamification): UserStats entity 추가"
```

---

## Phase 2: Domain Layer - Services

### Task 2.1: LevelCalculator 테스트 보강

**Files:**
- Test: `test/features/gamification/domain/services/level_calculator_test.dart`

**Step 1: 테스트 파일 생성**

```dart
// test/features/gamification/domain/services/level_calculator_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/gamification/domain/services/level_calculator.dart';

void main() {
  group('LevelCalculator', () {
    group('getRequiredXp', () {
      test('should return 0 for level 1', () {
        expect(LevelCalculator.getRequiredXp(1), 0);
      });

      test('should return correct XP for levels 2-5', () {
        expect(LevelCalculator.getRequiredXp(2), 100);
        expect(LevelCalculator.getRequiredXp(3), 200);
        expect(LevelCalculator.getRequiredXp(4), 300);
        expect(LevelCalculator.getRequiredXp(5), 400);
      });

      test('should return correct XP for levels 6+', () {
        expect(LevelCalculator.getRequiredXp(6), 900);
        expect(LevelCalculator.getRequiredXp(7), 1400);
        expect(LevelCalculator.getRequiredXp(10), 2900);
      });
    });

    group('getLevelForXp', () {
      test('should return level 1 for 0 XP', () {
        expect(LevelCalculator.getLevelForXp(0), 1);
      });

      test('should return correct level for XP', () {
        expect(LevelCalculator.getLevelForXp(50), 1);
        expect(LevelCalculator.getLevelForXp(100), 2);
        expect(LevelCalculator.getLevelForXp(199), 2);
        expect(LevelCalculator.getLevelForXp(200), 3);
        expect(LevelCalculator.getLevelForXp(899), 5);
        expect(LevelCalculator.getLevelForXp(900), 6);
      });
    });

    group('getLevelName', () {
      test('should return correct names for levels 1-10', () {
        expect(LevelCalculator.getLevelName(1), '새싹 러너');
        expect(LevelCalculator.getLevelName(5), '러너');
        expect(LevelCalculator.getLevelName(10), '레전드 러너');
      });

      test('should return roman numeral suffix for levels 11+', () {
        expect(LevelCalculator.getLevelName(11), '레전드 러너 II');
        expect(LevelCalculator.getLevelName(12), '레전드 러너 III');
      });
    });
  });
}
```

**Step 2: 테스트 통과 확인**

Run: `flutter test test/features/gamification/domain/services/level_calculator_test.dart`
Expected: PASS

**Step 3: 커밋**

```bash
git add test/features/gamification/domain/services/level_calculator_test.dart
git commit -m "test(gamification): LevelCalculator 테스트 추가"
```

---

### Task 2.2: XpCalculator 구현

**Files:**
- Create: `lib/features/gamification/domain/services/xp_calculator.dart`
- Test: `test/features/gamification/domain/services/xp_calculator_test.dart`

**Step 1: 테스트 파일 생성**

```dart
// test/features/gamification/domain/services/xp_calculator_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/gamification/domain/services/xp_calculator.dart';

void main() {
  late XpCalculator calculator;

  setUp(() {
    calculator = XpCalculator();
  });

  group('XpCalculator', () {
    test('should calculate run XP based on distance', () {
      expect(calculator.calculateRunXp(distanceKm: 5.0), 50);
      expect(calculator.calculateRunXp(distanceKm: 3.2), 32);
      expect(calculator.calculateRunXp(distanceKm: 10.5), 105);
    });

    test('should return 20 for first course bonus', () {
      expect(calculator.firstCourseBonus, 20);
    });
  });
}
```

**Step 2: 테스트 실패 확인**

Run: `flutter test test/features/gamification/domain/services/xp_calculator_test.dart`
Expected: FAIL

**Step 3: 서비스 구현**

```dart
// lib/features/gamification/domain/services/xp_calculator.dart
class XpCalculator {
  int calculateRunXp({required double distanceKm}) {
    return (distanceKm * 10).round();
  }

  int get firstCourseBonus => 20;
}
```

**Step 4: 테스트 통과 확인**

Run: `flutter test test/features/gamification/domain/services/xp_calculator_test.dart`
Expected: PASS

**Step 5: 커밋**

```bash
git add lib/features/gamification/domain/services/xp_calculator.dart test/features/gamification/domain/services/xp_calculator_test.dart
git commit -m "feat(gamification): XpCalculator 구현"
```

---

### Task 2.3: StreakCalculator 구현

**Files:**
- Create: `lib/features/gamification/domain/services/streak_calculator.dart`
- Test: `test/features/gamification/domain/services/streak_calculator_test.dart`

**Step 1: 테스트 파일 생성**

```dart
// test/features/gamification/domain/services/streak_calculator_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/gamification/domain/entities/user_streak.dart';
import 'package:running_mate/features/gamification/domain/services/streak_calculator.dart';

void main() {
  late StreakCalculator calculator;

  setUp(() {
    calculator = StreakCalculator();
  });

  group('StreakCalculator', () {
    test('should start streak at 1 for first run', () {
      final current = UserStreak(
        odString odString odString userId: 'user-1',
        currentStreak: 0,
        longestStreak: 0,
        lastRunDate: null,
        updatedAt: DateTime.now(),
      );

      final result = calculator.updateStreak(
        current,
        DateTime(2026, 1, 29, 10, 0),  // KST
      );

      expect(result.currentStreak, 1);
      expect(result.longestStreak, 1);
    });

    test('should increment streak for consecutive day', () {
      final current = UserStreak(
        odString odString odString userId: 'user-1',
        currentStreak: 3,
        longestStreak: 5,
        lastRunDate: DateTime(2026, 1, 28),
        updatedAt: DateTime.now(),
      );

      final result = calculator.updateStreak(
        current,
        DateTime(2026, 1, 29, 10, 0),
      );

      expect(result.currentStreak, 4);
      expect(result.longestStreak, 5);
    });

    test('should reset streak when gap is more than 1 day', () {
      final current = UserStreak(
        odString odString odString userId: 'user-1',
        currentStreak: 5,
        longestStreak: 10,
        lastRunDate: DateTime(2026, 1, 26),
        updatedAt: DateTime.now(),
      );

      final result = calculator.updateStreak(
        current,
        DateTime(2026, 1, 29, 10, 0),
      );

      expect(result.currentStreak, 1);
      expect(result.longestStreak, 10);
    });

    test('should not change streak for same day run', () {
      final current = UserStreak(
        odString odString odString userId: 'user-1',
        currentStreak: 3,
        longestStreak: 5,
        lastRunDate: DateTime(2026, 1, 29),
        updatedAt: DateTime.now(),
      );

      final result = calculator.updateStreak(
        current,
        DateTime(2026, 1, 29, 18, 0),
      );

      expect(result.currentStreak, 3);
    });

    test('should update longest streak when current exceeds', () {
      final current = UserStreak(
        odString odString odString userId: 'user-1',
        currentStreak: 9,
        longestStreak: 9,
        lastRunDate: DateTime(2026, 1, 28),
        updatedAt: DateTime.now(),
      );

      final result = calculator.updateStreak(
        current,
        DateTime(2026, 1, 29, 10, 0),
      );

      expect(result.currentStreak, 10);
      expect(result.longestStreak, 10);
    });
  });
}
```

**Step 2: 테스트 실패 확인**

Run: `flutter test test/features/gamification/domain/services/streak_calculator_test.dart`
Expected: FAIL

**Step 3: 서비스 구현**

```dart
// lib/features/gamification/domain/services/streak_calculator.dart
import 'dart:math';
import '../entities/user_streak.dart';

class StreakCalculator {
  UserStreak updateStreak(UserStreak current, DateTime runAt) {
    final runDate = _toKstDate(runAt);
    final lastDate = current.lastRunDate != null
        ? _toKstDate(current.lastRunDate!)
        : null;

    // 같은 날 러닝 → 변화 없음
    if (lastDate != null && _isSameDay(runDate, lastDate)) {
      return current;
    }

    // 어제 러닝 → 스트릭 증가
    if (lastDate != null && _isConsecutiveDay(lastDate, runDate)) {
      final newStreak = current.currentStreak + 1;
      return current.copyWith(
        currentStreak: newStreak,
        longestStreak: max(current.longestStreak, newStreak),
        lastRunDate: runDate,
        updatedAt: DateTime.now(),
      );
    }

    // 그 외 (첫 러닝 또는 스트릭 끊김) → 1로 리셋
    return current.copyWith(
      currentStreak: 1,
      longestStreak: max(current.longestStreak, 1),
      lastRunDate: runDate,
      updatedAt: DateTime.now(),
    );
  }

  DateTime _toKstDate(DateTime dt) {
    final kst = dt.toUtc().add(const Duration(hours: 9));
    return DateTime(kst.year, kst.month, kst.day);
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _isConsecutiveDay(DateTime previous, DateTime current) {
    final diff = current.difference(previous).inDays;
    return diff == 1;
  }
}
```

**Step 4: 테스트 통과 확인**

Run: `flutter test test/features/gamification/domain/services/streak_calculator_test.dart`
Expected: PASS

**Step 5: 커밋**

```bash
git add lib/features/gamification/domain/services/streak_calculator.dart test/features/gamification/domain/services/streak_calculator_test.dart
git commit -m "feat(gamification): StreakCalculator 구현"
```

---

### Task 2.4: AchievementChecker 구현

**Files:**
- Create: `lib/features/gamification/domain/services/achievement_checker.dart`
- Create: `lib/features/gamification/domain/services/achievement_definitions.dart`
- Test: `test/features/gamification/domain/services/achievement_checker_test.dart`

**Step 1: 업적 정의 파일 생성**

```dart
// lib/features/gamification/domain/services/achievement_definitions.dart
import '../entities/achievement.dart';

final allAchievements = <Achievement>[
  // 거리
  const Achievement(
    id: 'first_step',
    name: '첫 발걸음',
    description: '첫 러닝을 완료했습니다',
    iconName: 'footprints',
    category: AchievementCategory.distance,
    conditionType: ConditionType.firstRun,
    conditionValue: 1,
    xpReward: 50,
  ),
  const Achievement(
    id: 'runner_5k',
    name: '5K 러너',
    description: '누적 5km를 달렸습니다',
    iconName: 'road',
    category: AchievementCategory.distance,
    conditionType: ConditionType.totalDistance,
    conditionValue: 5,
    xpReward: 50,
  ),
  const Achievement(
    id: 'half_marathon',
    name: '하프 마라토너',
    description: '누적 21km를 달렸습니다',
    iconName: 'medal',
    category: AchievementCategory.distance,
    conditionType: ConditionType.totalDistance,
    conditionValue: 21,
    xpReward: 100,
  ),
  const Achievement(
    id: 'full_marathon',
    name: '마라토너',
    description: '누적 42km를 달렸습니다',
    iconName: 'trophy',
    category: AchievementCategory.distance,
    conditionType: ConditionType.totalDistance,
    conditionValue: 42,
    xpReward: 150,
  ),
  const Achievement(
    id: 'century_club',
    name: '100km 클럽',
    description: '누적 100km를 달렸습니다',
    iconName: 'star',
    category: AchievementCategory.distance,
    conditionType: ConditionType.totalDistance,
    conditionValue: 100,
    xpReward: 300,
  ),
  // 연속
  const Achievement(
    id: 'streak_3',
    name: '3일 연속',
    description: '3일 연속으로 러닝했습니다',
    iconName: 'fire',
    category: AchievementCategory.streak,
    conditionType: ConditionType.streakDays,
    conditionValue: 3,
    xpReward: 50,
  ),
  const Achievement(
    id: 'weekly_warrior',
    name: '주간 전사',
    description: '7일 연속으로 러닝했습니다',
    iconName: 'flame',
    category: AchievementCategory.streak,
    conditionType: ConditionType.streakDays,
    conditionValue: 7,
    xpReward: 100,
  ),
  const Achievement(
    id: 'monthly_habit',
    name: '한 달 습관',
    description: '30일 연속으로 러닝했습니다',
    iconName: 'calendar_check',
    category: AchievementCategory.streak,
    conditionType: ConditionType.streakDays,
    conditionValue: 30,
    xpReward: 500,
  ),
  // 탐험
  const Achievement(
    id: 'explorer',
    name: '탐험가',
    description: '5개의 다른 코스를 완주했습니다',
    iconName: 'map',
    category: AchievementCategory.exploration,
    conditionType: ConditionType.courseCount,
    conditionValue: 5,
    xpReward: 50,
  ),
  const Achievement(
    id: 'course_master',
    name: '코스 마스터',
    description: '20개의 다른 코스를 완주했습니다',
    iconName: 'map_marked',
    category: AchievementCategory.exploration,
    conditionType: ConditionType.courseCount,
    conditionValue: 20,
    xpReward: 200,
  ),
  const Achievement(
    id: 'first_share',
    name: '첫 공유',
    description: '첫 코스를 공유했습니다',
    iconName: 'share',
    category: AchievementCategory.exploration,
    conditionType: ConditionType.courseShare,
    conditionValue: 1,
    xpReward: 50,
  ),
  // 속도
  const Achievement(
    id: 'pace_breaker_6',
    name: '6분 벽 돌파',
    description: '평균 페이스 6분/km 이하로 달렸습니다',
    iconName: 'speedometer',
    category: AchievementCategory.speed,
    conditionType: ConditionType.pace,
    conditionValue: 600,
    xpReward: 100,
  ),
  const Achievement(
    id: 'pace_breaker_5',
    name: '5분 벽 돌파',
    description: '평균 페이스 5분/km 이하로 달렸습니다',
    iconName: 'speedometer_fast',
    category: AchievementCategory.speed,
    conditionType: ConditionType.pace,
    conditionValue: 500,
    xpReward: 150,
  ),
  const Achievement(
    id: 'speed_demon',
    name: '스피드 데몬',
    description: '평균 페이스 4:30/km 이하로 달렸습니다',
    iconName: 'lightning',
    category: AchievementCategory.speed,
    conditionType: ConditionType.pace,
    conditionValue: 450,
    xpReward: 300,
  ),
  // 시간대
  const Achievement(
    id: 'early_bird',
    name: '얼리버드',
    description: '새벽 러닝 5회 완료',
    iconName: 'sunrise',
    category: AchievementCategory.time,
    conditionType: ConditionType.earlyRunCount,
    conditionValue: 5,
    xpReward: 100,
  ),
  const Achievement(
    id: 'night_owl',
    name: '나이트 올빼미',
    description: '야간 러닝 5회 완료',
    iconName: 'moon',
    category: AchievementCategory.time,
    conditionType: ConditionType.nightRunCount,
    conditionValue: 5,
    xpReward: 100,
  ),
  // 특별
  const Achievement(
    id: 'weekend_warrior',
    name: '주말 전사',
    description: '4주 연속 주말 러닝',
    iconName: 'weekend',
    category: AchievementCategory.special,
    conditionType: ConditionType.weekendStreak,
    conditionValue: 4,
    xpReward: 150,
  ),
  const Achievement(
    id: 'long_runner',
    name: '롱런 마스터',
    description: '한 번에 10km 이상 달리기',
    iconName: 'route',
    category: AchievementCategory.special,
    conditionType: ConditionType.singleDistance,
    conditionValue: 10,
    xpReward: 200,
  ),
];
```

**Step 2: 테스트 파일 생성**

```dart
// test/features/gamification/domain/services/achievement_checker_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/gamification/domain/entities/achievement.dart';
import 'package:running_mate/features/gamification/domain/entities/user_stats.dart';
import 'package:running_mate/features/gamification/domain/services/achievement_checker.dart';
import 'package:running_mate/features/gamification/domain/services/achievement_definitions.dart';

void main() {
  late AchievementChecker checker;

  setUp(() {
    checker = AchievementChecker(allAchievements);
  });

  group('AchievementChecker', () {
    test('should unlock first_step on first run', () {
      final stats = UserStats(
        totalRuns: 1,
        totalDistanceKm: 3.0,
        currentStreak: 1,
        uniqueCourseCount: 0,
        sharedCourseCount: 0,
        earlyRunCount: 0,
        nightRunCount: 0,
        weekendStreak: 0,
      );

      final newAchievements = checker.checkAfterRun(
        stats: stats,
        runDistanceKm: 3.0,
        runPaceMinPerKm: 6.5,
        unlockedIds: {},
      );

      expect(newAchievements.any((a) => a.id == 'first_step'), true);
    });

    test('should unlock runner_5k when total distance >= 5km', () {
      final stats = UserStats(
        totalRuns: 2,
        totalDistanceKm: 5.5,
        currentStreak: 2,
        uniqueCourseCount: 1,
        sharedCourseCount: 0,
        earlyRunCount: 0,
        nightRunCount: 0,
        weekendStreak: 0,
      );

      final newAchievements = checker.checkAfterRun(
        stats: stats,
        runDistanceKm: 3.0,
        runPaceMinPerKm: 6.5,
        unlockedIds: {'first_step'},
      );

      expect(newAchievements.any((a) => a.id == 'runner_5k'), true);
    });

    test('should unlock streak_3 when current streak >= 3', () {
      final stats = UserStats(
        totalRuns: 3,
        totalDistanceKm: 10.0,
        currentStreak: 3,
        uniqueCourseCount: 1,
        sharedCourseCount: 0,
        earlyRunCount: 0,
        nightRunCount: 0,
        weekendStreak: 0,
      );

      final newAchievements = checker.checkAfterRun(
        stats: stats,
        runDistanceKm: 3.0,
        runPaceMinPerKm: 6.5,
        unlockedIds: {'first_step', 'runner_5k'},
      );

      expect(newAchievements.any((a) => a.id == 'streak_3'), true);
    });

    test('should unlock pace_breaker_6 when pace <= 6:00', () {
      final stats = UserStats(
        totalRuns: 5,
        totalDistanceKm: 20.0,
        currentStreak: 1,
        uniqueCourseCount: 2,
        sharedCourseCount: 0,
        earlyRunCount: 0,
        nightRunCount: 0,
        weekendStreak: 0,
      );

      final newAchievements = checker.checkAfterRun(
        stats: stats,
        runDistanceKm: 5.0,
        runPaceMinPerKm: 5.5,
        unlockedIds: {'first_step', 'runner_5k'},
      );

      expect(newAchievements.any((a) => a.id == 'pace_breaker_6'), true);
    });

    test('should not unlock already unlocked achievement', () {
      final stats = UserStats(
        totalRuns: 1,
        totalDistanceKm: 3.0,
        currentStreak: 1,
        uniqueCourseCount: 0,
        sharedCourseCount: 0,
        earlyRunCount: 0,
        nightRunCount: 0,
        weekendStreak: 0,
      );

      final newAchievements = checker.checkAfterRun(
        stats: stats,
        runDistanceKm: 3.0,
        runPaceMinPerKm: 6.5,
        unlockedIds: {'first_step'},
      );

      expect(newAchievements.any((a) => a.id == 'first_step'), false);
    });

    test('should unlock long_runner for single run >= 10km', () {
      final stats = UserStats(
        totalRuns: 5,
        totalDistanceKm: 25.0,
        currentStreak: 1,
        uniqueCourseCount: 2,
        sharedCourseCount: 0,
        earlyRunCount: 0,
        nightRunCount: 0,
        weekendStreak: 0,
      );

      final newAchievements = checker.checkAfterRun(
        stats: stats,
        runDistanceKm: 10.5,
        runPaceMinPerKm: 6.0,
        unlockedIds: {'first_step'},
      );

      expect(newAchievements.any((a) => a.id == 'long_runner'), true);
    });
  });
}
```

**Step 3: 테스트 실패 확인**

Run: `flutter test test/features/gamification/domain/services/achievement_checker_test.dart`
Expected: FAIL

**Step 4: AchievementChecker 구현**

```dart
// lib/features/gamification/domain/services/achievement_checker.dart
import '../entities/achievement.dart';
import '../entities/user_stats.dart';

class AchievementChecker {
  final List<Achievement> _allAchievements;

  AchievementChecker(this._allAchievements);

  List<Achievement> checkAfterRun({
    required UserStats stats,
    required double runDistanceKm,
    required double runPaceMinPerKm,
    required Set<String> unlockedIds,
  }) {
    final newAchievements = <Achievement>[];

    for (final achievement in _allAchievements) {
      if (unlockedIds.contains(achievement.id)) continue;

      if (_checkCondition(achievement, stats, runDistanceKm, runPaceMinPerKm)) {
        newAchievements.add(achievement);
      }
    }

    return newAchievements;
  }

  bool _checkCondition(
    Achievement a,
    UserStats stats,
    double runDistanceKm,
    double runPaceMinPerKm,
  ) {
    return switch (a.conditionType) {
      ConditionType.firstRun => stats.totalRuns == 1,
      ConditionType.totalDistance => stats.totalDistanceKm >= a.conditionValue,
      ConditionType.streakDays => stats.currentStreak >= a.conditionValue,
      ConditionType.courseCount => stats.uniqueCourseCount >= a.conditionValue,
      ConditionType.courseShare => stats.sharedCourseCount >= a.conditionValue,
      ConditionType.pace => runPaceMinPerKm <= a.conditionValue / 100,
      ConditionType.earlyRunCount => stats.earlyRunCount >= a.conditionValue,
      ConditionType.nightRunCount => stats.nightRunCount >= a.conditionValue,
      ConditionType.singleDistance => runDistanceKm >= a.conditionValue,
      ConditionType.weekendStreak => stats.weekendStreak >= a.conditionValue,
    };
  }
}
```

**Step 5: 테스트 통과 확인**

Run: `flutter test test/features/gamification/domain/services/achievement_checker_test.dart`
Expected: PASS

**Step 6: 커밋**

```bash
git add lib/features/gamification/domain/services/achievement_checker.dart lib/features/gamification/domain/services/achievement_definitions.dart test/features/gamification/domain/services/achievement_checker_test.dart
git commit -m "feat(gamification): AchievementChecker 및 업적 정의 구현"
```

---

## Phase 3: Data Layer

### Task 3.1: GamificationRepository 인터페이스 정의

**Files:**
- Create: `lib/features/gamification/domain/repositories/gamification_repository.dart`

**Step 1: Repository 인터페이스 구현**

```dart
// lib/features/gamification/domain/repositories/gamification_repository.dart
import '../entities/achievement.dart';
import '../entities/challenge.dart';
import '../entities/leaderboard_entry.dart';
import '../entities/user_level.dart';
import '../entities/user_stats.dart';
import '../entities/user_streak.dart';

abstract class GamificationRepository {
  // Level
  Future<UserLevel> getUserLevel(String odString odString odString userId);
  Future<UserLevel> addXp(String odString odString odString userId, int xp);

  // Streak
  Future<UserStreak> getUserStreak(String odString odString odString userId);
  Future<void> saveUserStreak(UserStreak streak);

  // Achievements
  Future<List<Achievement>> getAllAchievements();
  Future<Set<String>> getUnlockedAchievementIds(String odString odString odString userId);
  Future<List<UserAchievement>> getUserAchievements(String odString odString odString userId);
  Future<void> unlockAchievement(String odString odString odString userId, String achievementId);

  // Stats
  Future<UserStats> getUserStats(String odString odString odString userId);
  Future<bool> isFirstCourseCompletion(String odString odString odString userId, String courseId);

  // Challenges
  Future<List<Challenge>> getActiveChallenges();
  Future<List<UserChallenge>> getUserChallenges(String odString odString odString userId);
  Future<void> joinChallenge(String odString odString odString userId, String challengeId);
  Future<List<UserChallenge>> updateChallengeProgress(
    String odString odString odString userId,
    double distanceKm,
    int durationMinutes,
    String? courseId,
  );

  // Leaderboard
  Future<List<LeaderboardEntry>> getLeaderboard(LeaderboardType type, {int limit = 100});
  Future<LeaderboardEntry?> getUserRank(String odString odString odString userId, LeaderboardType type);
}
```

**Step 2: 커밋**

```bash
git add lib/features/gamification/domain/repositories/gamification_repository.dart
git commit -m "feat(gamification): GamificationRepository 인터페이스 정의"
```

---

### Task 3.2: Gamification Models 생성

**Files:**
- Create: `lib/features/gamification/data/models/user_level_model.dart`
- Create: `lib/features/gamification/data/models/user_streak_model.dart`
- Create: `lib/features/gamification/data/models/challenge_model.dart`
- Create: `lib/features/gamification/data/models/leaderboard_entry_model.dart`

**Step 1: Models 구현**

```dart
// lib/features/gamification/data/models/user_level_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_level.dart';

part 'user_level_model.freezed.dart';
part 'user_level_model.g.dart';

@freezed
class UserLevelModel with _$UserLevelModel {
  const UserLevelModel._();

  const factory UserLevelModel({
    @JsonKey(name: 'user_id') required String odString odString odString userId,
    @JsonKey(name: 'current_xp') required int currentXp,
    required int level,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _UserLevelModel;

  factory UserLevelModel.fromJson(Map<String, dynamic> json) =>
      _$UserLevelModelFromJson(json);

  UserLevel toEntity() => UserLevel(
        odString odString odString userId: odString odString odString userId,
        currentXp: currentXp,
        level: level,
        updatedAt: DateTime.parse(updatedAt),
      );
}
```

```dart
// lib/features/gamification/data/models/user_streak_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_streak.dart';

part 'user_streak_model.freezed.dart';
part 'user_streak_model.g.dart';

@freezed
class UserStreakModel with _$UserStreakModel {
  const UserStreakModel._();

  const factory UserStreakModel({
    @JsonKey(name: 'user_id') required String odString odString odString userId,
    @JsonKey(name: 'current_streak') required int currentStreak,
    @JsonKey(name: 'longest_streak') required int longestStreak,
    @JsonKey(name: 'last_run_date') String? lastRunDate,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _UserStreakModel;

  factory UserStreakModel.fromJson(Map<String, dynamic> json) =>
      _$UserStreakModelFromJson(json);

  UserStreak toEntity() => UserStreak(
        odString odString odString userId: odString odString odString userId,
        currentStreak: currentStreak,
        longestStreak: longestStreak,
        lastRunDate: lastRunDate != null ? DateTime.parse(lastRunDate!) : null,
        updatedAt: DateTime.parse(updatedAt),
      );

  static UserStreakModel fromEntity(UserStreak entity) => UserStreakModel(
        odString odString odString userId: entity.odString odString odString userId,
        currentStreak: entity.currentStreak,
        longestStreak: entity.longestStreak,
        lastRunDate: entity.lastRunDate?.toIso8601String().split('T')[0],
        updatedAt: entity.updatedAt.toIso8601String(),
      );
}
```

```dart
// lib/features/gamification/data/models/challenge_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/challenge.dart';

part 'challenge_model.freezed.dart';
part 'challenge_model.g.dart';

@freezed
class ChallengeModel with _$ChallengeModel {
  const ChallengeModel._();

  const factory ChallengeModel({
    required String id,
    required String title,
    String? description,
    required String type,
    @JsonKey(name: 'target_value') required int targetValue,
    required String unit,
    @JsonKey(name: 'xp_reward') required int xpReward,
    @JsonKey(name: 'start_at') required String startAt,
    @JsonKey(name: 'end_at') required String endAt,
  }) = _ChallengeModel;

  factory ChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$ChallengeModelFromJson(json);

  Challenge toEntity() => Challenge(
        id: id,
        title: title,
        description: description,
        type: ChallengeType.values.firstWhere((t) => t.name == type),
        targetValue: targetValue,
        unit: unit,
        xpReward: xpReward,
        startAt: DateTime.parse(startAt),
        endAt: DateTime.parse(endAt),
      );
}

@freezed
class UserChallengeModel with _$UserChallengeModel {
  const UserChallengeModel._();

  const factory UserChallengeModel({
    @JsonKey(name: 'user_id') required String odString odString odString userId,
    @JsonKey(name: 'challenge_id') required String challengeId,
    required ChallengeModel challenge,
    @JsonKey(name: 'current_progress') required int currentProgress,
    @JsonKey(name: 'is_completed') required bool isCompleted,
    @JsonKey(name: 'completed_at') String? completedAt,
    @JsonKey(name: 'joined_at') required String joinedAt,
  }) = _UserChallengeModel;

  factory UserChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$UserChallengeModelFromJson(json);

  UserChallenge toEntity() => UserChallenge(
        odString odString odString userId: odString odString odString userId,
        challengeId: challengeId,
        challenge: challenge.toEntity(),
        currentProgress: currentProgress,
        isCompleted: isCompleted,
        completedAt: completedAt != null ? DateTime.parse(completedAt!) : null,
        joinedAt: DateTime.parse(joinedAt),
      );
}
```

```dart
// lib/features/gamification/data/models/leaderboard_entry_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/leaderboard_entry.dart';

part 'leaderboard_entry_model.freezed.dart';
part 'leaderboard_entry_model.g.dart';

@freezed
class LeaderboardEntryModel with _$LeaderboardEntryModel {
  const LeaderboardEntryModel._();

  const factory LeaderboardEntryModel({
    @JsonKey(name: 'user_id') required String odString odString odString userId,
    @JsonKey(name: 'display_name') required String displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'total_distance') required double totalDistance,
    @JsonKey(name: 'run_count') required int runCount,
    required int rank,
  }) = _LeaderboardEntryModel;

  factory LeaderboardEntryModel.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardEntryModelFromJson(json);

  LeaderboardEntry toEntity() => LeaderboardEntry(
        odString odString odString userId: odString odString odString userId,
        displayName: displayName,
        avatarUrl: avatarUrl,
        totalDistance: totalDistance,
        runCount: runCount,
        rank: rank,
      );
}
```

**Step 2: 코드 생성**

Run: `dart run build_runner build --delete-conflicting-outputs`

**Step 3: 커밋**

```bash
git add lib/features/gamification/data/models/
git commit -m "feat(gamification): Data models 추가"
```

---

### Task 3.3: GamificationRemoteDataSource 구현

**Files:**
- Create: `lib/features/gamification/data/datasources/gamification_remote_datasource.dart`

**Step 1: DataSource 구현**

```dart
// lib/features/gamification/data/datasources/gamification_remote_datasource.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/challenge_model.dart';
import '../models/leaderboard_entry_model.dart';
import '../models/user_level_model.dart';
import '../models/user_streak_model.dart';
import '../../domain/entities/leaderboard_entry.dart';

class GamificationRemoteDataSource {
  final SupabaseClient _client;

  GamificationRemoteDataSource(this._client);

  // Level
  Future<UserLevelModel?> getUserLevel(String odString odString odString userId) async {
    final response = await _client
        .from('user_levels')
        .select()
        .eq('user_id', odString odString odString userId)
        .maybeSingle();
    if (response == null) return null;
    return UserLevelModel.fromJson(response);
  }

  Future<UserLevelModel> upsertUserLevel({
    required String odString odString odString userId,
    required int currentXp,
    required int level,
  }) async {
    final response = await _client
        .from('user_levels')
        .upsert({
          'user_id': odString odString odString userId,
          'current_xp': currentXp,
          'level': level,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .select()
        .single();
    return UserLevelModel.fromJson(response);
  }

  // Streak
  Future<UserStreakModel?> getUserStreak(String odString odString odString userId) async {
    final response = await _client
        .from('user_streaks')
        .select()
        .eq('user_id', odString odString odString userId)
        .maybeSingle();
    if (response == null) return null;
    return UserStreakModel.fromJson(response);
  }

  Future<void> upsertUserStreak(UserStreakModel streak) async {
    await _client.from('user_streaks').upsert(streak.toJson());
  }

  // Achievements
  Future<List<Map<String, dynamic>>> getAllAchievements() async {
    final response = await _client.from('achievements').select();
    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<String>> getUnlockedAchievementIds(String odString odString odString userId) async {
    final response = await _client
        .from('user_achievements')
        .select('achievement_id')
        .eq('user_id', odString odString odString userId);
    return (response as List).map((r) => r['achievement_id'] as String).toList();
  }

  Future<List<Map<String, dynamic>>> getUserAchievements(String odString odString odString userId) async {
    final response = await _client
        .from('user_achievements')
        .select('*, achievement:achievements(*)')
        .eq('user_id', odString odString odString userId);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> insertUserAchievement(String odString odString odString userId, String achievementId) async {
    await _client.from('user_achievements').insert({
      'user_id': odString odString odString userId,
      'achievement_id': achievementId,
    });
  }

  // Stats
  Future<Map<String, dynamic>> getUserStats(String odString odString odString userId) async {
    // 여러 쿼리를 조합하여 통계 생성
    final totalRuns = await _client
        .from('run_histories')
        .select()
        .eq('user_id', odString odString odString userId)
        .count(CountOption.exact);

    final distanceResult = await _client
        .from('run_histories')
        .select('distance_km')
        .eq('user_id', odString odString odString userId);

    final totalDistance = (distanceResult as List)
        .fold<double>(0, (sum, r) => sum + (r['distance_km'] as num).toDouble());

    final uniqueCourses = await _client
        .from('run_histories')
        .select('course_id')
        .eq('user_id', odString odString odString userId)
        .not('course_id', 'is', null);

    final uniqueCourseIds = (uniqueCourses as List)
        .map((r) => r['course_id'])
        .toSet();

    final sharedCourses = await _client
        .from('courses')
        .select()
        .eq('creator_id', odString odString odString userId)
        .count(CountOption.exact);

    // 시간대별 러닝 (간소화: 실제로는 run_at 시간 파싱 필요)
    final earlyRuns = await _client
        .from('run_histories')
        .select()
        .eq('user_id', odString odString odString userId)
        .lt('run_at', '1970-01-01T06:00:00')  // placeholder
        .count(CountOption.exact);

    final streakData = await getUserStreak(odString odString odString userId);

    return {
      'total_runs': totalRuns.count,
      'total_distance_km': totalDistance,
      'current_streak': streakData?.currentStreak ?? 0,
      'unique_course_count': uniqueCourseIds.length,
      'shared_course_count': sharedCourses.count,
      'early_run_count': 0,  // 별도 계산 필요
      'night_run_count': 0,  // 별도 계산 필요
      'weekend_streak': 0,   // 별도 계산 필요
    };
  }

  Future<bool> isFirstCourseCompletion(String odString odString odString userId, String courseId) async {
    final response = await _client
        .from('run_histories')
        .select()
        .eq('user_id', odString odString odString userId)
        .eq('course_id', courseId)
        .count(CountOption.exact);
    return response.count == 1;
  }

  // Challenges
  Future<List<ChallengeModel>> getActiveChallenges() async {
    final now = DateTime.now().toIso8601String();
    final response = await _client
        .from('challenges')
        .select()
        .eq('is_active', true)
        .lte('start_at', now)
        .gte('end_at', now);
    return (response as List).map((j) => ChallengeModel.fromJson(j)).toList();
  }

  Future<List<UserChallengeModel>> getUserChallenges(String odString odString odString userId) async {
    final response = await _client
        .from('user_challenges')
        .select('*, challenge:challenges(*)')
        .eq('user_id', odString odString odString userId);
    return (response as List).map((j) => UserChallengeModel.fromJson({
      ...j,
      'challenge': j['challenge'],
    })).toList();
  }

  Future<void> joinChallenge(String odString odString odString userId, String challengeId) async {
    await _client.from('user_challenges').insert({
      'user_id': odString odString odString userId,
      'challenge_id': challengeId,
    });
  }

  Future<void> updateChallengeProgress({
    required String odString odString odString odString userId,
    required String challengeId,
    required int progress,
    required bool isCompleted,
  }) async {
    await _client.from('user_challenges').update({
      'current_progress': progress,
      'is_completed': isCompleted,
      'completed_at': isCompleted ? DateTime.now().toIso8601String() : null,
    }).eq('user_id', odString odString odString userId).eq('challenge_id', challengeId);
  }

  // Leaderboard
  Future<List<LeaderboardEntryModel>> getWeeklyLeaderboard({int limit = 100}) async {
    final response = await _client
        .from('weekly_distance_leaderboard')
        .select()
        .limit(limit);
    return (response as List).map((j) => LeaderboardEntryModel.fromJson(j)).toList();
  }

  Future<List<LeaderboardEntryModel>> getMonthlyLeaderboard({int limit = 100}) async {
    final response = await _client
        .from('monthly_distance_leaderboard')
        .select()
        .limit(limit);
    return (response as List).map((j) => LeaderboardEntryModel.fromJson(j)).toList();
  }

  Future<LeaderboardEntryModel?> getUserWeeklyRank(String odString odString odString userId) async {
    final response = await _client
        .from('weekly_distance_leaderboard')
        .select()
        .eq('user_id', odString odString odString userId)
        .maybeSingle();
    if (response == null) return null;
    return LeaderboardEntryModel.fromJson(response);
  }

  Future<LeaderboardEntryModel?> getUserMonthlyRank(String odString odString odString userId) async {
    final response = await _client
        .from('monthly_distance_leaderboard')
        .select()
        .eq('user_id', odString odString odString userId)
        .maybeSingle();
    if (response == null) return null;
    return LeaderboardEntryModel.fromJson(response);
  }
}
```

**Step 2: 커밋**

```bash
git add lib/features/gamification/data/datasources/gamification_remote_datasource.dart
git commit -m "feat(gamification): GamificationRemoteDataSource 구현"
```

---

### Task 3.4: GamificationRepositoryImpl 구현

**Files:**
- Create: `lib/features/gamification/data/repositories/gamification_repository_impl.dart`

**Step 1: Repository 구현**

```dart
// lib/features/gamification/data/repositories/gamification_repository_impl.dart
import '../../domain/entities/achievement.dart';
import '../../domain/entities/challenge.dart';
import '../../domain/entities/leaderboard_entry.dart';
import '../../domain/entities/user_level.dart';
import '../../domain/entities/user_stats.dart';
import '../../domain/entities/user_streak.dart';
import '../../domain/repositories/gamification_repository.dart';
import '../../domain/services/achievement_definitions.dart';
import '../../domain/services/level_calculator.dart';
import '../datasources/gamification_remote_datasource.dart';
import '../models/user_streak_model.dart';

class GamificationRepositoryImpl implements GamificationRepository {
  final GamificationRemoteDataSource _dataSource;

  GamificationRepositoryImpl(this._dataSource);

  @override
  Future<UserLevel> getUserLevel(String odString odString odString userId) async {
    final model = await _dataSource.getUserLevel(odString odString odString userId);
    if (model != null) return model.toEntity();

    // 새 사용자: 기본 레벨 생성
    final newModel = await _dataSource.upsertUserLevel(
      odString odString odString userId: odString odString odString userId,
      currentXp: 0,
      level: 1,
    );
    return newModel.toEntity();
  }

  @override
  Future<UserLevel> addXp(String odString odString odString userId, int xp) async {
    final current = await getUserLevel(odString odString odString userId);
    final newXp = current.currentXp + xp;
    final newLevel = LevelCalculator.getLevelForXp(newXp);

    final model = await _dataSource.upsertUserLevel(
      odString odString odString userId: odString odString odString userId,
      currentXp: newXp,
      level: newLevel,
    );
    return model.toEntity();
  }

  @override
  Future<UserStreak> getUserStreak(String odString odString odString userId) async {
    final model = await _dataSource.getUserStreak(odString odString odString userId);
    if (model != null) return model.toEntity();

    return UserStreak(
      odString odString odString userId: odString odString odString userId,
      currentStreak: 0,
      longestStreak: 0,
      lastRunDate: null,
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<void> saveUserStreak(UserStreak streak) async {
    await _dataSource.upsertUserStreak(UserStreakModel.fromEntity(streak));
  }

  @override
  Future<List<Achievement>> getAllAchievements() async {
    return allAchievements;
  }

  @override
  Future<Set<String>> getUnlockedAchievementIds(String odString odString odString userId) async {
    final ids = await _dataSource.getUnlockedAchievementIds(odString odString odString userId);
    return ids.toSet();
  }

  @override
  Future<List<UserAchievement>> getUserAchievements(String odString odString odString userId) async {
    final data = await _dataSource.getUserAchievements(odString odString odString userId);
    return data.map((d) {
      final achievementData = d['achievement'] as Map<String, dynamic>;
      final achievement = allAchievements.firstWhere(
        (a) => a.id == achievementData['id'],
      );
      return UserAchievement(
        odString odString odString userId: d['user_id'],
        achievementId: d['achievement_id'],
        achievement: achievement,
        unlockedAt: DateTime.parse(d['unlocked_at']),
      );
    }).toList();
  }

  @override
  Future<void> unlockAchievement(String odString odString odString userId, String achievementId) async {
    await _dataSource.insertUserAchievement(odString odString odString userId, achievementId);
  }

  @override
  Future<UserStats> getUserStats(String odString odString odString userId) async {
    final data = await _dataSource.getUserStats(odString odString odString userId);
    return UserStats(
      totalRuns: data['total_runs'] ?? 0,
      totalDistanceKm: (data['total_distance_km'] as num?)?.toDouble() ?? 0,
      currentStreak: data['current_streak'] ?? 0,
      uniqueCourseCount: data['unique_course_count'] ?? 0,
      sharedCourseCount: data['shared_course_count'] ?? 0,
      earlyRunCount: data['early_run_count'] ?? 0,
      nightRunCount: data['night_run_count'] ?? 0,
      weekendStreak: data['weekend_streak'] ?? 0,
    );
  }

  @override
  Future<bool> isFirstCourseCompletion(String odString odString odString userId, String courseId) async {
    return _dataSource.isFirstCourseCompletion(odString odString odString userId, courseId);
  }

  @override
  Future<List<Challenge>> getActiveChallenges() async {
    final models = await _dataSource.getActiveChallenges();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<UserChallenge>> getUserChallenges(String odString odString odString userId) async {
    final models = await _dataSource.getUserChallenges(odString odString odString userId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> joinChallenge(String odString odString odString userId, String challengeId) async {
    await _dataSource.joinChallenge(odString odString odString userId, challengeId);
  }

  @override
  Future<List<UserChallenge>> updateChallengeProgress(
    String odString odString odString userId,
    double distanceKm,
    int durationMinutes,
    String? courseId,
  ) async {
    final userChallenges = await getUserChallenges(odString odString odString userId);
    final updatedChallenges = <UserChallenge>[];

    for (final uc in userChallenges) {
      if (uc.isCompleted || uc.isExpired) continue;

      int progressDelta = 0;
      switch (uc.challenge.unit) {
        case 'km':
          progressDelta = distanceKm.round();
          break;
        case 'runs':
          progressDelta = 1;
          break;
        case 'minutes':
          progressDelta = durationMinutes;
          break;
        case 'courses':
          if (courseId != null) progressDelta = 1;
          break;
      }

      if (progressDelta > 0) {
        final newProgress = uc.currentProgress + progressDelta;
        final isCompleted = newProgress >= uc.challenge.targetValue;

        await _dataSource.updateChallengeProgress(
          odString odString odString userId: odString odString odString userId,
          challengeId: uc.challengeId,
          progress: newProgress,
          isCompleted: isCompleted,
        );

        updatedChallenges.add(uc.copyWith(
          currentProgress: newProgress,
          isCompleted: isCompleted,
          completedAt: isCompleted ? DateTime.now() : null,
        ));
      }
    }

    return updatedChallenges;
  }

  @override
  Future<List<LeaderboardEntry>> getLeaderboard(
    LeaderboardType type, {
    int limit = 100,
  }) async {
    final models = switch (type) {
      LeaderboardType.weeklyDistance =>
        await _dataSource.getWeeklyLeaderboard(limit: limit),
      LeaderboardType.monthlyDistance =>
        await _dataSource.getMonthlyLeaderboard(limit: limit),
    };
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<LeaderboardEntry?> getUserRank(
    String odString odString odString userId,
    LeaderboardType type,
  ) async {
    final model = switch (type) {
      LeaderboardType.weeklyDistance =>
        await _dataSource.getUserWeeklyRank(odString odString odString userId),
      LeaderboardType.monthlyDistance =>
        await _dataSource.getUserMonthlyRank(odString odString odString userId),
    };
    return model?.toEntity();
  }
}
```

**Step 2: 커밋**

```bash
git add lib/features/gamification/data/repositories/gamification_repository_impl.dart
git commit -m "feat(gamification): GamificationRepositoryImpl 구현"
```

---

## Phase 4: Use Cases

### Task 4.1: ProcessRunCompletion UseCase 구현

**Files:**
- Create: `lib/features/gamification/domain/usecases/process_run_completion.dart`
- Test: `test/features/gamification/domain/usecases/process_run_completion_test.dart`

**Step 1: UseCase 구현**

```dart
// lib/features/gamification/domain/usecases/process_run_completion.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../entities/achievement.dart';
import '../entities/challenge.dart';
import '../repositories/gamification_repository.dart';
import '../services/achievement_checker.dart';
import '../services/achievement_definitions.dart';
import '../services/streak_calculator.dart';
import '../services/xp_calculator.dart';

part 'process_run_completion.freezed.dart';

@freezed
class RunCompletionResult with _$RunCompletionResult {
  const factory RunCompletionResult({
    required int earnedXp,
    required List<Achievement> newAchievements,
    required bool leveledUp,
    required int newLevel,
    required int previousLevel,
    required int currentStreak,
    required List<UserChallenge> completedChallenges,
  }) = _RunCompletionResult;
}

class ProcessRunCompletion {
  final GamificationRepository repository;
  final XpCalculator xpCalculator;
  final AchievementChecker achievementChecker;
  final StreakCalculator streakCalculator;

  ProcessRunCompletion({
    required this.repository,
    XpCalculator? xpCalculator,
    AchievementChecker? achievementChecker,
    StreakCalculator? streakCalculator,
  })  : xpCalculator = xpCalculator ?? XpCalculator(),
        achievementChecker = achievementChecker ?? AchievementChecker(allAchievements),
        streakCalculator = streakCalculator ?? StreakCalculator();

  Future<RunCompletionResult> execute({
    required String odString odString odString userId,
    required double distanceKm,
    required int durationMinutes,
    required double paceMinPerKm,
    required DateTime runAt,
    String? courseId,
  }) async {
    // 1. 기본 XP 계산
    int earnedXp = xpCalculator.calculateRunXp(distanceKm: distanceKm);

    // 2. 코스 첫 완주 보너스
    if (courseId != null) {
      final isFirstTime = await repository.isFirstCourseCompletion(
        odString odString odString userId,
        courseId,
      );
      if (isFirstTime) {
        earnedXp += xpCalculator.firstCourseBonus;
      }
    }

    // 3. 스트릭 업데이트
    final currentStreak = await repository.getUserStreak(odString odString odString userId);
    final newStreak = streakCalculator.updateStreak(currentStreak, runAt);
    await repository.saveUserStreak(newStreak);

    // 4. 사용자 통계 조회
    final stats = await repository.getUserStats(odString odString odString userId);
    final unlockedIds = await repository.getUnlockedAchievementIds(odString odString odString userId);

    // 5. 업적 체크
    final statsWithStreak = stats.copyWith(currentStreak: newStreak.currentStreak);
    final newAchievements = achievementChecker.checkAfterRun(
      stats: statsWithStreak,
      runDistanceKm: distanceKm,
      runPaceMinPerKm: paceMinPerKm,
      unlockedIds: unlockedIds,
    );

    // 6. 업적 저장 및 XP 추가
    for (final achievement in newAchievements) {
      earnedXp += achievement.xpReward;
      await repository.unlockAchievement(odString odString odString userId, achievement.id);
    }

    // 7. XP 적용 및 레벨업 체크
    final previousLevel = await repository.getUserLevel(odString odString odString userId);
    final newLevelData = await repository.addXp(odString odString odString userId, earnedXp);
    final leveledUp = newLevelData.level > previousLevel.level;

    // 8. 챌린지 진행률 업데이트
    final updatedChallenges = await repository.updateChallengeProgress(
      odString odString odString userId,
      distanceKm,
      durationMinutes,
      courseId,
    );

    // 완료된 챌린지 XP 추가
    for (final uc in updatedChallenges.where((c) => c.isCompleted)) {
      await repository.addXp(odString odString odString userId, uc.challenge.xpReward);
      earnedXp += uc.challenge.xpReward;
    }

    return RunCompletionResult(
      earnedXp: earnedXp,
      newAchievements: newAchievements,
      leveledUp: leveledUp,
      newLevel: newLevelData.level,
      previousLevel: previousLevel.level,
      currentStreak: newStreak.currentStreak,
      completedChallenges: updatedChallenges.where((c) => c.isCompleted).toList(),
    );
  }
}
```

**Step 2: 코드 생성**

Run: `dart run build_runner build --delete-conflicting-outputs`

**Step 3: 커밋**

```bash
git add lib/features/gamification/domain/usecases/process_run_completion.dart lib/features/gamification/domain/usecases/process_run_completion.freezed.dart
git commit -m "feat(gamification): ProcessRunCompletion UseCase 구현"
```

---

## Phase 5: Presentation Layer (나머지 Task는 축약)

### Task 5.1: Gamification Providers 설정
### Task 5.2: XpBar Widget 구현
### Task 5.3: AchievementCard Widget 구현
### Task 5.4: LevelUpDialog Widget 구현
### Task 5.5: AchievementUnlockedDialog Widget 구현
### Task 5.6: RunCompletionSummary Widget 구현

---

## Phase 6: Screens 구현

### Task 6.1: AchievementsScreen 구현
### Task 6.2: ChallengesScreen 구현
### Task 6.3: LeaderboardScreen 구현

---

## Phase 7: 통합 및 라우팅

### Task 7.1: Feature Export 파일 생성
### Task 7.2: 라우팅 업데이트
### Task 7.3: 전체 테스트 실행

---

## 총 예상 커밋 수

- Phase 1: 6 commits (Entities)
- Phase 2: 4 commits (Services)
- Phase 3: 4 commits (Data Layer)
- Phase 4: 1 commit (UseCase)
- Phase 5: 6 commits (Providers + Widgets)
- Phase 6: 3 commits (Screens)
- Phase 7: 3 commits (통합)

**Total: ~27 commits**
