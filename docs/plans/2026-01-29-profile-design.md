# 프로필 시스템 설계

> 작성일: 2026-01-29
> 상태: 승인됨

## 개요

RunningMate 앱의 프로필 시스템 설계 문서입니다. 러너의 성장 기록과 정체성을 보여주는 허브 역할을 합니다.

### 핵심 기능

- 러닝 통계 (누적/월간/주간)
- 레벨 & XP 시스템
- 업적 쇼케이스
- 목표 진행률
- 앱 설정

---

## 1. 화면 구성

### 메인 프로필 화면

```
┌─────────────────────────────────────┐
│  [프로필 헤더]                      │
│  ┌───────┐  닉네임                  │
│  │ 아바타 │  Lv.12 러닝메이트       │
│  └───────┘  ████████░░ 2,400/3,000 XP│
├─────────────────────────────────────┤
│  [이번 달 요약]                     │
│  🏃 12회  📏 58.3km  ⏱️ 5h 23m     │
├─────────────────────────────────────┤
│  [누적 기록]                        │
│  총 거리    총 시간    총 러닝      │
│  423.5km   38h 15m    89회          │
│  평균 페이스   총 칼로리            │
│  5'42"/km     28,450kcal            │
├─────────────────────────────────────┤
│  [업적 쇼케이스]                    │
│  🏆 🏆 🏆 +12개 더 보기 >           │
├─────────────────────────────────────┤
│  [목표 진행률]                      │
│  마라톤 완주 목표                   │
│  ████████████░░░░ 78%              │
├─────────────────────────────────────┤
│  [메뉴]                             │
│  > 러닝 기록                        │
│  > 업적                             │
│  > 도전 과제                        │
│  > 설정                             │
└─────────────────────────────────────┘
```

### 하위 화면

| 화면 | 설명 |
|------|------|
| 러닝 기록 | 러닝 세션 히스토리, 캘린더 뷰 |
| 업적 | 전체 업적 목록, 진행률 |
| 도전 과제 | 활성/완료된 도전 목록 |
| 설정 | 앱 설정, 계정 관리 |

---

## 2. 데이터 모델

### ProfileStats

```dart
class ProfileStats {
  // 전체 누적
  double totalDistanceKm;
  Duration totalDuration;
  int totalRunCount;
  int totalCalories;

  // 평균값
  double avgPaceMinPerKm;
  double avgDistancePerRun;

  // 이번 달
  double monthlyDistanceKm;
  Duration monthlyDuration;
  int monthlyRunCount;

  // 이번 주
  double weeklyDistanceKm;
  int weeklyRunCount;

  // 최고 기록
  double longestRunKm;
  Duration longestDuration;
  double fastestPaceMinPerKm;

  // 연속 기록
  int currentStreak;        // 현재 연속 러닝 일수
  int longestStreak;        // 최장 연속 러닝 일수
}
```

### UserLevel

```dart
class UserLevel {
  int level;
  int currentXp;
  int xpForNextLevel;
  String title;              // "러닝 초보자", "러닝메이트" 등

  double get progressPercent => currentXp / xpForNextLevel;
}
```

### Achievement

```dart
class Achievement {
  String id;
  String name;
  String description;
  String iconUrl;
  int xpReward;
  AchievementCategory category;

  // 진행률 (미획득 업적용)
  int? currentProgress;
  int? targetProgress;

  // 획득 정보
  bool isUnlocked;
  DateTime? unlockedAt;
}

enum AchievementCategory {
  distance,
  streak,
  record,
  exploration,
  social,
}
```

### UserSettings

```dart
class UserSettings {
  // 러닝
  bool autoPause;
  GpsPrecision gpsPrecision;
  bool voiceCoaching;
  String coachingLanguage;

  // 단위
  DistanceUnit distanceUnit;
  WeightUnit weightUnit;

  // 알림
  bool runningReminder;
  TimeOfDay? reminderTime;
  bool achievementNotification;
  bool challengeNotification;
}

enum GpsPrecision { high, normal, batterySaver }
enum DistanceUnit { km, mi }
enum WeightUnit { kg, lb }
```

