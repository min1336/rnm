# 게이미피케이션 시스템 설계

> 작성일: 2026-01-29
> 상태: 승인 대기

## 개요

RunningMate 앱의 게이미피케이션 시스템 설계 문서입니다. 사용자의 러닝 동기 부여와 지속적인 참여를 위한 XP/레벨, 업적, 챌린지, 리더보드 시스템을 정의합니다.

### 구현 범위

- **XP/레벨 시스템**: 러닝 완료 시 XP 획득, 레벨업 로직
- **업적 시스템**: 18개 업적 (거리, 연속, 탐험, 속도, 시간대, 환경)
- **챌린지 시스템**: 주간/월간 챌린지
- **리더보드**: 글로벌 주간/월간 거리 랭킹

### 기술적 결정

- **업적 체크 로직**: 클라이언트에서 처리 (빠른 피드백, 오프라인 지원)
- **리더보드 범위**: 글로벌 전체

---

## 1. 아키텍처

### 폴더 구조

```
lib/features/gamification/
├── domain/
│   ├── entities/
│   │   ├── achievement.dart
│   │   ├── user_level.dart
│   │   ├── challenge.dart
│   │   ├── user_challenge.dart
│   │   ├── leaderboard_entry.dart
│   │   └── user_streak.dart
│   ├── services/
│   │   ├── xp_calculator.dart
│   │   ├── achievement_checker.dart
│   │   └── level_calculator.dart
│   ├── repositories/
│   │   └── gamification_repository.dart
│   └── usecases/
│       ├── process_run_completion.dart
│       ├── get_user_level.dart
│       ├── get_achievements.dart
│       ├── get_challenges.dart
│       └── get_leaderboard.dart
├── data/
│   ├── models/
│   │   ├── achievement_model.dart
│   │   ├── user_level_model.dart
│   │   ├── challenge_model.dart
│   │   └── leaderboard_entry_model.dart
│   ├── datasources/
│   │   └── gamification_remote_datasource.dart
│   └── repositories/
│       └── gamification_repository_impl.dart
└── presentation/
    ├── providers/
    │   └── gamification_providers.dart
    ├── screens/
    │   ├── achievements_screen.dart
    │   ├── challenges_screen.dart
    │   └── leaderboard_screen.dart
    └── widgets/
        ├── xp_bar.dart
        ├── level_badge.dart
        ├── streak_indicator.dart
        ├── achievement_card.dart
        ├── achievement_grid.dart
        ├── challenge_card.dart
        ├── leaderboard_tile.dart
        ├── level_up_dialog.dart
        ├── achievement_unlocked_dialog.dart
        └── run_completion_summary.dart
```

### 핵심 흐름

```
러닝 완료 → ProcessRunCompletion UseCase
         → XpCalculator (XP 계산)
         → AchievementChecker (업적 체크)
         → LevelCalculator (레벨업 체크)
         → ChallengeUpdater (챌린지 진행률)
         → UI 업데이트 + 알림
```

---

## 2. 업적 시스템 (18개)

### 거리 업적 (5개)

| ID | 이름 | 설명 | 조건 | XP |
|----|------|------|------|-----|
| `first_step` | 첫 발걸음 | 첫 러닝을 완료했습니다 | 첫 러닝 완료 | 50 |
| `runner_5k` | 5K 러너 | 누적 5km를 달렸습니다 | 누적 5km | 50 |
| `half_marathon` | 하프 마라토너 | 누적 21km를 달렸습니다 | 누적 21km | 100 |
| `full_marathon` | 마라토너 | 누적 42km를 달렸습니다 | 누적 42km | 150 |
| `century_club` | 100km 클럽 | 누적 100km를 달렸습니다 | 누적 100km | 300 |

### 연속 업적 (3개)

| ID | 이름 | 설명 | 조건 | XP |
|----|------|------|------|-----|
| `streak_3` | 3일 연속 | 3일 연속으로 러닝했습니다 | 3일 연속 러닝 | 50 |
| `weekly_warrior` | 주간 전사 | 7일 연속으로 러닝했습니다 | 7일 연속 러닝 | 100 |
| `monthly_habit` | 한 달 습관 | 30일 연속으로 러닝했습니다 | 30일 연속 러닝 | 500 |

