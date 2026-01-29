# 러닝 코스 추천 시스템 구현 계획

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 위치, 실력, 목표를 복합적으로 고려한 맞춤형 러닝 코스 추천 시스템 구현

**Architecture:** Clean Architecture (Domain → Data → Presentation) 레이어 순서로 구현. 추천 알고리즘은 ContextDetector, WeightCalculator, CourseScorer로 분리하여 단일 책임 원칙 준수. Riverpod으로 상태 관리.

**Tech Stack:** Flutter, Dart, Freezed, Riverpod, Supabase, Mapbox

**Design Document:** `docs/plans/2026-01-29-course-recommendation-design.md`

---

## Phase 1: Domain Layer - Entities

### Task 1.1: Course Entity 생성

**Files:**
- Create: `lib/features/course/domain/entities/course.dart`
- Test: `test/features/course/domain/entities/course_test.dart`

**Step 1: 테스트 파일 생성**

```dart
// test/features/course/domain/entities/course_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/course/domain/entities/course.dart';

void main() {
  group('Course', () {
    test('should create Course with required fields', () {
      final course = Course(
        id: '1',
        name: '한강 여의도 코스',
        routePoints: [
          LatLng(37.5283, 126.9322),
          LatLng(37.5290, 126.9350),
        ],
        distanceKm: 3.2,
        estimatedMinutes: 20,
        difficulty: 3,
        isOfficial: true,
        averageRating: 4.5,
        totalRuns: 150,
        createdAt: DateTime(2026, 1, 1),
      );

      expect(course.id, '1');
      expect(course.name, '한강 여의도 코스');
      expect(course.distanceKm, 3.2);
      expect(course.difficulty, 3);
      expect(course.isOfficial, true);
    });

    test('should have nullable creatorId for official courses', () {
      final course = Course(
        id: '1',
        name: '공식 코스',
        routePoints: [],
        distanceKm: 5.0,
        estimatedMinutes: 30,
        difficulty: 2,
        isOfficial: true,
        averageRating: 0,
        totalRuns: 0,
        createdAt: DateTime.now(),
      );

      expect(course.creatorId, isNull);
    });
  });
}
```

**Step 2: 테스트 실패 확인**

Run: `flutter test test/features/course/domain/entities/course_test.dart`
Expected: FAIL - "Target of URI hasn't been generated"

**Step 3: Entity 구현**

```dart
// lib/features/course/domain/entities/course.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'course.freezed.dart';

@freezed
class LatLng with _$LatLng {
  const factory LatLng(double latitude, double longitude) = _LatLng;
}

@freezed
class Course with _$Course {
  const factory Course({
    required String id,
    required String name,
    String? description,
    required List<LatLng> routePoints,
    required double distanceKm,
    required int estimatedMinutes,
    required int difficulty,
    String? creatorId,
    required bool isOfficial,
    required double averageRating,
    required int totalRuns,
    required DateTime createdAt,
  }) = _Course;
}
```

**Step 4: 코드 생성**

Run: `dart run build_runner build --delete-conflicting-outputs`
Expected: "Succeeded after" 메시지

**Step 5: 테스트 통과 확인**

Run: `flutter test test/features/course/domain/entities/course_test.dart`
Expected: PASS

**Step 6: 커밋**

```bash
git add lib/features/course/domain/entities/course.dart lib/features/course/domain/entities/course.freezed.dart test/features/course/domain/entities/course_test.dart
git commit -m "feat(course): Course entity 추가"
```

---

### Task 1.2: UserRunningProfile Entity 생성

**Files:**
- Create: `lib/features/course/domain/entities/user_running_profile.dart`
- Test: `test/features/course/domain/entities/user_running_profile_test.dart`

**Step 1: 테스트 파일 생성**

```dart
// test/features/course/domain/entities/user_running_profile_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/course/domain/entities/user_running_profile.dart';

void main() {
  group('UserRunningProfile', () {
    test('should create profile with calculated level', () {
      final profile = UserRunningProfile(
        userId: 'user-1',
        averagePaceMinPerKm: 5.5,
        averageDistanceKm: 5.0,
        weeklyRunCount: 3,
        calculatedLevel: 3,
        lastRunAt: DateTime(2026, 1, 28),
        levelUpdatedAt: DateTime(2026, 1, 28),
      );

      expect(profile.calculatedLevel, 3);
      expect(profile.goal, isNull);
    });

    test('should support optional goal', () {
      final profile = UserRunningProfile(
        userId: 'user-1',
        averagePaceMinPerKm: 5.5,
        averageDistanceKm: 5.0,
        weeklyRunCount: 3,
        calculatedLevel: 3,
        goal: RunningGoal.marathon,
        lastRunAt: DateTime(2026, 1, 28),
        levelUpdatedAt: DateTime(2026, 1, 28),
      );

      expect(profile.goal, RunningGoal.marathon);
    });
  });
}
```

**Step 2: 테스트 실패 확인**

Run: `flutter test test/features/course/domain/entities/user_running_profile_test.dart`
Expected: FAIL

**Step 3: Entity 구현**

```dart
// lib/features/course/domain/entities/user_running_profile.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_running_profile.freezed.dart';

enum RunningGoal {
  marathon,
  diet,
  health,
  stress,
}

@freezed
class UserRunningProfile with _$UserRunningProfile {
  const factory UserRunningProfile({
    required String userId,
    required double averagePaceMinPerKm,
    required double averageDistanceKm,
    required int weeklyRunCount,
    required int calculatedLevel,
    RunningGoal? goal,
    required DateTime lastRunAt,
    required DateTime levelUpdatedAt,
  }) = _UserRunningProfile;
}
```

**Step 4: 코드 생성**

Run: `dart run build_runner build --delete-conflicting-outputs`

**Step 5: 테스트 통과 확인**

Run: `flutter test test/features/course/domain/entities/user_running_profile_test.dart`
Expected: PASS

**Step 6: 커밋**

```bash
git add lib/features/course/domain/entities/ test/features/course/domain/entities/
git commit -m "feat(course): UserRunningProfile entity 추가"
```

---

### Task 1.3: RunningContext Enum 생성

**Files:**
- Create: `lib/features/course/domain/entities/running_context.dart`
- Test: `test/features/course/domain/entities/running_context_test.dart`

**Step 1: 테스트 파일 생성**

```dart
// test/features/course/domain/entities/running_context_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/course/domain/entities/running_context.dart';

void main() {
  group('RunningContext', () {
    test('should have correct weight values for quick mode', () {
      final weights = RunningContext.quick.weights;

      expect(weights.distance, 0.5);
      expect(weights.difficulty, 0.2);
      expect(weights.goal, 0.1);
      expect(weights.popularity, 0.2);
    });

    test('should have correct weight values for training mode', () {
      final weights = RunningContext.training.weights;

      expect(weights.distance, 0.2);
      expect(weights.difficulty, 0.4);
      expect(weights.goal, 0.3);
      expect(weights.popularity, 0.1);
    });

    test('weights should sum to 1.0', () {
      for (final context in RunningContext.values) {
        final weights = context.weights;
        final sum = weights.distance + weights.difficulty + weights.goal + weights.popularity;
        expect(sum, closeTo(1.0, 0.001));
      }
    });
  });
}
```

**Step 2: 테스트 실패 확인**

Run: `flutter test test/features/course/domain/entities/running_context_test.dart`
Expected: FAIL

**Step 3: Entity 구현**