---

## 3. Supabase 테이블

### user_xp_logs (XP 기록)

```sql
create table user_xp_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade,
  xp_amount int not null,
  source text not null,           -- 'run_complete', 'achievement', 'challenge'
  source_id uuid,                 -- run_session_id, achievement_id 등
  created_at timestamptz default now()
);

-- 인덱스
create index idx_user_xp_logs_user on user_xp_logs(user_id);
```

### user_achievements (획득한 업적)

```sql
create table user_achievements (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade,
  achievement_id text not null,   -- 업적 식별자
  unlocked_at timestamptz default now(),

  unique(user_id, achievement_id)
);

-- 인덱스
create index idx_user_achievements_user on user_achievements(user_id);
```

### user_settings (사용자 설정)

```sql
create table user_settings (
  user_id uuid primary key references auth.users(id) on delete cascade,

  -- 러닝 설정
  auto_pause boolean default true,
  gps_precision text default 'normal',
  voice_coaching boolean default true,
  coaching_language text default 'ko',

  -- 단위 설정
  distance_unit text default 'km',
  weight_unit text default 'kg',

  -- 알림 설정
  running_reminder boolean default false,
  reminder_time time,
  achievement_notification boolean default true,
  challenge_notification boolean default true,

  updated_at timestamptz default now()
);

-- RLS 정책
alter table user_settings enable row level security;

create policy "Users can manage own settings"
  on user_settings for all
  using (auth.uid() = user_id);
```

### 통계 집계 뷰

```sql
-- 사용자별 통계 집계 뷰
create view user_stats_summary as
select
  user_id,
  -- 전체 누적
  count(*) as total_run_count,
  coalesce(sum(distance_meters) / 1000.0, 0) as total_distance_km,
  coalesce(sum(duration_seconds), 0) as total_duration_seconds,
  coalesce(sum(calories_burned), 0) as total_calories,

  -- 평균
  coalesce(avg(distance_meters / nullif(duration_seconds, 0) * 1000 / 60), 0) as avg_pace_min_per_km,
  coalesce(avg(distance_meters) / 1000.0, 0) as avg_distance_km,

  -- 최고 기록
  coalesce(max(distance_meters) / 1000.0, 0) as longest_run_km,
  coalesce(max(duration_seconds), 0) as longest_duration_seconds,
  coalesce(min(distance_meters / nullif(duration_seconds, 0) * 1000 / 60), 0) as fastest_pace_min_per_km,

  -- 이번 달
  coalesce(sum(case when date_trunc('month', started_at) = date_trunc('month', now())
      then distance_meters else 0 end) / 1000.0, 0) as monthly_distance_km,
  coalesce(sum(case when date_trunc('month', started_at) = date_trunc('month', now())
      then duration_seconds else 0 end), 0) as monthly_duration_seconds,
  count(case when date_trunc('month', started_at) = date_trunc('month', now())
      then 1 end) as monthly_run_count,

  -- 이번 주
  coalesce(sum(case when date_trunc('week', started_at) = date_trunc('week', now())
      then distance_meters else 0 end) / 1000.0, 0) as weekly_distance_km,
  count(case when date_trunc('week', started_at) = date_trunc('week', now())
      then 1 end) as weekly_run_count

from run_sessions
where status = 'completed'
group by user_id;

-- 사용자별 총 XP
create view user_total_xp as
select
  user_id,
  coalesce(sum(xp_amount), 0) as total_xp
from user_xp_logs
group by user_id;
```

---

## 4. 레벨 & 칭호 시스템

### 레벨 테이블

