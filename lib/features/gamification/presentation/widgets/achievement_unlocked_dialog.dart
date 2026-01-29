import 'package:flutter/material.dart';
import '../../domain/entities/achievement.dart';
import 'achievement_card.dart';

class AchievementUnlockedDialog extends StatelessWidget {
  final List<Achievement> achievements;

  const AchievementUnlockedDialog({
    super.key,
    required this.achievements,
  });

  static Future<void> show(
      BuildContext context, List<Achievement> achievements) {
    if (achievements.isEmpty) return Future.value();
    return showDialog(
      context: context,
      builder: (context) =>
          AchievementUnlockedDialog(achievements: achievements),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.celebration,
              color: theme.colorScheme.primary,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              '업적 달성!',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...achievements.map((a) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: AchievementCard(achievement: a, isUnlocked: true),
                )),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('확인'),
            ),
          ],
        ),
      ),
    );
  }
}