```dart
// lib/features/course/domain/entities/running_context.dart
class RecommendationWeights {
  final double distance;
  final double difficulty;
  final double goal;
  final double popularity;

  const RecommendationWeights({
    required this.distance,
    required this.difficulty,
    required this.goal,
    required this.popularity,
  });
}

enum RunningContext {
  defaultMode(
    RecommendationWeights(distance: 0.3, difficulty: 0.3, goal: 0.2, popularity: 0.2),
  ),
  quick(
    RecommendationWeights(distance: 0.5, difficulty: 0.2, goal: 0.1, popularity: 0.2),
  ),
  training(
    RecommendationWeights(distance: 0.2, difficulty: 0.4, goal: 0.3, popularity: 0.1),
  ),
  explore(
    RecommendationWeights(distance: 0.3, difficulty: 0.2, goal: 0.1, popularity: 0.4),
  );

  final RecommendationWeights weights;

  const RunningContext(this.weights);
}
```

**Step 4: 테스트 통과 확인**

Run: `flutter test test/features/course/domain/entities/running_context_test.dart`
Expected: PASS

**Step 5: 커밋**

```bash
git add lib/features/course/domain/entities/running_context.dart test/features/course/domain/entities/running_context_test.dart
git commit -m "feat(course): RunningContext enum 및 가중치 추가"
```

---

### Task 1.4: ScoredCourse Entity 생성

**Files:**
- Create: `lib/features/course/domain/entities/scored_course.dart`
- Test: `test/features/course/domain/entities/scored_course_test.dart`

**Step 1: 테스트 파일 생성**

```dart
// test/features/course/domain/entities/scored_course_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/course/domain/entities/course.dart';
import 'package:running_mate/features/course/domain/entities/scored_course.dart';

void main() {
  group('ScoredCourse', () {
    test('should contain course with score and reason', () {
      final course = Course(
        id: '1',
        name: '테스트 코스',
        routePoints: [],
        distanceKm: 3.0,
        estimatedMinutes: 18,
        difficulty: 3,
        isOfficial: true,
        averageRating: 4.5,
        totalRuns: 100,
        createdAt: DateTime.now(),
      );

      final scoredCourse = ScoredCourse(
        course: course,
        totalScore: 85.5,
        reason: '집에서 가깝고 난이도가 적절해요',
      );

      expect(scoredCourse.totalScore, 85.5);
      expect(scoredCourse.reason, contains('가깝고'));
    });
  });
}
```

**Step 2: 테스트 실패 확인**

Run: `flutter test test/features/course/domain/entities/scored_course_test.dart`
Expected: FAIL

**Step 3: Entity 구현**

```dart
// lib/features/course/domain/entities/scored_course.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'course.dart';

part 'scored_course.freezed.dart';

@freezed
class ScoredCourse with _$ScoredCourse {
  const factory ScoredCourse({
    required Course course,
    required double totalScore,
    required String reason,
  }) = _ScoredCourse;
}
```

**Step 4: 코드 생성**

Run: `dart run build_runner build --delete-conflicting-outputs`

**Step 5: 테스트 통과 확인**

Run: `flutter test test/features/course/domain/entities/scored_course_test.dart`
Expected: PASS

**Step 6: 커밋**

```bash
git add lib/features/course/domain/entities/scored_course.dart lib/features/course/domain/entities/scored_course.freezed.dart test/features/course/domain/entities/scored_course_test.dart
git commit -m "feat(course): ScoredCourse entity 추가"
```

---

## Phase 2: 추천 알고리즘 핵심 로직

### Task 2.1: ContextDetector 구현

**Files:**
- Create: `lib/features/course/domain/services/context_detector.dart`
- Test: `test/features/course/domain/services/context_detector_test.dart`

**Step 1: 테스트 파일 생성**

```dart
// test/features/course/domain/services/context_detector_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/course/domain/entities/running_context.dart';
import 'package:running_mate/features/course/domain/services/context_detector.dart';

void main() {
  late ContextDetector detector;

  setUp(() {
    detector = ContextDetector();
  });

  group('ContextDetector', () {
    test('weekday morning (6-8am) should return quick mode', () {
      // 월요일 오전 7시
      final monday7am = DateTime(2026, 1, 27, 7, 0); // 월요일
      final result = detector.detect(
        currentTime: monday7am,
        lastRunAt: DateTime(2026, 1, 26),
        recentCourseIds: [],
      );

      expect(result.context, RunningContext.quick);
      expect(result.isConfident, true);
    });

    test('weekend afternoon should return default mode with low confidence', () {
      // 토요일 오후 2시
      final saturday2pm = DateTime(2026, 1, 25, 14, 0); // 토요일
      final result = detector.detect(
        currentTime: saturday2pm,
        lastRunAt: DateTime(2026, 1, 24),
        recentCourseIds: [],
      );

      expect(result.context, RunningContext.defaultMode);
      expect(result.isConfident, false);
    });

    test('same course 3+ times should suggest explore mode', () {
      final result = detector.detect(
        currentTime: DateTime(2026, 1, 28, 18, 0),
        lastRunAt: DateTime(2026, 1, 27),
        recentCourseIds: ['course-1', 'course-1', 'course-1'],
      );

      expect(result.context, RunningContext.explore);
      expect(result.isConfident, true);
    });

    test('no run for 3+ days on weekend should suggest training', () {
      final saturday = DateTime(2026, 1, 25, 10, 0);
      final result = detector.detect(
        currentTime: saturday,
        lastRunAt: DateTime(2026, 1, 20), // 5일 전
        recentCourseIds: [],
      );

      expect(result.context, RunningContext.training);
      expect(result.isConfident, true);
    });
  });
}
```

**Step 2: 테스트 실패 확인**

Run: `flutter test test/features/course/domain/services/context_detector_test.dart`
Expected: FAIL

**Step 3: ContextDetector 구현**

```dart
// lib/features/course/domain/services/context_detector.dart
import '../entities/running_context.dart';

class ContextDetectionResult {
  final RunningContext context;
  final bool isConfident;

  const ContextDetectionResult({
    required this.context,
    required this.isConfident,
  });
}

class ContextDetector {
  ContextDetectionResult detect({
    required DateTime currentTime,
    required DateTime? lastRunAt,
    required List<String> recentCourseIds,
  }) {
    // 같은 코스 3회 이상 → 탐험 모드
    if (_hasSameCourseRepeatedly(recentCourseIds)) {
      return const ContextDetectionResult(
        context: RunningContext.explore,
        isConfident: true,
      );
    }

    final isWeekend = currentTime.weekday == DateTime.saturday ||
        currentTime.weekday == DateTime.sunday;
    final hour = currentTime.hour;

    // 오랜만에 러닝 + 주말 → 훈련 모드
    if (lastRunAt != null) {
      final daysSinceLastRun = currentTime.difference(lastRunAt).inDays;
      if (daysSinceLastRun >= 3 && isWeekend) {
        return const ContextDetectionResult(
          context: RunningContext.training,
          isConfident: true,
        );
      }
    }

    // 평일 아침 (6-8시) 또는 점심 (12-13시) → 빠른 러닝
    final isWeekday = !isWeekend;
    final isMorningCommute = hour >= 6 && hour <= 8;
    final isLunchTime = hour >= 12 && hour <= 13;

    if (isWeekday && (isMorningCommute || isLunchTime)) {
      return const ContextDetectionResult(
        context: RunningContext.quick,
        isConfident: true,
      );
    }

    // 기본값 (확신 없음 → 1-tap 확인 필요)
    return const ContextDetectionResult(
      context: RunningContext.defaultMode,
      isConfident: false,
    );
  }

  bool _hasSameCourseRepeatedly(List<String> courseIds) {
    if (courseIds.length < 3) return false;

    final counts = <String, int>{};
    for (final id in courseIds) {
      counts[id] = (counts[id] ?? 0) + 1;
      if (counts[id]! >= 3) return true;
    }
    return false;
  }
}
```

**Step 4: 테스트 통과 확인**

Run: `flutter test test/features/course/domain/services/context_detector_test.dart`
Expected: PASS

**Step 5: 커밋**