| 레벨 | 필요 XP | 누적 XP | 칭호 |
|------|---------|---------|------|
| 1 | 0 | 0 | 러닝 입문자 |
| 2 | 100 | 100 | 러닝 초보자 |
| 3 | 200 | 300 | 꾸준한 러너 |
| 4 | 300 | 600 | 성실한 러너 |
| 5 | 400 | 1,000 | 러닝메이트 |
| 7 | 500 | 2,000 | 열정 러너 |
| 10 | 700 | 4,100 | 숙련 러너 |
| 15 | 1,000 | 9,100 | 베테랑 러너 |
| 20 | 1,400 | 16,100 | 마라토너 |
| 25 | 1,800 | 25,100 | 엘리트 러너 |
| 30 | 2,300 | 36,600 | 마스터 러너 |

### XP 획득 조건

| 활동 | XP |
|------|-----|
| 러닝 완료 (1km당) | +10 XP |
| 목표 페이스 달성 | +20 XP |
| 새 코스 완주 | +30 XP |
| 주간 목표 달성 | +50 XP |
| 업적 달성 (등급별) | +50~300 XP |
| 도전 완료 | +100 XP |
| 연속 러닝 보너스 (7일) | +70 XP |
| 연속 러닝 보너스 (30일) | +200 XP |

### 레벨 계산 로직

```dart
class LevelService {
  static const levelTable = [
    (level: 1, cumulativeXp: 0, title: '러닝 입문자'),
    (level: 2, cumulativeXp: 100, title: '러닝 초보자'),
    (level: 3, cumulativeXp: 300, title: '꾸준한 러너'),
    (level: 4, cumulativeXp: 600, title: '성실한 러너'),
    (level: 5, cumulativeXp: 1000, title: '러닝메이트'),
    (level: 7, cumulativeXp: 2000, title: '열정 러너'),
    (level: 10, cumulativeXp: 4100, title: '숙련 러너'),
    (level: 15, cumulativeXp: 9100, title: '베테랑 러너'),
    (level: 20, cumulativeXp: 16100, title: '마라토너'),
    (level: 25, cumulativeXp: 25100, title: '엘리트 러너'),
    (level: 30, cumulativeXp: 36600, title: '마스터 러너'),
  ];

  UserLevel calculateLevel(int totalXp) {
    var current = levelTable.first;
    var next = levelTable.length > 1 ? levelTable[1] : current;

    for (var i = 0; i < levelTable.length; i++) {
      if (totalXp >= levelTable[i].cumulativeXp) {
        current = levelTable[i];
        next = i < levelTable.length - 1 ? levelTable[i + 1] : current;
      }
    }

    final xpInCurrentLevel = totalXp - current.cumulativeXp;
    final xpNeededForNext = next.cumulativeXp - current.cumulativeXp;

    return UserLevel(
      level: current.level,
      currentXp: xpInCurrentLevel,
      xpForNextLevel: xpNeededForNext,
      title: current.title,
    );
  }
}
```

---

## 5. 업적 시스템

### 업적 카테고리 및 목록

**거리 업적 (Distance)**

| ID | 업적 | 조건 | XP |
|----|------|------|-----|
| dist_first | 🥉 첫 발자국 | 첫 러닝 완료 | +50 |
| dist_10 | 🥈 10km 달성 | 누적 10km | +50 |
| dist_50 | 🥈 50km 돌파 | 누적 50km | +75 |
| dist_100 | 🥇 100km 클럽 | 누적 100km | +100 |
| dist_500 | 🏆 500km 러너 | 누적 500km | +200 |
| dist_1000 | 🏆 1000km 전설 | 누적 1000km | +300 |

**연속 업적 (Streak)**

| ID | 업적 | 조건 | XP |
|----|------|------|-----|
| streak_3 | 🔥 3일 연속 | 3일 연속 러닝 | +30 |
| streak_7 | 🔥🔥 7일 연속 | 7일 연속 러닝 | +70 |
| streak_14 | 🔥🔥 2주 연속 | 14일 연속 러닝 | +100 |
| streak_30 | 🔥🔥🔥 30일 연속 | 30일 연속 러닝 | +200 |
| streak_100 | 💎 100일 연속 | 100일 연속 러닝 | +500 |

