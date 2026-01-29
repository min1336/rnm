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
