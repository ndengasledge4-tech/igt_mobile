import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:igt/app/app.dart';
import 'package:igt/app/routes/route_names.dart';
import 'package:igt/app/theme/app_theme.dart';
import 'package:igt/app/theme/theme_mode_scope.dart';
import 'package:igt/features/academic/academic_screen.dart';
import 'package:igt/features/auth/splash/splash_page.dart';
import 'package:igt/features/documents/documents_screen.dart';
import 'package:igt/features/profile/profile_screen.dart';
import 'package:igt/shared/navigation/navigation_page.dart';
import 'package:igt/shared/widgets/app_button.dart';

void main() {
  testWidgets('the application starts on the IGT splash screen', (
    tester,
  ) async {
    await tester.pumpWidget(const IgtApp());

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(SplashPage), findsOneWidget);
  });

  testWidgets('the light theme can be loaded', (tester) async {
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
        home: Scaffold(
          body: AppButton(text: 'Continuer', onPressed: () {}),
        ),
      ),
    );

    expect(find.text('Continuer'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('onboarding advances through its three pages', (tester) async {
    await tester.pumpWidget(const IgtApp(initialRoute: RouteNames.onboarding));

    expect(find.text('Votre vie académique,\nau même endroit'), findsOneWidget);

    await tester.tap(find.text('Suivant'));
    await tester.pumpAndSettle();
    expect(find.text('Consultez vos\ninformations'), findsOneWidget);

    await tester.tap(find.text('Suivant'));
    await tester.pumpAndSettle();
    expect(find.text('Restez informé'), findsOneWidget);
    expect(find.text('Commencer'), findsOneWidget);
  });

  testWidgets('the current bottom navigation changes destination', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.lightTheme, home: const NavigationPage()),
    );

    await tester.tap(find.text('Académique'));
    await tester.pump();
    expect(find.byType(AcademicScreen), findsOneWidget);

    await tester.tap(find.text('Documents'));
    await tester.pump();
    expect(find.byType(DocumentsScreen), findsOneWidget);

    await tester.tap(find.text('Profil'));
    await tester.pump();
    expect(find.byType(ProfileScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
