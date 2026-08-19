import 'package:flutter/material.dart';

import 'colors.dart';
import 'dimensions.dart';
import 'semantic_colors.dart';
import 'text_styles.dart';

abstract final class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme => _build(
    brightness: Brightness.light,
    background: AppColors.background,
    surface: AppColors.surface,
    surfaceContainer: AppColors.surfaceVariant,
    semanticColors: AppSemanticColors.light,
  );

  static ThemeData get darkTheme => _build(
    brightness: Brightness.dark,
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    surfaceContainer: AppColors.darkSurfaceVariant,
    semanticColors: AppSemanticColors.dark,
  );

  // Compatibility getters for existing imports.
  static ThemeData get light => lightTheme;
  static ThemeData get dark => darkTheme;

  static ThemeData _build({
    required Brightness brightness,
    required Color background,
    required Color surface,
    required Color surfaceContainer,
    required AppSemanticColors semanticColors,
  }) {
    final isDark = brightness == Brightness.dark;
    final baseScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: brightness,
    );
    final scheme = baseScheme.copyWith(
      primary: isDark ? const Color(0xFF86BCE3) : AppColors.primary,
      onPrimary: isDark ? const Color(0xFF073453) : Colors.white,
      secondary: isDark ? const Color(0xFF82CBC5) : AppColors.secondary,
      tertiary: isDark ? const Color(0xFFE4BE7B) : AppColors.accent,
      surface: surface,
      surfaceContainerHighest: surfaceContainer,
      error: isDark ? const Color(0xFFFFB4AB) : AppColors.error,
      outline: semanticColors.border,
      outlineVariant: isDark ? AppColors.darkDivider : AppColors.divider,
    );
    final textTheme =
        const TextTheme(
          displayLarge: AppTextStyles.display,
          headlineLarge: AppTextStyles.headline,
          headlineMedium: AppTextStyles.headlineSmall,
          titleLarge: AppTextStyles.titleLarge,
          titleMedium: AppTextStyles.title,
          titleSmall: AppTextStyles.titleSmall,
          bodyLarge: AppTextStyles.body,
          bodyMedium: AppTextStyles.bodySmall,
          labelLarge: AppTextStyles.label,
          bodySmall: AppTextStyles.caption,
        ).apply(
          bodyColor: semanticColors.textPrimary,
          displayColor: semanticColors.textPrimary,
        );
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      borderSide: BorderSide(color: semanticColors.border),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      dividerColor: isDark ? AppColors.darkDivider : AppColors.divider,
      disabledColor: semanticColors.textDisabled,
      extensions: [semanticColors],
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        backgroundColor: background,
        foregroundColor: semanticColors.textPrimary,
        titleTextStyle: textTheme.titleLarge,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: AppDimensions.cardElevation,
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: semanticColors.border.withValues(alpha: 0.8)),
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: semanticColors.textDisabled,
        ),
        labelStyle: textTheme.bodyMedium?.copyWith(
          color: semanticColors.textSecondary,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.space16,
          vertical: AppDimensions.space16,
        ),
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder.copyWith(
          borderSide: BorderSide(color: scheme.primary, width: 1.8),
        ),
        errorBorder: inputBorder.copyWith(
          borderSide: BorderSide(color: scheme.error),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size(0, AppDimensions.buttonHeight),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.space20,
          ),
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          disabledBackgroundColor: scheme.onSurface.withValues(alpha: 0.12),
          disabledForegroundColor: scheme.onSurface.withValues(alpha: 0.38),
          textStyle: AppTextStyles.button,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, AppDimensions.buttonHeight),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.space20,
          ),
          foregroundColor: scheme.primary,
          side: BorderSide(color: semanticColors.border),
          textStyle: AppTextStyles.button,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          textStyle: AppTextStyles.label,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: semanticColors.textSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surfaceContainer,
        selectedColor: scheme.primaryContainer,
        disabledColor: scheme.onSurface.withValues(alpha: 0.08),
        side: BorderSide(color: semanticColors.border),
        labelStyle: textTheme.labelLarge,
        secondaryLabelStyle: textTheme.labelLarge?.copyWith(
          color: scheme.onPrimaryContainer,
        ),
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.space8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
        ),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: semanticColors.textSecondary,
        textColor: semanticColors.textPrimary,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.space16,
          vertical: AppDimensions.space4,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: surface,
        selectedItemColor: scheme.primary,
        unselectedItemColor: semanticColors.textDisabled,
        selectedLabelStyle: AppTextStyles.caption.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: AppTextStyles.caption,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface,
        modalBackgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimensions.radiusXLarge),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark
            ? AppColors.darkSurfaceVariant
            : AppColors.textPrimary,
        contentTextStyle: AppTextStyles.bodySmall.copyWith(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
      ),
    );
  }
}
