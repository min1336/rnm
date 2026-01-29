// lib/features/gamification/data/models/user_streak_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_streak.dart';

part 'user_streak_model.freezed.dart';
part 'user_streak_model.g.dart';

@freezed
class UserStreakModel with _$UserStreakModel {
  const UserStreakModel._();

  const factory UserStreakModel({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'current_streak') required int currentStreak,
    @JsonKey(name: 'longest_streak') required int longestStreak,
    @JsonKey(name: 'last_run_date') String? lastRunDate,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _UserStreakModel;

  factory UserStreakModel.fromJson(Map<String, dynamic> json) =>
      _$UserStreakModelFromJson(json);

  UserStreak toEntity() => UserStreak(
        userId: userId,
        currentStreak: currentStreak,
        longestStreak: longestStreak,
        lastRunDate: lastRunDate != null ? DateTime.parse(lastRunDate!) : null,
        updatedAt: DateTime.parse(updatedAt),
      );

  static UserStreakModel fromEntity(UserStreak entity) => UserStreakModel(
        userId: entity.userId,
        currentStreak: entity.currentStreak,
        longestStreak: entity.longestStreak,
        lastRunDate: entity.lastRunDate?.toIso8601String().split('T')[0],
        updatedAt: entity.updatedAt.toIso8601String(),
      );
}
