import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_streak.freezed.dart';

@freezed
class UserStreak with _$UserStreak {
  const factory UserStreak({
    required String userId,
    required int currentStreak,
    required int longestStreak,
    DateTime? lastRunDate,
    required DateTime updatedAt,
  }) = _UserStreak;
}
