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