```bash
git add lib/features/course/domain/services/context_detector.dart test/features/course/domain/services/context_detector_test.dart
git commit -m "feat(course): ContextDetector 구현 - 상황 자동 감지"
```

---

### Task 2.2: CourseScorer 구현

**Files:**
- Create: `lib/features/course/domain/services/course_scorer.dart`
- Test: `test/features/course/domain/services/course_scorer_test.dart`

**Step 1: 테스트 파일 생성**

```dart
// test/features/course/domain/services/course_scorer_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/course/domain/entities/course.dart';
import 'package:running_mate/features/course/domain/entities/running_context.dart';
import 'package:running_mate/features/course/domain/entities/user_running_profile.dart';
import 'package:running_mate/features/course/domain/services/course_scorer.dart';

void main() {
  late CourseScorer scorer;

  setUp(() {
    scorer = CourseScorer();
  });

  group('CourseScorer', () {
    final testCourse = Course(
      id: '1',
      name: '테스트 코스',
      routePoints: [LatLng(37.5, 127.0)],
      distanceKm: 3.0,
      estimatedMinutes: 18,
      difficulty: 3,
      isOfficial: true,
      averageRating: 4.0,
      totalRuns: 100,
      createdAt: DateTime.now(),
    );

    final testProfile = UserRunningProfile(
      userId: 'user-1',
      averagePaceMinPerKm: 6.0,
      averageDistanceKm: 5.0,
      weeklyRunCount: 3,
      calculatedLevel: 3,
      lastRunAt: DateTime.now(),
      levelUpdatedAt: DateTime.now(),
    );

    test('should return 100 for distance score when course is within 1km', () {
      final score = scorer.calculateDistanceScore(
        courseStartLat: 37.5,
        courseStartLng: 127.0,
        userLat: 37.5,
        userLng: 127.0,
      );

      expect(score, 100);
    });

    test('should return 0 for distance score when course is 10km+ away', () {
      final score = scorer.calculateDistanceScore(
        courseStartLat: 37.5,
        courseStartLng: 127.0,
        userLat: 37.6, // 약 11km 떨어진 위치
        userLng: 127.0,
      );

      expect(score, lessThanOrEqualTo(10));
    });

    test('should return 100 for difficulty score when level matches exactly', () {
      final score = scorer.calculateDifficultyScore(
        courseDifficulty: 3,
        userLevel: 3,
      );

      expect(score, 100);
    });

    test('should return 70 for difficulty score when 1 level difference', () {
      final score = scorer.calculateDifficultyScore(
        courseDifficulty: 4,
        userLevel: 3,
      );

      expect(score, 70);
    });

    test('should return 80 (average) for popularity score with 4.0 rating', () {
      final score = scorer.calculatePopularityScore(averageRating: 4.0);

      expect(score, 80);
    });

    test('should calculate total score with weights', () {
      final result = scorer.score(
        course: testCourse,
        profile: testProfile,
        userLat: 37.5,
        userLng: 127.0,
        weights: RunningContext.defaultMode.weights,
      );

      expect(result.totalScore, greaterThan(0));
      expect(result.totalScore, lessThanOrEqualTo(100));
      expect(result.reason, isNotEmpty);
    });
  });
}
```

**Step 2: 테스트 실패 확인**

Run: `flutter test test/features/course/domain/services/course_scorer_test.dart`
Expected: FAIL

**Step 3: CourseScorer 구현**

```dart
// lib/features/course/domain/services/course_scorer.dart
import 'dart:math';
import '../entities/course.dart';
import '../entities/running_context.dart';
import '../entities/scored_course.dart';
import '../entities/user_running_profile.dart';

class CourseScorer {
  ScoredCourse score({
    required Course course,
    required UserRunningProfile profile,
    required double userLat,
    required double userLng,
    required RecommendationWeights weights,
  }) {
    final startPoint = course.routePoints.isNotEmpty
        ? course.routePoints.first
        : LatLng(userLat, userLng);

    final distanceScore = calculateDistanceScore(
      courseStartLat: startPoint.latitude,
      courseStartLng: startPoint.longitude,
      userLat: userLat,
      userLng: userLng,
    );

    final difficultyScore = calculateDifficultyScore(
      courseDifficulty: course.difficulty,
      userLevel: profile.calculatedLevel,
    );

    final goalScore = calculateGoalScore(
      course: course,
      goal: profile.goal,
    );

    final popularityScore = calculatePopularityScore(
      averageRating: course.averageRating,
    );

    final totalScore = (distanceScore * weights.distance) +
        (difficultyScore * weights.difficulty) +
        (goalScore * weights.goal) +
        (popularityScore * weights.popularity);

    final reason = _generateReason(
      distanceScore: distanceScore,
      difficultyScore: difficultyScore,
      goalScore: goalScore,
      popularityScore: popularityScore,
    );

    return ScoredCourse(
      course: course,
      totalScore: totalScore,
      reason: reason,
    );
  }

  double calculateDistanceScore({
    required double courseStartLat,
    required double courseStartLng,
    required double userLat,
    required double userLng,
  }) {
    final distanceKm = _haversineDistance(
      userLat,
      userLng,
      courseStartLat,
      courseStartLng,
    );

    // 1km 이내: 100점, 10km 이상: 0점 (선형 감소)
    if (distanceKm <= 1) return 100;
    if (distanceKm >= 10) return 0;

    return 100 - ((distanceKm - 1) * (100 / 9));
  }

  double calculateDifficultyScore({
    required int courseDifficulty,
    required int userLevel,
  }) {
    final diff = (courseDifficulty - userLevel).abs();

    return switch (diff) {
      0 => 100,
      1 => 70,
      2 => 40,
      _ => 10,
    };
  }

  double calculateGoalScore({
    required Course course,
    required RunningGoal? goal,
  }) {
    if (goal == null) return 50; // 중립

    return switch (goal) {
      RunningGoal.marathon => course.distanceKm >= 5 ? 100 : 50,
      RunningGoal.diet => course.distanceKm >= 3 ? 80 : 60,
      RunningGoal.health => 70,
      RunningGoal.stress => course.difficulty <= 2 ? 90 : 50,
    };
  }

  double calculatePopularityScore({required double averageRating}) {
    return averageRating * 20; // 5점 만점 → 100점
  }

  double _haversineDistance(
    double lat1,
    double lng1,
    double lat2,
    double lng2,
  ) {
    const earthRadiusKm = 6371.0;

    final dLat = _degreesToRadians(lat2 - lat1);
    final dLng = _degreesToRadians(lng2 - lng1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLng / 2) *
            sin(dLng / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadiusKm * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  String _generateReason({
    required double distanceScore,
    required double difficultyScore,
    required double goalScore,
    required double popularityScore,
  }) {
    final reasons = <String>[];

    if (distanceScore >= 80) {
      reasons.add('가까운 거리');
    }
    if (difficultyScore >= 80) {
      reasons.add('적절한 난이도');
    }
    if (goalScore >= 80) {
      reasons.add('목표에 적합');
    }
    if (popularityScore >= 80) {
      reasons.add('높은 평점');
    }

    if (reasons.isEmpty) {
      return '추천 코스';
    }

    return reasons.join(', ');
  }
}
```

**Step 4: 테스트 통과 확인**

Run: `flutter test test/features/course/domain/services/course_scorer_test.dart`
Expected: PASS

**Step 5: 커밋**

```bash
git add lib/features/course/domain/services/course_scorer.dart test/features/course/domain/services/course_scorer_test.dart
git commit -m "feat(course): CourseScorer 구현 - 점수 계산 알고리즘"
```

---

### Task 2.3: RecommendationEngine 구현

**Files:**
- Create: `lib/features/course/domain/services/recommendation_engine.dart`
- Test: `test/features/course/domain/services/recommendation_engine_test.dart`

**Step 1: 테스트 파일 생성**

