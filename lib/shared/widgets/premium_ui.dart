import 'package:flutter/material.dart';

import '../../app/theme/colors.dart';
import '../../app/theme/dimensions.dart';
import '../../app/theme/semantic_colors.dart';

class AppResponsiveContent extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double maxWidth;

  const AppResponsiveContent({
    super.key,
    required this.child,
    this.padding,
    this.maxWidth = AppDimensions.maxContentWidth,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontal = width < 360
        ? 16.0
        : width >= 600
        ? 32.0
        : 20.0;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding:
              padding ?? EdgeInsets.fromLTRB(horizontal, 20, horizontal, 32),
          child: child,
        ),
      ),
    );
  }
}

/// Student-aware header used by the home surface.
///
/// It deliberately lives next to [AppScreenHeader] so the shell has one
/// coherent header language instead of locally redrawn app bars.
class AppStudentHeader extends StatelessWidget {
  final String greeting;
  final String identity;
  final String initials;
  final VoidCallback onNotifications;
  final int notificationCount;
  final Widget? secondaryAction;

  const AppStudentHeader({
    super.key,
    required this.greeting,
    required this.identity,
    required this.initials,
    required this.onNotifications,
    this.notificationCount = 0,
    this.secondaryAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return SafeArea(
      bottom: false,
      child: AppResponsiveContent(
        padding: EdgeInsets.fromLTRB(
          _responsiveHorizontalPadding(context),
          18,
          _responsiveHorizontalPadding(context),
          4,
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkSurfaceElevated
                    : AppColors.primarySoft,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: context.semanticColors.border),
              ),
              child: Text(
                initials,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    greeting,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 19,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    identity,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: context.semanticColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (secondaryAction != null) ...[
              const SizedBox(width: 8),
              secondaryAction!,
            ],
            const SizedBox(width: 8),
            _HeaderIconButton(
              tooltip: 'Notifications',
              icon: Icons.notifications_rounded,
              onPressed: onNotifications,
              badge: notificationCount,
            ),
          ],
        ),
      ),
    );
  }
}

class AppScreenHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget? action;
  final bool showBack;
  final VoidCallback? onSearch;

  const AppScreenHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.action,
    this.showBack = false,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final width = MediaQuery.sizeOf(context).width;
    final horizontal = _responsiveHorizontalPadding(context);
    return SafeArea(
      bottom: false,
      child: AppResponsiveContent(
        padding: EdgeInsets.fromLTRB(horizontal, 16, horizontal, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showBack) ...[
              _HeaderIconButton(
                tooltip: 'Retour',
                icon: Icons.arrow_back_rounded,
                onPressed: () => Navigator.maybePop(context),
              ),
              const SizedBox(width: 10),
            ],
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkSurfaceElevated
                    : AppColors.primarySoft,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: context.semanticColors.border),
              ),
              child: Icon(icon, color: theme.colorScheme.primary, size: 23),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eyebrow.toUpperCase(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.secondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    title,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontSize: width < 360 ? 22 : 25,
                      letterSpacing: -0.4,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: context.semanticColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (onSearch != null) ...[
              const SizedBox(width: 8),
              _HeaderIconButton(
                tooltip: 'Rechercher',
                icon: Icons.search_rounded,
                onPressed: onSearch!,
              ),
            ],
            if (action != null) ...[const SizedBox(width: 8), action!],
          ],
        ),
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;
  final int badge;

  const _HeaderIconButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
    this.badge = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Tooltip(
      message: tooltip,
      child: Material(
        color: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: context.semanticColors.border),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onPressed,
          child: SizedBox(
            width: 46,
            height: 46,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(icon, size: 22),
                if (badge > 0)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        badge > 9 ? '9+' : '$badge',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          height: 1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

double _responsiveHorizontalPadding(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  if (width < 360) return 16;
  if (width >= 600) return 32;
  return 20;
}

class AppSurface extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color? color;
  final VoidCallback? onTap;

  const AppSurface({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.radius = 20,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
      side: BorderSide(color: context.semanticColors.border),
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.12)
                : AppColors.primaryStrong.withValues(alpha: 0.055),
            blurRadius: isDark ? 18 : 26,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Material(
        color: color ?? theme.colorScheme.surface,
        shape: shape,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}

class AppSectionHeading extends StatelessWidget {
  final String title;
  final String? subtitle;

  const AppSectionHeading({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.titleLarge),
        if (subtitle != null) ...[
          const SizedBox(height: 3),
          Text(
            subtitle!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: context.semanticColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