### 탐험 업적 (3개)

| ID | 이름 | 설명 | 조건 | XP |
|----|------|------|------|-----|
| `explorer` | 탐험가 | 5개의 다른 코스를 완주했습니다 | 5개 코스 완주 | 50 |
| `course_master` | 코스 마스터 | 20개의 다른 코스를 완주했습니다 | 20개 코스 완주 | 200 |
| `first_share` | 첫 공유 | 첫 코스를 공유했습니다 | 코스 첫 공유 | 50 |

### 속도/페이스 업적 (3개)

| ID | 이름 | 설명 | 조건 | XP |
|----|------|------|------|-----|
| `pace_breaker_6` | 6분 벽 돌파 | 평균 페이스 6분/km 이하로 달렸습니다 | 페이스 ≤ 6:00/km | 100 |
| `pace_breaker_5` | 5분 벽 돌파 | 평균 페이스 5분/km 이하로 달렸습니다 | 페이스 ≤ 5:00/km | 150 |
| `speed_demon` | 스피드 데몬 | 평균 페이스 4:30/km 이하로 달렸습니다 | 페이스 ≤ 4:30/km | 300 |

### 시간대 업적 (2개)

| ID | 이름 | 설명 | 조건 | XP |
|----|------|------|------|-----|
| `early_bird` | 얼리버드 | 새벽 러닝 5회 완료 | 오전 6시 이전 러닝 5회 | 100 |
| `night_owl` | 나이트 올빼미 | 야간 러닝 5회 완료 | 오후 9시 이후 러닝 5회 | 100 |

### 환경/특별 업적 (2개)

| ID | 이름 | 설명 | 조건 | XP |
|----|------|------|------|-----|
| `weekend_warrior` | 주말 전사 | 4주 연속 주말 러닝 | 4주 연속 주말(토/일) 러닝 | 150 |
| `long_runner` | 롱런 마스터 | 한 번에 10km 이상 달리기 | 단일 러닝 10km 이상 | 200 |

### Achievement Entity

```dart
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
    required String odString odString userId,
    required String achievementId,
    required Achievement achievement,
    required DateTime unlockedAt,
  }) = _UserAchievement;
}
```

---

## 3. XP/레벨 시스템

### XP 획득 규칙

| 활동 | XP 계산 | 예시 |
|------|---------|------|
| 러닝 완료 | `거리(km) × 10` | 5km → 50 XP |
| 코스 첫 완주 | +20 보너스 | 새 코스 완주 시 추가 |
| 업적 달성 | 업적별 지정 XP | 50~500 XP |
| 챌린지 완료 | 챌린지별 지정 XP | 100~300 XP |

### 레벨 테이블

| 레벨 | 필요 누적 XP | 등급명 |
|------|-------------|--------|
| 1 | 0 | 새싹 러너 |
| 2 | 100 | 초보 러너 |
| 3 | 200 | 러닝 입문자 |
| 4 | 300 | 주니어 러너 |
| 5 | 400 | 러너 |
| 6 | 900 | 시니어 러너 |
| 7 | 1,400 | 베테랑 러너 |
| 8 | 1,900 | 엘리트 러너 |
| 9 | 2,400 | 마스터 러너 |
| 10 | 2,900 | 레전드 러너 |
| 11+ | +500씩 증가 | 레전드 러너 II, III... |

### LevelCalculator

```dart
class LevelCalculator {
  static const _levelNames = [
    '새싹 러너',      // 1
    '초보 러너',      // 2
    '러닝 입문자',    // 3
    '주니어 러너',    // 4
    '러너',          // 5
    '시니어 러너',    // 6
    '베테랑 러너',    // 7
    '엘리트 러너',    // 8
    '마스터 러너',    // 9
    '레전드 러너',    // 10
  ];

  static int getRequiredXp(int level) {
    if (level <= 1) return 0;
    if (level <= 5) return (level - 1) * 100;  // 100, 200, 300, 400
    return 400 + (level - 5) * 500;             // 900, 1400, 1900...
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
    final suffix = level - 9;  // 11 -> II, 12 -> III
    return '레전드 러너 ${_toRoman(suffix)}';
  }

  static String _toRoman(int num) {
    const romans = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'];
    return num <= 10 ? romans[num - 1] : num.toString();
  }
}
```