```dart
// test/features/course/domain/services/recommendation_engine_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/course/domain/entities/course.dart';
import 'package:running_mate/features/course/domain/entities/running_context.dart';
import 'package:running_mate/features/course/domain/entities/user_running_profile.dart';
import 'package:running_mate/features/course/domain/services/context_detector.dart';
import 'package:running_mate/features/course/domain/services/course_scorer.dart';
import 'package:running_mate/features/course/domain/services/recommendation_engine.dart';

void main() {
  late RecommendationEngine engine;

  setUp(() {
    engine = RecommendationEngine(
      contextDetector: ContextDetector(),
      courseScorer: CourseScorer(),
    );
  });

  group('RecommendationEngine', () {
    final courses = [
      Course(
        id: '1',
        name: '가까운 쉬운 코스',
        routePoints: [LatLng(37.5, 127.0)],
        distanceKm: 2.0,
        estimatedMinutes: 12,
        difficulty: 1,
        isOfficial: true,
        averageRating: 3.5,
        totalRuns: 50,
        createdAt: DateTime.now(),
      ),
      Course(
        id: '2',
        name: '먼 어려운 코스',
        routePoints: [LatLng(37.6, 127.1)],
        distanceKm: 10.0,
        estimatedMinutes: 60,
        difficulty: 5,
        isOfficial: true,
        averageRating: 4.8,
        totalRuns: 200,
        createdAt: DateTime.now(),
      ),
      Course(
        id: '3',
        name: '적절한 코스',
        routePoints: [LatLng(37.51, 127.01)],
        distanceKm: 5.0,
        estimatedMinutes: 30,
        difficulty: 3,
        isOfficial: true,
        averageRating: 4.5,
        totalRuns: 150,
        createdAt: DateTime.now(),
      ),
    ];

    final profile = UserRunningProfile(
      userId: 'user-1',
      averagePaceMinPerKm: 6.0,
      averageDistanceKm: 5.0,
      weeklyRunCount: 3,
      calculatedLevel: 3,
      lastRunAt: DateTime.now().subtract(const Duration(days: 1)),
      levelUpdatedAt: DateTime.now(),
    );

    test('should return courses sorted by score', () {
      final result = engine.recommend(
        courses: courses,
        profile: profile,
        userLat: 37.5,
        userLng: 127.0,
        context: RunningContext.defaultMode,
      );

      expect(result.length, 3);
      // 점수 순 정렬 확인
      for (int i = 0; i < result.length - 1; i++) {
        expect(result[i].totalScore, greaterThanOrEqualTo(result[i + 1].totalScore));
      }
    });

    test('should limit results to specified count', () {
      final result = engine.recommend(
        courses: courses,
        profile: profile,
        userLat: 37.5,
        userLng: 127.0,
        context: RunningContext.defaultMode,
        limit: 2,
      );

      expect(result.length, 2);
    });

    test('quick mode should favor nearby courses', () {
      final quickResult = engine.recommend(
        courses: courses,
        profile: profile,
        userLat: 37.5,
        userLng: 127.0,
        context: RunningContext.quick,
      );

      // 빠른 모드에서는 가까운 코스가 상위에
      expect(quickResult.first.course.id, '1'); // 가장 가까운 코스
    });
  });
}
```

**Step 2: 테스트 실패 확인**

Run: `flutter test test/features/course/domain/services/recommendation_engine_test.dart`
Expected: FAIL

**Step 3: RecommendationEngine 구현**

```dart
// lib/features/course/domain/services/recommendation_engine.dart
import '../entities/course.dart';
import '../entities/running_context.dart';
import '../entities/scored_course.dart';
import '../entities/user_running_profile.dart';
import 'context_detector.dart';
import 'course_scorer.dart';

class RecommendationEngine {
  final ContextDetector contextDetector;
  final CourseScorer courseScorer;

  const RecommendationEngine({
    required this.contextDetector,
    required this.courseScorer,
  });

  List<ScoredCourse> recommend({
    required List<Course> courses,
    required UserRunningProfile profile,
    required double userLat,
    required double userLng,
    required RunningContext context,
    int limit = 10,
  }) {
    final scoredCourses = courses.map((course) {
      return courseScorer.score(
        course: course,
        profile: profile,
        userLat: userLat,
        userLng: userLng,
        weights: context.weights,
      );
    }).toList();

    // 점수 높은 순으로 정렬
    scoredCourses.sort((a, b) => b.totalScore.compareTo(a.totalScore));

    // 상위 N개 반환
    return scoredCourses.take(limit).toList();
  }

  ContextDetectionResult detectContext({
    required DateTime currentTime,
    required DateTime? lastRunAt,
    required List<String> recentCourseIds,
  }) {
    return contextDetector.detect(
      currentTime: currentTime,
      lastRunAt: lastRunAt,
      recentCourseIds: recentCourseIds,
    );
  }
}
```

**Step 4: 테스트 통과 확인**

Run: `flutter test test/features/course/domain/services/recommendation_engine_test.dart`
Expected: PASS

**Step 5: 커밋**

```bash
git add lib/features/course/domain/services/recommendation_engine.dart test/features/course/domain/services/recommendation_engine_test.dart
git commit -m "feat(course): RecommendationEngine 구현 - 추천 로직 통합"
```

---

## Phase 3: Data Layer

### Task 3.1: Course Model (JSON Serialization) 생성

**Files:**
- Create: `lib/features/course/data/models/course_model.dart`
- Test: `test/features/course/data/models/course_model_test.dart`

**Step 1: 테스트 파일 생성**

```dart
// test/features/course/data/models/course_model_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:running_mate/features/course/data/models/course_model.dart';

void main() {
  group('CourseModel', () {
    final testJson = {
      'id': '123',
      'name': '한강 코스',
      'description': '좋은 코스입니다',
      'route_points': [
        {'lat': 37.5, 'lng': 127.0},
        {'lat': 37.51, 'lng': 127.01},
      ],
      'distance_km': 3.5,
      'estimated_minutes': 21,
      'difficulty': 3,
      'creator_id': 'user-1',
      'is_official': false,
      'average_rating': 4.2,
      'total_runs': 50,
      'created_at': '2026-01-15T10:00:00.000Z',
    };

    test('should parse from JSON correctly', () {
      final model = CourseModel.fromJson(testJson);

      expect(model.id, '123');
      expect(model.name, '한강 코스');
      expect(model.routePoints.length, 2);
      expect(model.distanceKm, 3.5);
      expect(model.difficulty, 3);
    });

    test('should convert to entity correctly', () {
      final model = CourseModel.fromJson(testJson);
      final entity = model.toEntity();

      expect(entity.id, '123');
      expect(entity.routePoints.first.latitude, 37.5);
    });

    test('should convert to JSON correctly', () {
      final model = CourseModel.fromJson(testJson);
      final json = model.toJson();

      expect(json['id'], '123');
      expect(json['distance_km'], 3.5);
    });
  });
}
```

**Step 2: 테스트 실패 확인**

Run: `flutter test test/features/course/data/models/course_model_test.dart`
Expected: FAIL

**Step 3: Model 구현**

