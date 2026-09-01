import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:igt/app/routes/route_generator.dart';
import 'package:igt/app/theme/app_theme.dart';
import 'package:igt/features/academie/pages/MesCours/mes_cours_page.dart';
import 'package:igt/features/academie/pages/MesCours/semestre_page.dart';
import 'package:igt/shared/navigation/navigation_page.dart';
import 'package:igt/shared/navigation/widgets/app_bottom_navigation.dart';

void main() {
  testWidgets('student can open courses and a semester from Academie', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        onGenerateRoute: RouteGenerator.generateRoute,
        home: const NavigationPage(),
      ),
    );

    await tester.tap(find.text('Académique'));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<AppBottomNavigation>(find.byType(AppBottomNavigation))
          .currentIndex,
      2,
    );

    await tester.tap(find.text('Mes cours'));
    await tester.pumpAndSettle();
    expect(find.byType(MesCoursPage), findsOneWidget);

    await tester.tap(find.byKey(const Key('academic-period-selector')));
    await tester.pumpAndSettle();
    expect(find.byType(SemestrePage), findsOneWidget);
    expect(find.text('Semestre 1'), findsWidgets);
    expect(tester.takeException(), isNull);
  });
}