### UserLevel Entity

```dart
@freezed
class UserLevel with _$UserLevel {
  const UserLevel._();

  const factory UserLevel({
    required String odString userId,
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

---

## 4. 챌린지 시스템

### 챌린지 유형

| 유형 | 갱신 주기 | 설명 |
|------|----------|------|
| weekly | 매주 월요일 00:00 (KST) | 주간 목표 |
| monthly | 매월 1일 00:00 (KST) | 월간 목표 |
| special | 이벤트 기간 | 특별 이벤트 |

### MVP 챌린지 목록

**주간 챌린지 풀 (매주 2개 랜덤 활성화)**

| 제목 | 목표 | 단위 | XP |
|------|------|------|-----|
| 이번 주 15km 달리기 | 15 | km | 100 |
| 이번 주 3회 러닝 | 3 | runs | 80 |
| 새로운 코스 2개 도전 | 2 | courses | 120 |
| 이번 주 60분 러닝 | 60 | minutes | 100 |

**월간 챌린지 풀 (매월 1개 랜덤 활성화)**

| 제목 | 목표 | 단위 | XP |
|------|------|------|-----|
| 이번 달 50km 달리기 | 50 | km | 300 |
| 이번 달 10개 코스 완주 | 10 | courses | 250 |
| 이번 달 12회 러닝 | 12 | runs | 200 |

### Challenge Entity

```dart
enum ChallengeType { weekly, monthly, special }

@freezed
class Challenge with _$Challenge {
  const factory Challenge({
    required String id,
    required String title,
    String? description,
    required ChallengeType type,
    required int targetValue,
    required String unit,  // "km", "runs", "courses", "minutes"
    required int xpReward,
    required DateTime startAt,
    required DateTime endAt,
  }) = _Challenge;
}

@freezed
class UserChallenge with _$UserChallenge {
  const UserChallenge._();

