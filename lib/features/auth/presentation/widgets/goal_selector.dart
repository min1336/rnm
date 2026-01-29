import 'package:flutter/material.dart';
import '../../domain/entities/running_goal.dart';

class GoalSelector extends StatelessWidget {
  final RunningGoal? value;
  final ValueChanged<RunningGoal?> onChanged;

  const GoalSelector({
    super.key,
    this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '러닝 목표가 있나요?',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          '목표에 맞는 코스를 추천해드려요 (선택사항)',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 24),
        ...RunningGoal.values.map((goal) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _GoalOption(
                goal: goal,
                isSelected: value == goal,
                onTap: () => onChanged(goal),
              ),
            )),
        const SizedBox(height: 8),
        Center(
          child: TextButton(
            onPressed: () => onChanged(null),
            child: const Text('목표 없이 시작하기'),
          ),
        ),
      ],
    );
  }
}

class _GoalOption extends StatelessWidget {
  final RunningGoal goal;
  final bool isSelected;
  final VoidCallback onTap;

  const _GoalOption({
    required this.goal,
    required this.isSelected,
    required this.onTap,
  });

  IconData get _icon => switch (goal) {
        RunningGoal.marathon => Icons.emoji_events,
        RunningGoal.diet => Icons.monitor_weight,
        RunningGoal.fitness => Icons.fitness_center,
        RunningGoal.stress => Icons.self_improvement,
      };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? Theme.of(context).primaryColor.withOpacity(0.1)
              : null,
        ),
        child: Row(
          children: [
            Icon(
              _icon,
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.grey[600],
            ),
            const SizedBox(width: 16),
            Text(
              goal.label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Theme.of(context).primaryColor,
              ),
          ],
        ),
      ),
    );
  }
}