```dart
// lib/features/course/data/models/course_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/course.dart';

part 'course_model.freezed.dart';
part 'course_model.g.dart';

@freezed
class RoutePointModel with _$RoutePointModel {
  const factory RoutePointModel({
    required double lat,
    required double lng,
  }) = _RoutePointModel;

  factory RoutePointModel.fromJson(Map<String, dynamic> json) =>
      _$RoutePointModelFromJson(json);
}

@freezed
class CourseModel with _$CourseModel {
  const CourseModel._();

  const factory CourseModel({
    required String id,
    required String name,
    String? description,
    @JsonKey(name: 'route_points') required List<RoutePointModel> routePoints,
    @JsonKey(name: 'distance_km') required double distanceKm,
    @JsonKey(name: 'estimated_minutes') required int estimatedMinutes,
    required int difficulty,
    @JsonKey(name: 'creator_id') String? creatorId,
    @JsonKey(name: 'is_official') required bool isOfficial,
    @JsonKey(name: 'average_rating') required double averageRating,
    @JsonKey(name: 'total_runs') required int totalRuns,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _CourseModel;

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  Course toEntity() {
    return Course(
      id: id,
      name: name,
      description: description,
      routePoints: routePoints
          .map((p) => LatLng(p.lat, p.lng))
          .toList(),
      distanceKm: distanceKm,
      estimatedMinutes: estimatedMinutes,
      difficulty: difficulty,
      creatorId: creatorId,
      isOfficial: isOfficial,
      averageRating: averageRating,
      totalRuns: totalRuns,
      createdAt: DateTime.parse(createdAt),
    );
  }

  static CourseModel fromEntity(Course entity) {
    return CourseModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      routePoints: entity.routePoints
          .map((p) => RoutePointModel(lat: p.latitude, lng: p.longitude))
          .toList(),
      distanceKm: entity.distanceKm,
      estimatedMinutes: entity.estimatedMinutes,
      difficulty: entity.difficulty,
      creatorId: entity.creatorId,
      isOfficial: entity.isOfficial,
      averageRating: entity.averageRating,
      totalRuns: entity.totalRuns,
      createdAt: entity.createdAt.toIso8601String(),
    );
  }
}
```

**Step 4: 코드 생성**

Run: `dart run build_runner build --delete-conflicting-outputs`

**Step 5: 테스트 통과 확인**

Run: `flutter test test/features/course/data/models/course_model_test.dart`
Expected: PASS

**Step 6: 커밋**

```bash
git add lib/features/course/data/models/ test/features/course/data/models/
git commit -m "feat(course): CourseModel 추가 - JSON 직렬화"
```

---

### Task 3.2: CourseRepository Interface 생성

**Files:**
- Create: `lib/features/course/domain/repositories/course_repository.dart`

**Step 1: Repository 인터페이스 구현**

```dart
// lib/features/course/domain/repositories/course_repository.dart
import '../entities/course.dart';
import '../entities/user_running_profile.dart';

abstract class CourseRepository {
  /// 모든 코스 조회
  Future<List<Course>> getAllCourses();

  /// 코스 상세 조회
  Future<Course?> getCourseById(String id);

  /// 사용자 프로필 조회
  Future<UserRunningProfile?> getUserProfile(String userId);

  /// 최근 러닝한 코스 ID 목록 조회
  Future<List<String>> getRecentCourseIds(String userId, {int limit = 10});

  /// 코스 평가
  Future<void> rateCourse({
    required String courseId,
    required String odString userId,
    required int rating,
  });

  /// 코스 공유 (사용자 생성 코스)
  Future<Course> shareCourse(Course course);
}
```

**Step 2: 커밋**

```bash
git add lib/features/course/domain/repositories/course_repository.dart
git commit -m "feat(course): CourseRepository 인터페이스 정의"
```

---

### Task 3.3: CourseRemoteDataSource 구현

**Files:**
- Create: `lib/features/course/data/datasources/course_remote_datasource.dart`
- Test: `test/features/course/data/datasources/course_remote_datasource_test.dart`

**Step 1: 테스트 파일 생성 (Mock 기반)**

```dart
// test/features/course/data/datasources/course_remote_datasource_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:running_mate/features/course/data/datasources/course_remote_datasource.dart';

@GenerateMocks([SupabaseClient, SupabaseQueryBuilder, PostgrestFilterBuilder])
import 'course_remote_datasource_test.mocks.dart';

void main() {
  // Note: 실제 Supabase 테스트는 통합 테스트로 진행
  // 단위 테스트에서는 데이터소스 구조만 검증

  group('CourseRemoteDataSource', () {
    test('should be instantiated with SupabaseClient', () {
      final mockClient = MockSupabaseClient();
      final datasource = CourseRemoteDataSource(mockClient);

      expect(datasource, isNotNull);
    });
  });
}
```

**Step 2: DataSource 구현**

```dart
// lib/features/course/data/datasources/course_remote_datasource.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/course_model.dart';

class CourseRemoteDataSource {
  final SupabaseClient _client;

  CourseRemoteDataSource(this._client);

  Future<List<CourseModel>> getAllCourses() async {
    final response = await _client
        .from('courses')
        .select()
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => CourseModel.fromJson(json))
        .toList();
  }

  Future<CourseModel?> getCourseById(String id) async {
    final response = await _client
        .from('courses')
        .select()
        .eq('id', id)
        .maybeSingle();

    if (response == null) return null;
    return CourseModel.fromJson(response);
  }

  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    final response = await _client
        .from('user_running_profiles')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    return response;
  }

  Future<List<String>> getRecentCourseIds(String userId, {int limit = 10}) async {
    final response = await _client
        .from('run_histories')
        .select('course_id')
        .eq('user_id', userId)
        .not('course_id', 'is', null)
        .order('run_at', ascending: false)
        .limit(limit);

    return (response as List)
        .map((row) => row['course_id'] as String)
        .toList();
  }

  Future<void> rateCourse({
    required String courseId,
    required String odString userId,
    required int rating,
  }) async {
    await _client.from('course_ratings').upsert({
      'course_id': courseId,
      'user_id': userId,
      'rating': rating,
    }, onConflict: 'course_id,user_id');

    // 평균 평점 업데이트
    await _updateAverageRating(courseId);
  }

  Future<void> _updateAverageRating(String courseId) async {
    final response = await _client
        .from('course_ratings')
        .select('rating')
        .eq('course_id', courseId);

    final ratings = (response as List).map((r) => r['rating'] as int);
    if (ratings.isEmpty) return;

    final average = ratings.reduce((a, b) => a + b) / ratings.length;

    await _client
        .from('courses')
        .update({'average_rating': average})
        .eq('id', courseId);
  }

  Future<CourseModel> createCourse(CourseModel course) async {
    final response = await _client
        .from('courses')
        .insert(course.toJson())
        .select()
        .single();

    return CourseModel.fromJson(response);
  }
}
```

**Step 3: 코드 생성 (mockito)**

Run: `dart run build_runner build --delete-conflicting-outputs`

**Step 4: 커밋**

```bash
git add lib/features/course/data/datasources/ test/features/course/data/datasources/
git commit -m "feat(course): CourseRemoteDataSource 구현 - Supabase 연동"
```

---

### Task 3.4: CourseRepositoryImpl 구현

**Files:**
- Create: `lib/features/course/data/repositories/course_repository_impl.dart`
- Test: `test/features/course/data/repositories/course_repository_impl_test.dart`

**Step 1: 테스트 파일 생성**

```dart
// test/features/course/data/repositories/course_repository_impl_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:running_mate/features/course/data/datasources/course_remote_datasource.dart';
import 'package:running_mate/features/course/data/models/course_model.dart';
import 'package:running_mate/features/course/data/repositories/course_repository_impl.dart';

@GenerateMocks([CourseRemoteDataSource])
import 'course_repository_impl_test.mocks.dart';

void main() {
  late CourseRepositoryImpl repository;
  late MockCourseRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockCourseRemoteDataSource();
    repository = CourseRepositoryImpl(mockDataSource);
  });

  group('CourseRepositoryImpl', () {
    test('getAllCourses should return list of Course entities', () async {
      final models = [
        CourseModel(
          id: '1',
          name: 'Test Course',
          routePoints: [],
          distanceKm: 3.0,
          estimatedMinutes: 18,
          difficulty: 3,
          isOfficial: true,
          averageRating: 4.0,
          totalRuns: 100,
          createdAt: '2026-01-15T10:00:00.000Z',
        ),
      ];

      when(mockDataSource.getAllCourses()).thenAnswer((_) async => models);

      final result = await repository.getAllCourses();

      expect(result.length, 1);
      expect(result.first.id, '1');
      expect(result.first.name, 'Test Course');
      verify(mockDataSource.getAllCourses()).called(1);
    });
  });
}
```

