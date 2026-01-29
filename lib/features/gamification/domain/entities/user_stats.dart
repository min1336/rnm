import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_stats.freezed.dart';

/// 사용자 통계 정보 (업적 체크용)
///
/// 사용자의 러닝 활동 통계를 집계하여
/// 업적 달성 여부를 체크하는데 사용됩니다.
@freezed
class UserStats with _$UserStats {
  const factory UserStats({
    /// 총 러닝 횟수
    required int totalRuns,

    /// 총 누적 거리 (km)
    required double totalDistanceKm,

    /// 현재 연속 러닝 일수
    required int currentStreak,

    /// 고유 코스 탐험 개수
    required int uniqueCourseCount,

    /// 코스 공유 횟수
    required int sharedCourseCount,

    /// 새벽 러닝 횟수 (05:00-07:00)
    required int earlyRunCount,

    /// 야간 러닝 횟수 (21:00-23:00)
    required int nightRunCount,

    /// 주말 연속 러닝 횟수
    required int weekendStreak,
  }) = _UserStats;
}