**기록 업적 (Record)**

| ID | 업적 | 조건 | XP |
|----|------|------|-----|
| pace_6 | ⚡ 6분 페이스 | 6분/km 이하 달성 | +50 |
| pace_5 | ⚡⚡ 5분 페이스 | 5분/km 이하 달성 | +100 |
| pace_4 | ⚡⚡⚡ 4분 페이스 | 4분/km 이하 달성 | +200 |
| run_10k | 🏃 10K 완주 | 한 번에 10km 완주 | +100 |
| run_half | 🏃 하프 마라톤 | 한 번에 21km 완주 | +150 |
| run_full | 🏃‍♂️ 풀 마라톤 | 한 번에 42km 완주 | +300 |

**탐험 업적 (Exploration)**

| ID | 업적 | 조건 | XP |
|----|------|------|-----|
| course_5 | 🗺️ 탐험 시작 | 5개 코스 완주 | +50 |
| course_10 | 🗺️🗺️ 탐험가 | 10개 코스 완주 | +100 |
| course_50 | 🌍 코스 마스터 | 50개 코스 완주 | +200 |

**소셜 업적 (Social)**

| ID | 업적 | 조건 | XP |
|----|------|------|-----|
| share_first | 📤 첫 공유 | 코스 첫 공유 | +30 |
| review_10 | ⭐ 리뷰어 | 10개 코스 리뷰 작성 | +50 |
| challenge_join | 🤝 도전자 | 첫 도전 참여 | +30 |
| challenge_win | 🏆 챔피언 | 도전 1위 달성 | +100 |

### 업적 체크 로직

```dart
class AchievementService {
  Future<List<Achievement>> checkNewAchievements(String userId) async {
    final stats = await getProfileStats(userId);
    final existing = await getUnlockedAchievements(userId);
    final newAchievements = <Achievement>[];

    // 거리 업적 체크
    if (!existing.contains('dist_10') && stats.totalDistanceKm >= 10) {
      newAchievements.add(achievements['dist_10']!);
    }
    // ... 기타 업적 체크

    // 새 업적 저장 및 XP 부여
    for (final achievement in newAchievements) {
      await unlockAchievement(userId, achievement);
      await addXp(userId, achievement.xpReward, 'achievement', achievement.id);
    }

    return newAchievements;
  }
}
```

---

## 6. 설정 화면 구조

### 메뉴 구성

```
[설정]
├── 러닝 설정
│   ├── 자동 일시정지 (on/off)
│   ├── GPS 정밀도 (높음/보통/절전)
│   ├── 음성 코칭 (on/off)
│   └── 코칭 언어 (한국어/English)
│
├── 단위 설정
│   ├── 거리 (km/mi)
│   └── 체중 (kg/lb)
│
├── 알림 설정
│   ├── 러닝 리마인더 (on/off)
│   ├── 리마인더 시간
│   ├── 업적 알림 (on/off)
│   └── 도전 알림 (on/off)
│
├── 개인정보
│   ├── 닉네임 수정
│   ├── 체중 수정
│   └── 목표 수정
│
├── 계정
│   ├── 연결된 계정 (Google/Apple/카카오)
│   ├── 로그아웃
│   └── 회원 탈퇴
│
└── 앱 정보
    ├── 버전 정보
    ├── 이용약관
    ├── 개인정보처리방침
    └── 오픈소스 라이선스
```

### 설정별 저장 위치

| 설정 | 저장 위치 | 이유 |
|------|----------|------|
| 러닝 설정 | 로컬 + 서버 | 기기 간 동기화 |
| 단위 설정 | 로컬 + 서버 | 기기 간 동기화 |
| 알림 설정 | 로컬 + 서버 | 기기 간 동기화 |
| 개인정보 | 서버 | Auth와 연동 |

---

## 7. 아키텍처

### 폴더 구조