**Step 2: 테스트 실패 확인**

Run: `flutter test test/features/course/data/repositories/course_repository_impl_test.dart`
Expected: FAIL

**Step 3: Repository 구현**

```dart
// lib/features/course/data/repositories/course_repository_impl.dart
import '../../domain/entities/course.dart';
import '../../domain/entities/user_running_profile.dart';
import '../../domain/repositories/course_repository.dart';
import '../datasources/course_remote_datasource.dart';
import '../models/course_model.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseRemoteDataSource _dataSource;

  CourseRepositoryImpl(this._dataSource);

  @override
  Future<List<Course>> getAllCourses() async {
    final models = await _dataSource.getAllCourses();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Course?> getCourseById(String id) async {
    final model = await _dataSource.getCourseById(id);
    return model?.toEntity();
  }

  @override
  Future<UserRunningProfile?> getUserProfile(String userId) async {
    final data = await _dataSource.getUserProfile(userId);
    if (data == null) return null;

    return UserRunningProfile(
      userId: data['user_id'],
      averagePaceMinPerKm: (data['average_pace_min_per_km'] as num).toDouble(),
      averageDistanceKm: (data['average_distance_km'] as num).toDouble(),
      weeklyRunCount: data['weekly_run_count'],
      calculatedLevel: data['calculated_level'],
      goal: _parseGoal(data['goal']),
      lastRunAt: DateTime.parse(data['last_run_at']),
      levelUpdatedAt: DateTime.parse(data['level_updated_at']),
    );
  }

  RunningGoal? _parseGoal(String? goal) {
    if (goal == null) return null;
    return RunningGoal.values.firstWhere(
      (g) => g.name == goal,
      orElse: () => RunningGoal.health,
    );
  }

  @override
  Future<List<String>> getRecentCourseIds(String userId, {int limit = 10}) {
    return _dataSource.getRecentCourseIds(userId, limit: limit);
  }

  @override
  Future<void> rateCourse({
    required String courseId,
    required String odString userId,
    required int rating,
  }) {
    return _dataSource.rateCourse(
      courseId: courseId,
      userId: userId,
      rating: rating,
    );
  }

  @override
  Future<Course> shareCourse(Course course) async {
    final model = CourseModel.fromEntity(course);
    final created = await _dataSource.createCourse(model);
    return created.toEntity();
  }
}
```

**Step 4: 코드 생성**

Run: `dart run build_runner build --delete-conflicting-outputs`

**Step 5: 테스트 통과 확인**

Run: `flutter test test/features/course/data/repositories/course_repository_impl_test.dart`
Expected: PASS

**Step 6: 커밋**

```bash
git add lib/features/course/data/repositories/ test/features/course/data/repositories/
git commit -m "feat(course): CourseRepositoryImpl 구현"
```

---

## Phase 4: Use Cases

### Task 4.1: GetRecommendedCourses UseCase 구현

**Files:**
- Create: `lib/features/course/domain/usecases/get_recommended_courses.dart`
- Test: `test/features/course/domain/usecases/get_recommended_courses_test.dart`

**Step 1: 테스트 파일 생성**

```dart
// test/features/course/domain/usecases/get_recommended_courses_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:running_mate/features/course/domain/entities/course.dart';
import 'package:running_mate/features/course/domain/entities/running_context.dart';
import 'package:running_mate/features/course/domain/entities/user_running_profile.dart';
import 'package:running_mate/features/course/domain/repositories/course_repository.dart';
import 'package:running_mate/features/course/domain/services/recommendation_engine.dart';
import 'package:running_mate/features/course/domain/usecases/get_recommended_courses.dart';

@GenerateMocks([CourseRepository, RecommendationEngine])
import 'get_recommended_courses_test.mocks.dart';

void main() {
  late GetRecommendedCourses useCase;
  late MockCourseRepository mockRepository;
  late MockRecommendationEngine mockEngine;

  setUp(() {
    mockRepository = MockCourseRepository();
    mockEngine = MockRecommendationEngine();
    useCase = GetRecommendedCourses(
      repository: mockRepository,
      engine: mockEngine,
    );
  });

  group('GetRecommendedCourses', () {
    test('should fetch courses and return recommendations', () async {
      final courses = [
        Course(
          id: '1',
          name: 'Test',
          routePoints: [],
          distanceKm: 3.0,
          estimatedMinutes: 18,
          difficulty: 3,
          isOfficial: true,
          averageRating: 4.0,
          totalRuns: 100,
          createdAt: DateTime.now(),
        ),
      ];

      final profile = UserRunningProfile(
        userId: 'user-1',
        averagePaceMinPerKm: 6.0,
        averageDistanceKm: 5.0,
        weeklyRunCount: 3,
        calculatedLevel: 3,
        lastRunAt: DateTime.now(),
        levelUpdatedAt: DateTime.now(),
      );

      when(mockRepository.getAllCourses()).thenAnswer((_) async => courses);
      when(mockRepository.getUserProfile('user-1')).thenAnswer((_) async => profile);
      when(mockRepository.getRecentCourseIds('user-1')).thenAnswer((_) async => []);
      when(mockEngine.detectContext(
        currentTime: anyNamed('currentTime'),
        lastRunAt: anyNamed('lastRunAt'),
        recentCourseIds: anyNamed('recentCourseIds'),
      )).thenReturn(ContextDetectionResult(
        context: RunningContext.defaultMode,
        isConfident: true,
      ));
      when(mockEngine.recommend(
        courses: anyNamed('courses'),
        profile: anyNamed('profile'),
        userLat: anyNamed('userLat'),
        userLng: anyNamed('userLng'),
        context: anyNamed('context'),
        limit: anyNamed('limit'),
      )).thenReturn([]);

      final result = await useCase.execute(
        userId: 'user-1',
        userLat: 37.5,
        userLng: 127.0,
      );

      expect(result, isNotNull);
      verify(mockRepository.getAllCourses()).called(1);
    });
  });
}
```

**Step 2: UseCase 구현**

```dart
// lib/features/course/domain/usecases/get_recommended_courses.dart
import '../entities/running_context.dart';
import '../entities/scored_course.dart';
import '../entities/user_running_profile.dart';
import '../repositories/course_repository.dart';
import '../services/context_detector.dart';
import '../services/recommendation_engine.dart';

class RecommendationResult {
  final List<ScoredCourse> courses;
  final RunningContext context;
  final bool needsConfirmation;

  const RecommendationResult({
    required this.courses,
    required this.context,
    required this.needsConfirmation,
  });
}

class GetRecommendedCourses {
  final CourseRepository repository;
  final RecommendationEngine engine;

  const GetRecommendedCourses({
    required this.repository,
    required this.engine,
  });

  Future<RecommendationResult> execute({
    required String userId,
    required double userLat,
    required double userLng,
    RunningContext? overrideContext,
    int limit = 10,
  }) async {
    // 1. 데이터 조회
    final courses = await repository.getAllCourses();
    final profile = await repository.getUserProfile(userId);
    final recentCourseIds = await repository.getRecentCourseIds(userId);

    // 프로필이 없으면 기본값 사용
    final effectiveProfile = profile ?? _defaultProfile(userId);

    // 2. 상황 감지 (override가 없을 때만)
    final RunningContext context;
    final bool needsConfirmation;

    if (overrideContext != null) {
      context = overrideContext;
      needsConfirmation = false;
    } else {
      final detection = engine.detectContext(
        currentTime: DateTime.now(),
        lastRunAt: effectiveProfile.lastRunAt,
        recentCourseIds: recentCourseIds,
      );
      context = detection.context;
      needsConfirmation = !detection.isConfident;
    }

    // 3. 추천 생성
    final recommendations = engine.recommend(
      courses: courses,
      profile: effectiveProfile,
      userLat: userLat,
      userLng: userLng,
      context: context,
      limit: limit,
    );

    return RecommendationResult(
      courses: recommendations,
      context: context,
      needsConfirmation: needsConfirmation,
    );
  }

  UserRunningProfile _defaultProfile(String userId) {
    return UserRunningProfile(
      userId: userId,
      averagePaceMinPerKm: 6.0,
      averageDistanceKm: 3.0,
      weeklyRunCount: 0,
      calculatedLevel: 3, // 중급으로 시작
      lastRunAt: DateTime.now(),
      levelUpdatedAt: DateTime.now(),
    );
  }
}
```

