import 'package:flutter/material.dart';
import '../../domain/entities/achievement.dart';

class AchievementCard extends StatelessWidget {
  final Achievement achievement;
  final bool isUnlocked;
  final DateTime? unlockedAt;

  const AchievementCard({
    super.key,
    required this.achievement,
    this.isUnlocked = false,
    this.unlockedAt,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUnlocked
            ? theme.colorScheme.primaryContainer
            : theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUnlocked
              ? theme.colorScheme.primary
              : theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isUnlocked
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getIconData(achievement.iconName),
              color: isUnlocked
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.outline,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement.name,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isUnlocked ? null : theme.colorScheme.outline,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  achievement.description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isUnlocked
                        ? theme.colorScheme.onSurfaceVariant
                        : theme.colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isUnlocked
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '+${achievement.xpReward} XP',
              style: theme.textTheme.labelSmall?.copyWith(
                color: isUnlocked
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.outline,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconData(String iconName) {
    return switch (iconName) {
      'footprints' => Icons.directions_walk,
      'road' => Icons.route,
      'medal' => Icons.military_tech,
      'trophy' => Icons.emoji_events,
      'star' => Icons.star,
      'fire' => Icons.local_fire_department,
      'flame' => Icons.whatshot,
      'calendar_check' => Icons.event_available,
      'map' => Icons.map,
      'map_marked' => Icons.explore,
      'share' => Icons.share,
      'speedometer' => Icons.speed,
      'speedometer_fast' => Icons.flash_on,
      'lightning' => Icons.bolt,
      'sunrise' => Icons.wb_twilight,
      'moon' => Icons.nightlight,
      'weekend' => Icons.weekend,
      'route' => Icons.moving,
      _ => Icons.emoji_events,
    };
  }
}
