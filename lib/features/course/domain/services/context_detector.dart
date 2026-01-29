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