**Step 3: 코드 생성**

Run: `dart run build_runner build --delete-conflicting-outputs`

**Step 4: 테스트 통과 확인**

Run: `flutter test test/features/course/domain/usecases/get_recommended_courses_test.dart`
Expected: PASS

**Step 5: 커밋**

```bash
git add lib/features/course/domain/usecases/ test/features/course/domain/usecases/
git commit -m "feat(course): GetRecommendedCourses UseCase 구현"
```

---

## Phase 5: Presentation Layer (Providers)

### Task 5.1: Course Providers 설정

**Files:**
- Create: `lib/features/course/presentation/providers/course_providers.dart`

**Step 1: Providers 구현**

```dart
// lib/features/course/presentation/providers/course_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/datasources/course_remote_datasource.dart';
import '../../data/repositories/course_repository_impl.dart';
import '../../domain/entities/running_context.dart';
import '../../domain/entities/scored_course.dart';
import '../../domain/repositories/course_repository.dart';
import '../../domain/services/context_detector.dart';
import '../../domain/services/course_scorer.dart';
import '../../domain/services/recommendation_engine.dart';
import '../../domain/usecases/get_recommended_courses.dart';

// Supabase Client
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

// Data Sources
final courseRemoteDataSourceProvider = Provider<CourseRemoteDataSource>((ref) {
  return CourseRemoteDataSource(ref.watch(supabaseClientProvider));
});

// Repositories
final courseRepositoryProvider = Provider<CourseRepository>((ref) {
  return CourseRepositoryImpl(ref.watch(courseRemoteDataSourceProvider));
});

// Services
final contextDetectorProvider = Provider<ContextDetector>((ref) {
  return ContextDetector();
});

final courseScorerProvider = Provider<CourseScorer>((ref) {
  return CourseScorer();
});

final recommendationEngineProvider = Provider<RecommendationEngine>((ref) {
  return RecommendationEngine(
    contextDetector: ref.watch(contextDetectorProvider),
    courseScorer: ref.watch(courseScorerProvider),
  );
});

// Use Cases
final getRecommendedCoursesProvider = Provider<GetRecommendedCourses>((ref) {
  return GetRecommendedCourses(
    repository: ref.watch(courseRepositoryProvider),
    engine: ref.watch(recommendationEngineProvider),
  );
});

// State
final selectedContextProvider = StateProvider<RunningContext?>((ref) => null);

final userLocationProvider = StateProvider<({double lat, double lng})?>(
  (ref) => null,
);

// Recommendations
final recommendationsProvider = FutureProvider.autoDispose<RecommendationResult>((ref) async {
  final useCase = ref.watch(getRecommendedCoursesProvider);
  final location = ref.watch(userLocationProvider);
  final overrideContext = ref.watch(selectedContextProvider);

  // 위치가 없으면 기본값 사용
  final lat = location?.lat ?? 37.5665;
  final lng = location?.lng ?? 126.9780;

  // TODO: 실제 사용자 ID 사용
  const userId = 'current-user';

  return useCase.execute(
    userId: userId,
    userLat: lat,
    userLng: lng,
    overrideContext: overrideContext,
  );
});
```

**Step 2: 커밋**

```bash
git add lib/features/course/presentation/providers/
git commit -m "feat(course): Riverpod providers 설정"
```

---

## Phase 6: UI 구현

### Task 6.1: CourseCard Widget 구현

**Files:**
- Create: `lib/features/course/presentation/widgets/course_card.dart`

**Step 1: Widget 구현**

```dart
// lib/features/course/presentation/widgets/course_card.dart
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../domain/entities/scored_course.dart';

class CourseCard extends StatelessWidget {
  final ScoredCourse scoredCourse;
  final VoidCallback? onTap;

  const CourseCard({
    super.key,
    required this.scoredCourse,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final course = scoredCourse.course;

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingM,
        vertical: AppSizes.paddingS,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 헤더: 이름 + 공식 배지
              Row(
                children: [
                  if (course.isOfficial)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingS,
                        vertical: 2,
                      ),
                      margin: const EdgeInsets.only(right: AppSizes.paddingS),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(AppSizes.radiusS),
                      ),
                      child: const Text(
                        '공식',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  Expanded(
                    child: Text(
                      course.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.paddingS),

              // 정보: 거리, 시간, 별점
              Row(
                children: [
                  _InfoChip(
                    icon: Icons.straighten,
                    label: '${course.distanceKm.toStringAsFixed(1)}km',
                  ),
                  const SizedBox(width: AppSizes.paddingM),
                  _InfoChip(
                    icon: Icons.timer_outlined,
                    label: '${course.estimatedMinutes}분',
                  ),
                  const SizedBox(width: AppSizes.paddingM),
                  _InfoChip(
                    icon: Icons.star,
                    label: course.averageRating.toStringAsFixed(1),
                    iconColor: Colors.amber,
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.paddingS),

              // 난이도
              Row(
                children: [
                  const Text('난이도 ', style: TextStyle(fontSize: 12)),
                  ...List.generate(5, (index) {
                    return Icon(
                      Icons.circle,
                      size: 8,
                      color: index < course.difficulty
                          ? AppColors.primary
                          : Colors.grey.shade300,
                    );
                  }),
                ],
              ),
              const SizedBox(height: AppSizes.paddingS),

              // 추천 이유
              Text(
                scoredCourse.reason,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? iconColor;

  const _InfoChip({
    required this.icon,
    required this.label,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: iconColor ?? Colors.grey),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
```

**Step 2: 커밋**

```bash
git add lib/features/course/presentation/widgets/
git commit -m "feat(course): CourseCard 위젯 구현"
```

---

### Task 6.2: ContextConfirmDialog 구현

**Files:**
- Create: `lib/features/course/presentation/widgets/context_confirm_dialog.dart`

**Step 1: Dialog 구현**

```dart
// lib/features/course/presentation/widgets/context_confirm_dialog.dart
import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../domain/entities/running_context.dart';

class ContextConfirmDialog extends StatelessWidget {
  final RunningContext suggestedContext;
  final void Function(RunningContext) onContextSelected;

  const ContextConfirmDialog({
    super.key,
    required this.suggestedContext,
    required this.onContextSelected,
  });

  @override
  Widget build(BuildContext context) {
    final message = _getMessage(suggestedContext);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.paddingL),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => onContextSelected(RunningContext.quick),
                    child: const Text('네'),
                  ),
                ),
                const SizedBox(width: AppSizes.paddingM),
                Expanded(
                  child: FilledButton(
                    onPressed: () => onContextSelected(RunningContext.training),
                    child: const Text('훈련할래요'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getMessage(RunningContext context) {
    return switch (context) {
      RunningContext.quick => '오늘은 가볍게 뛸까요?',
      RunningContext.training => '훈련 모드로 추천해드릴까요?',
      RunningContext.explore => '새로운 코스를 탐험해볼까요?',
      RunningContext.defaultMode => '오늘은 가볍게 뛸까요?',
    };
  }
}

// 다이얼로그 표시 헬퍼 함수
Future<RunningContext?> showContextConfirmDialog(
  BuildContext context, {
  required RunningContext suggestedContext,
}) {
  return showDialog<RunningContext>(
    context: context,
    builder: (context) => ContextConfirmDialog(
      suggestedContext: suggestedContext,
      onContextSelected: (selected) => Navigator.of(context).pop(selected),
    ),
  );
}
```