```
lib/features/profile/
├── data/
│   ├── datasources/
│   │   ├── profile_remote_datasource.dart
│   │   └── settings_local_datasource.dart
│   ├── models/
│   │   ├── profile_stats_model.dart
│   │   ├── user_level_model.dart
│   │   ├── achievement_model.dart
│   │   └── user_settings_model.dart
│   └── repositories/
│       ├── profile_repository_impl.dart
│       ├── achievement_repository_impl.dart
│       └── settings_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── profile_stats.dart
│   │   ├── user_level.dart
│   │   ├── achievement.dart
│   │   └── user_settings.dart
│   ├── repositories/
│   │   ├── profile_repository.dart
│   │   ├── achievement_repository.dart
│   │   └── settings_repository.dart
│   └── usecases/
│       ├── get_profile_stats.dart
│       ├── get_user_level.dart
│       ├── get_achievements.dart
│       ├── check_new_achievements.dart
│       ├── get_settings.dart
│       └── update_settings.dart
└── presentation/
    ├── providers/
    │   ├── profile_providers.dart
    │   ├── stats_provider.dart
    │   ├── level_provider.dart
    │   ├── achievements_provider.dart
    │   └── settings_provider.dart
    ├── screens/
    │   ├── profile_screen.dart
    │   ├── stats_detail_screen.dart
    │   ├── achievements_screen.dart
    │   ├── settings_screen.dart
    │   └── edit_profile_screen.dart
    └── widgets/
        ├── profile_header.dart
        ├── stats_summary_card.dart
        ├── level_progress_bar.dart
        ├── achievement_badge.dart
        ├── achievement_showcase.dart
        ├── goal_progress_card.dart
        └── settings_tile.dart
```

### Provider 구조

```dart
// 프로필 통계
@riverpod
Future<ProfileStats> profileStats(ProfileStatsRef ref) async {
  final repository = ref.watch(profileRepositoryProvider);
  final userId = ref.watch(currentUserIdProvider);
  return repository.getStats(userId);
}

// 유저 레벨
@riverpod
Future<UserLevel> userLevel(UserLevelRef ref) async {
  final repository = ref.watch(profileRepositoryProvider);
  final userId = ref.watch(currentUserIdProvider);
  final totalXp = await repository.getTotalXp(userId);
  return LevelService.calculateLevel(totalXp);
}

// 업적 목록
@riverpod
Future<List<Achievement>> achievements(AchievementsRef ref) async {
  final repository = ref.watch(achievementRepositoryProvider);
  final userId = ref.watch(currentUserIdProvider);
  return repository.getAchievements(userId);
}

// 설정
@riverpod
class Settings extends _$Settings {
  @override
  Future<UserSettings> build() async {
    final repository = ref.watch(settingsRepositoryProvider);
    return repository.getSettings();
  }

  Future<void> update(UserSettings settings) async {
    final repository = ref.read(settingsRepositoryProvider);
    await repository.saveSettings(settings);
    ref.invalidateSelf();
  }
}
```

---

## 8. UI 컴포넌트

### ProfileHeader

```dart
class ProfileHeader extends StatelessWidget {
  final UserProfile profile;
  final UserLevel level;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: profile.avatarUrl != null
            ? NetworkImage(profile.avatarUrl!)
            : null,
          child: profile.avatarUrl == null
            ? Text(profile.nickname[0])
            : null,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(profile.nickname, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('Lv.${level.level} ${level.title}', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              LevelProgressBar(
                current: level.currentXp,
                max: level.xpForNextLevel,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
```

### LevelProgressBar

```dart
class LevelProgressBar extends StatelessWidget {
  final int current;
  final int max;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: current / max,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
        ),
        const SizedBox(height: 4),
        Text('$current / $max XP', style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
```

### AchievementBadge

