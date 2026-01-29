import 'package:flutter/material.dart';

class LevelUpDialog extends StatelessWidget {
  final int newLevel;
  final String levelName;

  const LevelUpDialog({
    super.key,
    required this.newLevel,
    required this.levelName,
  });

  static Future<void> show(
      BuildContext context, int newLevel, String levelName) {
    return showDialog(
      context: context,
      builder: (context) => LevelUpDialog(
        newLevel: newLevel,
        levelName: levelName,
      ),
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
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_upward,
                color: theme.colorScheme.onPrimary,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '레벨 업!',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Lv.$newLevel',
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              levelName,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
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