**Step 2: 커밋**

```bash
git add lib/features/course/presentation/widgets/context_confirm_dialog.dart
git commit -m "feat(course): ContextConfirmDialog 구현 - 1-tap 확인"
```

---

### Task 6.3: CourseListScreen 구현

**Files:**
- Create: `lib/features/course/presentation/screens/course_list_screen.dart`

**Step 1: Screen 구현**

```dart
// lib/features/course/presentation/screens/course_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../domain/entities/running_context.dart';
import '../providers/course_providers.dart';
import '../widgets/context_confirm_dialog.dart';
import '../widgets/course_card.dart';

class CourseListScreen extends ConsumerStatefulWidget {
  const CourseListScreen({super.key});

  @override
  ConsumerState<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends ConsumerState<CourseListScreen> {
  bool _dialogShown = false;

  @override
  Widget build(BuildContext context) {
    final recommendationsAsync = ref.watch(recommendationsProvider);
    final selectedContext = ref.watch(selectedContextProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('추천 코스'),
      ),
      body: recommendationsAsync.when(
        data: (result) {
          // 확인 필요 시 다이얼로그 표시
          if (result.needsConfirmation && !_dialogShown && selectedContext == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showConfirmDialog(result.context);
            });
          }

          return Column(
            children: [
              // 상황 헤더
              _ContextHeader(context: selectedContext ?? result.context),

              // 빠른 필터
              _QuickFilters(
                selectedContext: selectedContext ?? result.context,
                onContextSelected: (context) {
                  ref.read(selectedContextProvider.notifier).state = context;
                },
              ),

              // 코스 목록
              Expanded(
                child: result.courses.isEmpty
                    ? const Center(child: Text('추천 코스가 없습니다'))
                    : ListView.builder(
                        itemCount: result.courses.length,
                        itemBuilder: (context, index) {
                          final scored = result.courses[index];
                          return CourseCard(
                            scoredCourse: scored,
                            onTap: () => context.push('/courses/${scored.course.id}'),
                          );
                        },
                      ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.grey),
              const SizedBox(height: AppSizes.paddingM),
              Text('오류가 발생했습니다: $error'),
              const SizedBox(height: AppSizes.paddingM),
              FilledButton(
                onPressed: () => ref.invalidate(recommendationsProvider),
                child: const Text('다시 시도'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showConfirmDialog(RunningContext suggestedContext) async {
    _dialogShown = true;
    final selected = await showContextConfirmDialog(
      context,
      suggestedContext: suggestedContext,
    );
    if (selected != null) {
      ref.read(selectedContextProvider.notifier).state = selected;
    }
  }
}

class _ContextHeader extends StatelessWidget {
  final RunningContext context;

  const _ContextHeader({required this.context});

  @override
  Widget build(BuildContext context) {
    final (icon, message) = switch (this.context) {
      RunningContext.quick => ('🏃', '빠르게 뛰기 좋은 코스'),
      RunningContext.training => ('💪', '훈련에 적합한 코스'),
      RunningContext.explore => ('🗺️', '새로운 코스 탐험'),
      RunningContext.defaultMode => ('✨', '오늘의 추천 코스'),
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.paddingM),
      color: AppColors.primary.withOpacity(0.1),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: AppSizes.paddingS),
          Text(
            message,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickFilters extends StatelessWidget {
  final RunningContext selectedContext;
  final void Function(RunningContext) onContextSelected;

  const _QuickFilters({
    required this.selectedContext,
    required this.onContextSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingM,
        vertical: AppSizes.paddingS,
      ),
      child: Row(
        children: [
          _FilterChip(
            label: '근처',
            isSelected: selectedContext == RunningContext.quick,
            onTap: () => onContextSelected(RunningContext.quick),
          ),
          const SizedBox(width: AppSizes.paddingS),
          _FilterChip(
            label: '훈련',
            isSelected: selectedContext == RunningContext.training,
            onTap: () => onContextSelected(RunningContext.training),
          ),
          const SizedBox(width: AppSizes.paddingS),
          _FilterChip(
            label: '새로운',
            isSelected: selectedContext == RunningContext.explore,
            onTap: () => onContextSelected(RunningContext.explore),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
    );
  }
}
```

**Step 2: 커밋**

```bash
git add lib/features/course/presentation/screens/
git commit -m "feat(course): CourseListScreen 구현"
```

---

### Task 6.4: 라우팅 업데이트

**Files:**
- Modify: `lib/app/routes.dart`

**Step 1: 라우트 추가**

```dart
// lib/app/routes.dart 에 추가
import '../features/course/presentation/screens/course_list_screen.dart';

// routes 리스트에 추가:
GoRoute(
  path: '/courses',
  builder: (context, state) => const CourseListScreen(),
),
```

**Step 2: 커밋**

```bash
git add lib/app/routes.dart
git commit -m "feat(course): 코스 목록 라우트 추가"
```

---

## Phase 7: 통합 및 정리

### Task 7.1: Feature Export 파일 생성

**Files:**
- Create: `lib/features/course/course.dart`

**Step 1: Export 파일 생성**

```dart
// lib/features/course/course.dart
// Domain
export 'domain/entities/course.dart';
export 'domain/entities/running_context.dart';
export 'domain/entities/scored_course.dart';
export 'domain/entities/user_running_profile.dart';
export 'domain/repositories/course_repository.dart';
export 'domain/services/context_detector.dart';
export 'domain/services/course_scorer.dart';
export 'domain/services/recommendation_engine.dart';
export 'domain/usecases/get_recommended_courses.dart';

// Data
export 'data/datasources/course_remote_datasource.dart';
export 'data/models/course_model.dart';
export 'data/repositories/course_repository_impl.dart';

// Presentation
export 'presentation/providers/course_providers.dart';
export 'presentation/screens/course_list_screen.dart';
export 'presentation/widgets/context_confirm_dialog.dart';
export 'presentation/widgets/course_card.dart';
```

**Step 2: 커밋**

```bash
git add lib/features/course/course.dart
git commit -m "feat(course): Feature export 파일 추가"
```

---

### Task 7.2: 전체 테스트 실행 및 검증

**Step 1: 모든 테스트 실행**

Run: `flutter test`
Expected: All tests passing

**Step 2: 정적 분석**

Run: `flutter analyze`
Expected: No issues found

**Step 3: 최종 커밋**

```bash
git add -A
git commit -m "feat(course): 코스 추천 시스템 Phase 1-7 완료

- Domain: Course, UserRunningProfile, RunningContext entities
- Algorithm: ContextDetector, CourseScorer, RecommendationEngine
- Data: CourseModel, CourseRemoteDataSource, CourseRepositoryImpl
- UseCase: GetRecommendedCourses
- Presentation: Providers, CourseListScreen, CourseCard
- 1-tap 확인 다이얼로그 구현"
```

---

## 다음 단계 (별도 구현 계획)

- **Phase 8**: 게이미피케이션 (업적, 레벨, 챌린지)
- **Phase 9**: 신규 사용자 온보딩 (10분 테스트 러닝)
- **Phase 10**: 코스 상세 화면 및 Mapbox 연동
- **Phase 11**: 코스 평가 및 공유 기능

---

## 총 예상 커밋 수

- Phase 1: 4 commits
- Phase 2: 3 commits
- Phase 3: 4 commits
- Phase 4: 1 commit
- Phase 5: 1 commit
- Phase 6: 4 commits
- Phase 7: 2 commits

**Total: 19 commits**
