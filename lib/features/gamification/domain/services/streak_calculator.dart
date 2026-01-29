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