```dart
class AchievementBadge extends StatelessWidget {
  final Achievement achievement;
  final bool showProgress;

  @override
  Widget build(BuildContext context) {
    final isLocked = !achievement.isUnlocked;

    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isLocked ? Colors.grey[300] : Colors.amber[100],
            border: Border.all(
              color: isLocked ? Colors.grey : Colors.amber,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              achievement.iconUrl,  // 이모지 사용
              style: TextStyle(
                fontSize: 32,
                color: isLocked ? Colors.grey : null,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          achievement.name,
          style: TextStyle(
            fontSize: 12,
            color: isLocked ? Colors.grey : Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        if (showProgress && !achievement.isUnlocked && achievement.currentProgress != null)
          Text(
            '${achievement.currentProgress}/${achievement.targetProgress}',
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
      ],
    );
  }
}
```

---

## 9. 연속 러닝 (Streak) 계산

### 로직

```dart
class StreakService {
  Future<int> calculateCurrentStreak(String userId) async {
    // 오늘 기준으로 연속 러닝 일수 계산
    final runs = await getRunsByUser(userId, orderByDate: true);

    if (runs.isEmpty) return 0;

    int streak = 0;
    DateTime checkDate = DateTime.now();

    // 오늘 러닝이 없으면 어제부터 시작
    final todayRuns = runs.where((r) => isSameDay(r.startedAt, checkDate));
    if (todayRuns.isEmpty) {
      checkDate = checkDate.subtract(Duration(days: 1));
    }

    for (final run in runs) {
      if (isSameDay(run.startedAt, checkDate)) {
        streak++;
        checkDate = checkDate.subtract(Duration(days: 1));
      } else if (run.startedAt.isBefore(checkDate)) {
        break;  // 연속 끊김
      }
    }

    return streak;
  }
}
```

### Supabase Function (선택)

```sql
create or replace function get_current_streak(p_user_id uuid)
returns int as $$
declare
  streak int := 0;
  check_date date := current_date;
  has_run boolean;
begin
  loop
    select exists(
      select 1 from run_sessions
      where user_id = p_user_id
        and date(started_at) = check_date
        and status = 'completed'
    ) into has_run;

    if has_run then
      streak := streak + 1;
      check_date := check_date - interval '1 day';
    else
      -- 오늘 러닝 없으면 어제부터 체크
      if check_date = current_date then
        check_date := check_date - interval '1 day';
      else
        exit;
      end if;
    end if;
  end loop;

  return streak;
end;
$$ language plpgsql;
```

---

## 10. 테스트 전략

### 우선순위

| 우선순위 | 영역 | 이유 |
|----------|------|------|
| 🔴 높음 | LevelService | XP/레벨 계산 핵심 로직 |
| 🔴 높음 | AchievementService | 업적 체크 조건 |
| 🔴 높음 | StreakService | 연속 기록 계산 |
| 🟡 중간 | ProfileRepository | 통계 집계 정확성 |
| 🟡 중간 | SettingsRepository | 설정 저장/로드 |
| 🟢 낮음 | ProfileScreen | UI 렌더링 |

### 주요 테스트 케이스

**LevelService**
- XP 0 → 레벨 1
- XP 100 → 레벨 2
- XP 경계값 테스트 (99, 100, 101)
- 최대 레벨 도달

**AchievementService**
- 조건 미충족 시 미획득
- 조건 충족 시 획득
- 중복 획득 방지
- XP 정상 부여

**StreakService**
- 연속 러닝 정상 계산
- 하루 건너뜀 → 연속 끊김
- 오늘 러닝 없을 때 어제부터 계산
- 빈 기록 → 0

---

## 기술 스택

| 영역 | 기술 |
|------|------|
| 상태 관리 | Riverpod |
| 데이터베이스 | Supabase PostgreSQL |
| 로컬 저장 | SharedPreferences (설정) |
| 차트 | fl_chart (통계 시각화) |

---

## 다음 단계

1. Course Recommendation 구현 완료 후 진행
2. Auth 구현 후 Profile 구현 (의존성)
3. Tracking 구현과 함께 업적 체크 연동
