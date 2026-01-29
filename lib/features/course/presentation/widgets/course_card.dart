import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../domain/entities/scored_course.dart';

class CourseCard extends StatelessWidget {
  final ScoredCourse scoredCourse;
  final VoidCallback? onTap;

  const CourseCard({
    super.key,
    required this.scoredCourse,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final course = scoredCourse.course;

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.spacing16,
        vertical: AppSizes.spacing8,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 헤더: 이름 + 공식 배지
              Row(
                children: [
                  if (course.isOfficial)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.spacing8,
                        vertical: 2,
                      ),
                      margin: const EdgeInsets.only(right: AppSizes.spacing8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                      ),
                      child: const Text(
                        '공식',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  Expanded(
                    child: Text(
                      course.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.spacing8),

              // 정보: 거리, 시간, 별점
              Row(
                children: [
                  _InfoChip(
                    icon: Icons.straighten,
                    label: '${course.distanceKm.toStringAsFixed(1)}km',
                  ),
                  const SizedBox(width: AppSizes.spacing16),
                  _InfoChip(
                    icon: Icons.timer_outlined,
                    label: '${course.estimatedMinutes}분',
                  ),
                  const SizedBox(width: AppSizes.spacing16),
                  _InfoChip(
                    icon: Icons.star,
                    label: course.averageRating.toStringAsFixed(1),
                    iconColor: Colors.amber,
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.spacing8),

              // 난이도
              Row(
                children: [
                  const Text('난이도 ', style: TextStyle(fontSize: 12)),
                  ...List.generate(5, (index) {
                    return Icon(
                      Icons.circle,
                      size: 8,
                      color: index < course.difficulty
                          ? AppColors.primary
                          : Colors.grey.shade300,
                    );
                  }),
                ],
              ),
              const SizedBox(height: AppSizes.spacing8),

              // 추천 이유
              Text(
                scoredCourse.reason,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? iconColor;

  const _InfoChip({
    required this.icon,
    required this.label,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: iconColor ?? Colors.grey),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