  const factory UserChallenge({
    required String odString userId,
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

---

## 5. 리더보드

### 리더보드 유형

| 유형 | 기간 | 정렬 기준 |
|------|------|----------|
| weekly_distance | 이번 주 (월~일) | 총 거리 (km) 내림차순 |
| monthly_distance | 이번 달 | 총 거리 (km) 내림차순 |

### LeaderboardEntry Entity

```dart
enum LeaderboardType { weeklyDistance, monthlyDistance }

@freezed
class LeaderboardEntry with _$LeaderboardEntry {
  const factory LeaderboardEntry({
    required String odString userId,
    required String displayName,
    String? avatarUrl,
    required double totalDistance,
    required int runCount,
    required int rank,
  }) = _LeaderboardEntry;
}
```

### Supabase View

```sql
-- 주간 거리 리더보드
create or replace view weekly_distance_leaderboard as
select
  rh.user_id,
  p.display_name,
  p.avatar_url,
  coalesce(sum(rh.distance_km), 0) as total_distance,
  count(*) as run_count,
  rank() over (order by coalesce(sum(rh.distance_km), 0) desc) as rank
from run_histories rh
join profiles p on p.id = rh.user_id
where rh.run_at >= date_trunc('week', now() at time zone 'Asia/Seoul')
group by rh.user_id, p.display_name, p.avatar_url
order by total_distance desc;

-- 월간 거리 리더보드
create or replace view monthly_distance_leaderboard as
select
  rh.user_id,
  p.display_name,
  p.avatar_url,
  coalesce(sum(rh.distance_km), 0) as total_distance,
  count(*) as run_count,
  rank() over (order by coalesce(sum(rh.distance_km), 0) desc) as rank
from run_histories rh
join profiles p on p.id = rh.user_id
where rh.run_at >= date_trunc('month', now() at time zone 'Asia/Seoul')
group by rh.user_id, p.display_name, p.avatar_url
order by total_distance desc;
```

---

## 6. 스트릭 시스템

### UserStreak Entity

```dart
@freezed
class UserStreak with _$UserStreak {
  const factory UserStreak({
    required String odString odString userId,
    required int currentStreak,
    required int longestStreak,
    DateTime? lastRunDate,
    required DateTime updatedAt,
  }) = _UserStreak;
}
```

### 스트릭 계산 로직

```dart
class StreakCalculator {
  /// 러닝 완료 후 스트릭 업데이트
  UserStreak updateStreak(UserStreak current, DateTime runAt) {
    final runDate = _toKstDate(runAt);
    final lastDate = current.lastRunDate != null
        ? _toKstDate(current.lastRunDate!)
        : null;

    // 같은 날 러닝 → 변화 없음
    if (lastDate != null && runDate.isAtSameMomentAs(lastDate)) {
      return current;
    }

    // 어제 러닝 → 스트릭 증가
    if (lastDate != null && runDate.difference(lastDate).inDays == 1) {
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
}
```

---

## 7. 핵심 서비스

### XpCalculator

```dart
class XpCalculator {
  /// 러닝 기본 XP 계산
  int calculateRunXp(RunHistory run) {
    return (run.distanceKm * 10).round();
  }

  /// 코스 첫 완주 보너스
  int get firstCourseBonus => 20;
}
```

### AchievementChecker

```dart
class AchievementChecker {
  final List<Achievement> _allAchievements;

  AchievementChecker(this._allAchievements);

  /// 러닝 완료 후 새로 달성한 업적 체크
  List<Achievement> checkAfterRun({
    required RunHistory run,
    required UserStats stats,
    required Set<String> unlockedIds,
  }) {
    final newAchievements = <Achievement>[];

    for (final achievement in _allAchievements) {
      if (unlockedIds.contains(achievement.id)) continue;

      if (_checkCondition(achievement, run, stats)) {
        newAchievements.add(achievement);
      }
    }

    return newAchievements;
  }

  bool _checkCondition(Achievement a, RunHistory run, UserStats stats) {
    return switch (a.conditionType) {
      ConditionType.firstRun => stats.totalRuns == 1,
      ConditionType.totalDistance => stats.totalDistanceKm >= a.conditionValue,
      ConditionType.streakDays => stats.currentStreak >= a.conditionValue,
      ConditionType.courseCount => stats.uniqueCourseCount >= a.conditionValue,
      ConditionType.courseShare => stats.sharedCourseCount >= a.conditionValue,
      ConditionType.pace => run.paceMinPerKm <= a.conditionValue / 100,
      ConditionType.earlyRunCount => stats.earlyRunCount >= a.conditionValue,
      ConditionType.nightRunCount => stats.nightRunCount >= a.conditionValue,
      ConditionType.singleDistance => run.distanceKm >= a.conditionValue,
      ConditionType.weekendStreak => stats.weekendStreak >= a.conditionValue,
    };
  }
}
```

### UserStats (업적 체크용 통계)

```dart
@freezed
class UserStats with _$UserStats {
  const factory UserStats({
    required int totalRuns,
    required double totalDistanceKm,
    required int currentStreak,
    required int uniqueCourseCount,
    required int sharedCourseCount,
    required int earlyRunCount,   // 6시 이전
    required int nightRunCount,   // 21시 이후
    required int weekendStreak,   // 연속 주말 러닝 주 수
  }) = _UserStats;
}
```

### ProcessRunCompletion UseCase

```dart
class ProcessRunCompletion {
  final GamificationRepository repository;
  final XpCalculator xpCalculator;
  final AchievementChecker achievementChecker;
  final StreakCalculator streakCalculator;

  Future<RunCompletionResult> execute({
    required String odString odString odString userId,
    required RunHistory run,
  }) async {
    // 1. 기본 XP 계산
    int earnedXp = xpCalculator.calculateRunXp(run);

    // 2. 코스 첫 완주 보너스
    if (run.courseId != null) {
      final isFirstTime = await repository.isFirstCourseCompletion(
        userId, run.courseId!);
      if (isFirstTime) {
        earnedXp += xpCalculator.firstCourseBonus;
      }
    }

    // 3. 스트릭 업데이트
    final currentStreak = await repository.getUserStreak(userId);
    final newStreak = streakCalculator.updateStreak(currentStreak, run.runAt);
    await repository.saveUserStreak(newStreak);

    // 4. 사용자 통계 조회
    final stats = await repository.getUserStats(userId);
    final unlockedIds = await repository.getUnlockedAchievementIds(userId);

    // 5. 업적 체크
    final newAchievements = achievementChecker.checkAfterRun(
      run: run,
      stats: stats.copyWith(currentStreak: newStreak.currentStreak),
      unlockedIds: unlockedIds,
    );

    // 6. 업적 저장 및 XP 추가
    for (final achievement in newAchievements) {
      earnedXp += achievement.xpReward;
      await repository.unlockAchievement(userId, achievement.id);
    }

    // 7. XP 적용 및 레벨업 체크
    final levelResult = await repository.addXp(userId, earnedXp);

    // 8. 챌린지 진행률 업데이트
    final updatedChallenges = await repository.updateChallengeProgress(
      userId, run);

    return RunCompletionResult(
      earnedXp: earnedXp,
      newAchievements: newAchievements,
      leveledUp: levelResult.leveledUp,
      newLevel: levelResult.newLevel,
      previousLevel: levelResult.previousLevel,
      currentStreak: newStreak.currentStreak,
      completedChallenges: updatedChallenges
          .where((c) => c.isCompleted)
          .toList(),
    );
  }
}

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
```

---

## 8. 데이터베이스 스키마

### 테이블 정의

```sql
-- achievements (업적 정의 - 시드 데이터)
create table achievements (
  id text primary key,
  name text not null,
  description text not null,
  icon_name text not null,
  category text not null,
  condition_type text not null,
  condition_value int not null,
  xp_reward int not null default 50,
  created_at timestamptz default now()
);

-- user_achievements (사용자 업적 달성)
create table user_achievements (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  achievement_id text not null references achievements(id),
  unlocked_at timestamptz default now(),
  unique(user_id, achievement_id)
);

-- user_levels (사용자 레벨)
create table user_levels (
  user_id uuid primary key references auth.users(id) on delete cascade,
  current_xp int not null default 0,
  level int not null default 1,
  updated_at timestamptz default now()
);

-- user_streaks (연속 러닝 추적)
create table user_streaks (
  user_id uuid primary key references auth.users(id) on delete cascade,
  current_streak int not null default 0,
  longest_streak int not null default 0,
  last_run_date date,
  updated_at timestamptz default now()
);

-- challenges (챌린지 정의)
create table challenges (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text,
  type text not null,
  target_value int not null,
  unit text not null,
  xp_reward int not null default 100,
  start_at timestamptz not null,
  end_at timestamptz not null,
  is_active boolean default true,
  created_at timestamptz default now()
);

-- user_challenges (사용자 챌린지 참여)
create table user_challenges (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  challenge_id uuid not null references challenges(id) on delete cascade,
  current_progress int not null default 0,
  is_completed boolean default false,
  completed_at timestamptz,
  joined_at timestamptz default now(),
  unique(user_id, challenge_id)
);
```

### 인덱스

```sql
create index idx_user_achievements_user on user_achievements(user_id);
create index idx_user_challenges_user_active on user_challenges(user_id, is_completed);
create index idx_challenges_active_period on challenges(is_active, start_at, end_at);
create index idx_run_histories_user_date on run_histories(user_id, run_at desc);
```

### RLS 정책

```sql
-- achievements (공개 읽기)
alter table achievements enable row level security;
create policy "Anyone can view achievements"
  on achievements for select using (true);

-- user_achievements
alter table user_achievements enable row level security;
create policy "Users can view own achievements"
  on user_achievements for select using (auth.uid() = user_id);
create policy "Users can insert own achievements"
  on user_achievements for insert with check (auth.uid() = user_id);

-- user_levels
alter table user_levels enable row level security;
create policy "Anyone can view levels (for leaderboard)"
  on user_levels for select using (true);
create policy "Users can manage own level"
  on user_levels for all using (auth.uid() = user_id);

-- user_streaks
alter table user_streaks enable row level security;
create policy "Users can view own streak"
  on user_streaks for select using (auth.uid() = user_id);
create policy "Users can manage own streak"
  on user_streaks for all using (auth.uid() = user_id);

-- challenges (공개 읽기)
alter table challenges enable row level security;
create policy "Anyone can view active challenges"
  on challenges for select using (is_active = true);

-- user_challenges
alter table user_challenges enable row level security;
create policy "Users can view own challenges"
  on user_challenges for select using (auth.uid() = user_id);
create policy "Users can manage own challenges"
  on user_challenges for all using (auth.uid() = user_id);
```

### 시드 데이터 (업적)

```sql
insert into achievements (id, name, description, icon_name, category, condition_type, condition_value, xp_reward) values
-- 거리
('first_step', '첫 발걸음', '첫 러닝을 완료했습니다', 'footprints', 'distance', 'first_run', 1, 50),
('runner_5k', '5K 러너', '누적 5km를 달렸습니다', 'road', 'distance', 'total_distance', 5, 50),
('half_marathon', '하프 마라토너', '누적 21km를 달렸습니다', 'medal', 'distance', 'total_distance', 21, 100),
('full_marathon', '마라토너', '누적 42km를 달렸습니다', 'trophy', 'distance', 'total_distance', 42, 150),
('century_club', '100km 클럽', '누적 100km를 달렸습니다', 'star', 'distance', 'total_distance', 100, 300),
-- 연속
('streak_3', '3일 연속', '3일 연속으로 러닝했습니다', 'fire', 'streak', 'streak_days', 3, 50),
('weekly_warrior', '주간 전사', '7일 연속으로 러닝했습니다', 'flame', 'streak', 'streak_days', 7, 100),
('monthly_habit', '한 달 습관', '30일 연속으로 러닝했습니다', 'calendar_check', 'streak', 'streak_days', 30, 500),
-- 탐험
('explorer', '탐험가', '5개의 다른 코스를 완주했습니다', 'map', 'exploration', 'course_count', 5, 50),
('course_master', '코스 마스터', '20개의 다른 코스를 완주했습니다', 'map_marked', 'exploration', 'course_count', 20, 200),
('first_share', '첫 공유', '첫 코스를 공유했습니다', 'share', 'exploration', 'course_share', 1, 50),
-- 속도
('pace_breaker_6', '6분 벽 돌파', '평균 페이스 6분/km 이하로 달렸습니다', 'speedometer', 'speed', 'pace', 600, 100),
('pace_breaker_5', '5분 벽 돌파', '평균 페이스 5분/km 이하로 달렸습니다', 'speedometer_fast', 'speed', 'pace', 500, 150),
('speed_demon', '스피드 데몬', '평균 페이스 4:30/km 이하로 달렸습니다', 'lightning', 'speed', 'pace', 450, 300),
-- 시간대
('early_bird', '얼리버드', '새벽 러닝 5회 완료', 'sunrise', 'time', 'early_run_count', 5, 100),
('night_owl', '나이트 올빼미', '야간 러닝 5회 완료', 'moon', 'time', 'night_run_count', 5, 100),
-- 특별
('weekend_warrior', '주말 전사', '4주 연속 주말 러닝', 'weekend', 'special', 'weekend_streak', 4, 150),
('long_runner', '롱런 마스터', '한 번에 10km 이상 달리기', 'route', 'special', 'single_distance', 10, 200);
```

---

## 9. UI/UX 설계

### 홈 화면 위젯

```
┌─────────────────────────────────┐
│ Lv.5 러너          320/500 XP   │
│ ████████████░░░░░░░░  64%       │
│                                 │
│ 🔥 3일 연속 러닝 중!             │
└─────────────────────────────────┘
```

### 러닝 완료 결과 화면

```
┌─────────────────────────────────┐
│        🎉 러닝 완료!             │
│                                 │
│   5.2 km   32분   6:09/km       │
│                                 │
│   +52 XP 획득!                  │
│   ████████████████░░  80%       │
│                                 │
│  ┌─────────────────────────┐    │
│  │ 🏆 업적 달성!            │    │
│  │ "5K 러너" 잠금 해제      │    │
│  └─────────────────────────┘    │
│                                 │
│  챌린지 진행률                   │
│  이번 주 15km: 8.2/15km (55%)   │
└─────────────────────────────────┘
```

### 업적 화면

```
┌─────────────────────────────────┐
│ 업적 (8/18)                     │
├─────────────────────────────────┤
│ [거리]                          │
│ ✅ 첫 발걸음   ✅ 5K 러너        │
│ ⬜ 하프 마라토너  ⬜ 마라토너     │
│ ⬜ 100km 클럽                   │
│                                 │
│ [연속]                          │
│ ✅ 3일 연속   ⬜ 주간 전사       │
│ ⬜ 한 달 습관                    │
│                                 │
│ [탐험]                          │
│ ✅ 탐험가   ⬜ 코스 마스터       │
│ ⬜ 첫 공유                       │
│ ...                             │
└─────────────────────────────────┘
```

### 리더보드 화면

```
┌─────────────────────────────────┐
│ 🏆 리더보드     [주간▼] [월간]   │
├─────────────────────────────────┤
│ 1. 🥇 김철수     42.5km  8회    │
│ 2. 🥈 이영희     38.2km  6회    │
│ 3. 🥉 박지민     35.0km  7회    │
│ 4.    최수진     32.1km  5회    │
│ 5.    정민수     28.7km  4회    │
│ ...                             │
├─────────────────────────────────┤
│ 👤 내 순위: 15위  12.3km  3회   │
└─────────────────────────────────┘
```

### 챌린지 화면

```
┌─────────────────────────────────┐
│ 📋 챌린지                       │
├─────────────────────────────────┤
│ [주간] D-3                      │
│ ┌─────────────────────────────┐ │
│ │ 이번 주 15km 달리기          │ │
│ │ ████████░░░░  8.2/15km      │ │
│ │ 보상: 100 XP                │ │
│ └─────────────────────────────┘ │
│                                 │
│ ┌─────────────────────────────┐ │
│ │ 이번 주 3회 러닝             │ │
│ │ ██████████░░  2/3회         │ │
│ │ 보상: 80 XP                 │ │
│ └─────────────────────────────┘ │
│                                 │
│ [월간] D-18                     │
│ ┌─────────────────────────────┐ │
│ │ 이번 달 50km 달리기          │ │
│ │ ████░░░░░░░░  18.5/50km     │ │
│ │ 보상: 300 XP                │ │
│ └─────────────────────────────┘ │
└─────────────────────────────────┘
```

---

## 10. 에러 처리

| 상황 | 처리 |
|------|------|
| XP 저장 실패 | 로컬 캐시 후 재시도, 앱 재시작 시 동기화 |
| 업적 중복 달성 시도 | unique 제약으로 무시, 클라이언트 캐시 갱신 |
| 리더보드 로딩 실패 | 캐시된 데이터 표시 + 새로고침 버튼 |
| 챌린지 만료 후 완료 시도 | 서버에서 거부, 클라이언트 목록 갱신 |
| 스트릭 자정 기준 | Asia/Seoul 타임존 기준 처리 |
| 네트워크 오프라인 | 로컬에 러닝 데이터 저장, 온라인 시 동기화 |

---

## 11. 테스트 전략

### 단위 테스트 (필수)

| 클래스 | 테스트 항목 |
|--------|------------|
| `XpCalculator` | XP 계산 정확성 |
| `LevelCalculator` | 레벨/XP 변환 정확성 |
| `AchievementChecker` | 각 업적 조건 체크 |
| `StreakCalculator` | 스트릭 증가/리셋 로직 |

### 위젯 테스트

- `XpBar` - 진행률 표시
- `AchievementCard` - 달성/미달성 상태
- `LevelUpDialog` - 레벨업 표시
- `AchievementUnlockedDialog` - 업적 달성 표시

### 통합 테스트

- 러닝 완료 → XP 획득 → 업적 달성 → 레벨업 플로우
- 챌린지 참여 → 진행률 업데이트 → 완료 플로우

---

## 다음 단계

1. 구현 계획 상세 작성 (`/superpowers:writing-plans`)
2. 단계별 구현 진행 (`/superpowers:executing-plans`)
