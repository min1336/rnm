import 'package:freezed_annotation/freezed_annotation.dart';
import '../services/level_calculator.dart';

part 'user_level.freezed.dart';

@freezed
class UserLevel with _$UserLevel {
  const UserLevel._();

  const factory UserLevel({
    required String userId,
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
