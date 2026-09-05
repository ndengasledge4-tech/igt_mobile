import 'package:flutter/material.dart';

import '../../../app/theme/semantic_colors.dart';
import '../../../shared/widgets/premium_ui.dart';
import '../academic_catalog.dart';

class AcademicStatusBadge extends StatelessWidget {
  final LearningStatus status;
  const AcademicStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (label, icon, color) = switch (status) {
      LearningStatus.completed => (
        'Terminé',
        Icons.check_circle_rounded,
        context.semanticColors.success,
      ),
      LearningStatus.inProgress => (
        'En cours',
        Icons.timelapse_rounded,
        theme.colorScheme.primary,
      ),
      LearningStatus.notStarted => (
        'À commencer',
        Icons.circle_outlined,
        context.semanticColors.textSecondary,
      ),
      LearningStatus.locked => (
        'Verrouillé',
        Icons.lock_rounded,
        context.semanticColors.textDisabled,
      ),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class AcademicCourseCard extends StatelessWidget {
  final AcademicCourse course;
  final VoidCallback onTap;
  const AcademicCourseCard({
    super.key,
    required this.course,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppSurface(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: course.accent.withValues(alpha: .11),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(course.icon, color: course.accent, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course.teacher,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: context.semanticColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${course.credits} ECTS',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: context.semanticColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    value: course.progress,
                    minHeight: 6,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    color: course.accent,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${(course.progress * 100).round()} %',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          Row(
            children: [
              Icon(
                Icons.event_available_rounded,
                size: 17,
                color: context.semanticColors.textSecondary,
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  course.nextActivity,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: context.semanticColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right_rounded, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}

class AcademicResourceRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String metadata;
  final LearningStatus status;
  final VoidCallback? onTap;
  const AcademicResourceRow({
    super.key,
    required this.icon,
    required this.title,
    required this.metadata,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locked = status == LearningStatus.locked;
    return AppSurface(
      onTap: locked ? null : onTap,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      radius: 16,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: .09),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              locked ? Icons.lock_rounded : icon,
              size: 20,
              color: locked
                  ? context.semanticColors.textDisabled
                  : theme.colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 3),
                Text(
                  metadata,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: context.semanticColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          AcademicStatusBadge(status: status),
        ],
      ),
    );
  }
}
