import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:igt/app/app.dart';
import 'package:igt/app/routes/route_names.dart';
import 'package:igt/app/theme/app_theme.dart';
import 'package:igt/features/authentification/pages/login/connexion_page.dart';
import 'package:igt/features/authentification/pages/onboarding/onboarding_page.dart';
import 'package:igt/shared/navigation/navigation_page.dart';

void main() {
  testWidgets('student can skip onboarding, sign in and reach the app shell', (
    tester,
  ) async {
    await tester.pumpWidget(const IgtApp(initialRoute: RouteNames.onboarding));

    expect(find.byType(OnboardingPage), findsOneWidget);
    expect(
      find.text('Votre parcours académique,\nen toute simplicité.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Passer'));
    await tester.pumpAndSettle();
    expect(find.byType(ConnexionPage), findsOneWidget);

    final fields = find.byType(TextField);
    expect(fields, findsNWidgets(2));
    await tester.enterText(fields.at(0), '2026IG001');
    await tester.enterText(fields.at(1), 'prototype');

    await tester.ensureVisible(find.text('Se connecter'));
    await tester.tap(find.text('Se connecter'));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationPage), findsOneWidget);
    expect(find.text('Accueil'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('student can complete all three onboarding pages', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.lightTheme, home: const OnboardingPage()),
    );

    const expectedTitles = [
      'Suivez vos résultats\nen un instant.',
      'Restez informé de\nla vie de l’IGT.',
    ];

    for (final title in expectedTitles) {
      await tester.tap(find.text('Suivant'));
      await tester.pumpAndSettle();
      expect(find.text(title), findsOneWidget);
    }

    expect(find.text('Commencer'), findsOneWidget);
    await tester.tap(find.text('Commencer'));
    await tester.pumpAndSettle();
    expect(find.byType(ConnexionPage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
