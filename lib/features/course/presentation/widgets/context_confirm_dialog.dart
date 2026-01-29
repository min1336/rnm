import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../domain/entities/running_context.dart';

class ContextConfirmDialog extends StatelessWidget {
  final RunningContext suggestedContext;
  final void Function(RunningContext) onContextSelected;

  const ContextConfirmDialog({
    super.key,
    required this.suggestedContext,
    required this.onContextSelected,
  });

  @override
  Widget build(BuildContext context) {
    final message = _getMessage(suggestedContext);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacing24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.spacing24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => onContextSelected(RunningContext.quick),
                    child: const Text('네'),
                  ),
                ),
                const SizedBox(width: AppSizes.spacing16),
                Expanded(
                  child: FilledButton(
                    onPressed: () => onContextSelected(RunningContext.training),
                    child: const Text('훈련할래요'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getMessage(RunningContext context) {
    return switch (context) {
      RunningContext.quick => '오늘은 가볍게 뛸까요?',
      RunningContext.training => '훈련 모드로 추천해드릴까요?',
      RunningContext.explore => '새로운 코스를 탐험해볼까요?',
      RunningContext.defaultMode => '오늘은 가볍게 뛸까요?',
    };
  }
}

// 다이얼로그 표시 헬퍼 함수
Future<RunningContext?> showContextConfirmDialog(
  BuildContext context, {
  required RunningContext suggestedContext,
}) {
  return showDialog<RunningContext>(
    context: context,
    builder: (context) => ContextConfirmDialog(
      suggestedContext: suggestedContext,
      onContextSelected: (selected) => Navigator.of(context).pop(selected),
    ),
  );
}
