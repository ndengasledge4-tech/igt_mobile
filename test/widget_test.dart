import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:igt/app/app.dart';
import 'package:igt/app/routes/route_names.dart';
import 'package:igt/app/theme/app_theme.dart';
import 'package:igt/app/theme/theme_mode_scope.dart';
import 'package:igt/features/authentification/pages/splash/splash_page.dart';
import 'package:igt/shared/navigation/navigation_page.dart';
import 'package:igt/shared/navigation/widgets/app_bottom_navigation.dart';
import 'package:igt/shared/widgets/app_button.dart';

void main() {
  testWidgets('the application starts on the IGT splash screen', (
    tester,
  ) async {
    await tester.pumpWidget(const IgtApp());

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(SplashPage), findsOneWidget);
    expect(find.text('IGT MOBILE'), findsOneWidget);
  });

  testWidgets('the light theme and theme selector can be loaded', (
    tester,
  ) async {
    final notifier = AppThemeModeNotifier(ThemeMode.light);
    addTearDown(notifier.dispose);

    await tester.pumpWidget(
      IgtApp(themeModeNotifier: notifier, initialRoute: RouteNames.settings),
    );

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.themeMode, ThemeMode.light);
    expect(materialApp.theme?.brightness, Brightness.light);
    expect(find.byKey(const Key('theme-mode-selector')), findsOneWidget);
  });

  testWidgets('the dark theme can be loaded and changed locally', (
    tester,
  ) async {
    final notifier = AppThemeModeNotifier(ThemeMode.dark);
    addTearDown(notifier.dispose);

    await tester.pumpWidget(
      IgtApp(themeModeNotifier: notifier, initialRoute: RouteNames.settings),
    );

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.themeMode, ThemeMode.dark);
    expect(materialApp.darkTheme?.brightness, Brightness.dark);

    await tester.tap(find.text('Clair'));
    await tester.pump();
    expect(notifier.value, ThemeMode.light);
  });

  testWidgets('a shared primary button can be rendered', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: AppButton(text: 'Continuer', onPressed: () {}),
        ),
      ),
    );

    expect(find.text('Continuer'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('the bottom navigation updates its selected destination', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.lightTheme, home: const NavigationPage()),
    );

    expect(
      tester
          .widget<AppBottomNavigation>(find.byType(AppBottomNavigation))
          .currentIndex,
      0,
    );

    await tester.tap(find.text('Académique'));
    await tester.pump();
    expect(
      tester
          .widget<AppBottomNavigation>(find.byType(AppBottomNavigation))
          .currentIndex,
      2,
    );

    await tester.tap(find.text('Profil'));
    await tester.pump();
    expect(
      tester
          .widget<AppBottomNavigation>(find.byType(AppBottomNavigation))
          .currentIndex,
      4,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('all main destinations render in compact dark mode', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 760);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.darkTheme, home: const NavigationPage()),
    );
    expect(tester.takeException(), isNull, reason: 'overflow in Accueil');

    for (final label in ['Actualités', 'Académique', 'Documents', 'Profil']) {
      await tester.tap(find.text(label).last);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: 'overflow in $label');
    }
  });

  testWidgets('dashboard uses the tablet layout without overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(820, 1100);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.lightTheme, home: const NavigationPage()),
    );

    expect(find.text('Bonjour, Aymen'), findsOneWidget);
    expect(find.text('Résumé académique'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('pilot screens support breakpoints, themes and enlarged text', (
    tester,
  ) async {
    const sizes = [Size(360, 780), Size(430, 932), Size(1180, 900)];
    final themes = [AppTheme.lightTheme, AppTheme.darkTheme];
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    for (final theme in themes) {
      for (final size in sizes) {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;

        await tester.pumpWidget(
          MaterialApp(
            theme: theme,
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: const TextScaler.linear(1.25)),
              child: child!,
            ),
            home: NavigationPage(
              key: ValueKey('${theme.brightness}-${size.width}'),
            ),
          ),
        );
        expect(
          tester.takeException(),
          isNull,
          reason: 'overflow on Accueil at ${size.width}px',
        );

        if (size.width >= 1000) {
          expect(find.byType(AppNavigationRail), findsOneWidget);
        } else {
          expect(find.byType(AppBottomNavigation), findsOneWidget);
        }

        await tester.tap(find.text('Académique').last);
        await tester.pump();
        expect(
          tester.takeException(),
          isNull,
          reason: 'overflow on Académique at ${size.width}px',
        );
      }
    }
  });
}
