import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../domain/entities/running_context.dart';
import '../providers/course_providers.dart';
import '../widgets/context_confirm_dialog.dart';
import '../widgets/course_card.dart';

class CourseListScreen extends ConsumerStatefulWidget {
  const CourseListScreen({super.key});

  @override
  ConsumerState<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends ConsumerState<CourseListScreen> {
  bool _dialogShown = false;

  @override
  Widget build(BuildContext context) {
    final recommendationsAsync = ref.watch(recommendationsProvider);
    final selectedContext = ref.watch(selectedContextProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('추천 코스'),
      ),
      body: recommendationsAsync.when(
        data: (result) {
          // 확인 필요 시 다이얼로그 표시
          if (result.needsConfirmation && !_dialogShown && selectedContext == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showConfirmDialog(result.context);
            });
          }

          return Column(
            children: [
              // 상황 헤더
              _ContextHeader(context: selectedContext ?? result.context),

              // 빠른 필터
              _QuickFilters(
                selectedContext: selectedContext ?? result.context,
                onContextSelected: (context) {
                  ref.read(selectedContextProvider.notifier).state = context;
                },
              ),

              // 코스 목록
              Expanded(
                child: result.courses.isEmpty
                    ? const Center(child: Text('추천 코스가 없습니다'))
                    : ListView.builder(
                        itemCount: result.courses.length,
                        itemBuilder: (context, index) {
                          final scored = result.courses[index];
                          return CourseCard(
                            scoredCourse: scored,
                            onTap: () => context.push('/courses/${scored.course.id}'),
                          );
                        },
                      ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.grey),
              const SizedBox(height: AppSizes.spacing16),
              Text('오류가 발생했습니다: $error'),
              const SizedBox(height: AppSizes.spacing16),
              FilledButton(
                onPressed: () => ref.invalidate(recommendationsProvider),
                child: const Text('다시 시도'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showConfirmDialog(RunningContext suggestedContext) async {
    _dialogShown = true;
    final selected = await showContextConfirmDialog(
      context,
      suggestedContext: suggestedContext,
    );
    if (selected != null) {
      ref.read(selectedContextProvider.notifier).state = selected;
    }
  }
}

class _ContextHeader extends StatelessWidget {
  final RunningContext context;

  const _ContextHeader({required this.context});

  @override
  Widget build(BuildContext context) {
    final (icon, message) = switch (this.context) {
      RunningContext.quick => ('🏃', '빠르게 뛰기 좋은 코스'),
      RunningContext.training => ('💪', '훈련에 적합한 코스'),
      RunningContext.explore => ('🗺️', '새로운 코스 탐험'),
      RunningContext.defaultMode => ('✨', '오늘의 추천 코스'),
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.spacing16),
      color: AppColors.primary.withValues(alpha: 0.1),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: AppSizes.spacing8),
          Text(
            message,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickFilters extends StatelessWidget {
  final RunningContext selectedContext;
  final void Function(RunningContext) onContextSelected;

  const _QuickFilters({
    required this.selectedContext,
    required this.onContextSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.spacing16,
        vertical: AppSizes.spacing8,
      ),
      child: Row(
        children: [
          _FilterChip(
            label: '근처',
            isSelected: selectedContext == RunningContext.quick,
            onTap: () => onContextSelected(RunningContext.quick),
          ),
          const SizedBox(width: AppSizes.spacing8),
          _FilterChip(
            label: '훈련',
            isSelected: selectedContext == RunningContext.training,
            onTap: () => onContextSelected(RunningContext.training),
          ),
          const SizedBox(width: AppSizes.spacing8),
          _FilterChip(
            label: '새로운',
            isSelected: selectedContext == RunningContext.explore,
            onTap: () => onContextSelected(RunningContext.explore),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
    );
  }
}
