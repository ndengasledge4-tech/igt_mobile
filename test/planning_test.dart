import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:igt/app/theme/app_theme.dart';
import 'package:igt/core/models/timetable_model.dart';
import 'package:igt/features/notifications/notifications_page.dart';
import 'package:igt/features/timetable/planning_page.dart';
import 'package:igt/features/timetable/planning_store.dart';
import 'package:igt/features/timetable/timetable_page.dart';

void main() {
  setUp(() => PlanningStore.instance.resetDemo());

  testWidgets('planning exposes day, week, month and semester views', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.lightTheme, home: const TimetablePage()),
    );

    expect(find.text('Mon planning'), findsOneWidget);
    expect(find.byKey(const Key('day-planning')), findsOneWidget);
    expect(find.text('Développement mobile'), findsOneWidget);

    await tester.tap(find.text('Semaine'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('week-day-selector')), findsOneWidget);

    await tester.tap(find.text('Mois'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('month-planning')), findsOneWidget);

    await tester.tap(find.text('Semestre'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('semester-planning')), findsOneWidget);
    await tester.drag(
      find.byKey(const Key('semester-planning')),
      const Offset(0, -500),
    );
    await tester.pumpAndSettle();
    expect(find.text('Examens du semestre'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('tablet week view uses the readable weekly grid in dark mode', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(900, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.darkTheme, home: const TimetablePage()),
    );
    await tester.tap(find.text('Semaine'));
    await tester.pumpAndSettle();

    expect(find.byType(TabletWeek), findsOneWidget);
    expect(find.text('Libre'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('teacher move propagates to student planning and notifications', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.lightTheme, home: const TimetablePage()),
    );

    await tester.tap(find.byTooltip('Mode enseignant (démo)'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('teacher-planning')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('teacher-actions-mobile')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Proposer un nouvel horaire'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('16 h 00'));
    await tester.tap(find.byKey(const Key('confirm-move-lesson')));
    await tester.pumpAndSettle();

    final lesson = PlanningStore.instance.byId('mobile');
    expect(lesson.start.hour, 16);
    expect(lesson.status, PlanningItemStatus.moved);
    expect(
      PlanningStore.instance.notifications.first.message,
      contains('déplacée à 16 h'),
    );

    await tester.pumpWidget(
      MaterialApp(
        key: UniqueKey(),
        theme: AppTheme.lightTheme,
        home: const NotificationsPage(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('Développement mobile'), findsOneWidget);
    expect(find.text('À l’instant'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('cancelled and empty states remain explicit', (tester) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final store = PlanningStore.instance;
    store.cancelLesson('mobile');
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.lightTheme, home: const TimetablePage()),
    );
    expect(find.text('Annulé'), findsOneWidget);

    await tester.tap(find.text('Semaine'));
    await tester.pumpAndSettle();
    await tester.drag(
      find.byKey(const Key('week-day-selector')),
      const Offset(-240, 0),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('week-day-4')));
    await tester.pumpAndSettle();
    expect(find.text('Aucune séance'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
