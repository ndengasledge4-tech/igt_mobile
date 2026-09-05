import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:igt/app/theme/app_theme.dart';
import 'package:igt/features/actualite/pages/actualites_page.dart';
import 'package:igt/features/actualite/pages/evenements_page.dart';
import 'package:igt/features/communication/communication_store.dart';
import 'package:igt/features/messagerie/pages/conversation_page.dart';
import 'package:igt/features/messagerie/pages/messagerie_page.dart';
import 'package:igt/features/messagerie/pages/nouvelle_demande_page.dart';
import 'package:igt/features/notifications/notifications_page.dart';
import 'package:igt/features/teacher/teacher_home_page.dart';

void main() {
  setUp(CommunicationStore.instance.resetDemo);

  testWidgets(
    'notifications are grouped, readable and expose a detail action',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: const NotificationsPage(),
        ),
      );
      expect(find.text('Aujourd’hui'), findsOneWidget);
      expect(find.text('Cette semaine'), findsOneWidget);
      await tester.tap(find.text('Inscriptions pédagogiques ouvertes'));
      await tester.pumpAndSettle();
      expect(find.text('Lire l’annonce'), findsOneWidget);
      expect(CommunicationStore.instance.notifications.first.unread, isFalse);
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(find.text('Plus ancien'), 300);
      expect(find.text('Plus ancien'), findsOneWidget);
    },
  );

  testWidgets('student sends a message visible from teacher state', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.darkTheme,
        home: const ConversationPage(conversationId: 'teacher-mariam'),
      ),
    );
    await tester.enterText(
      find.byType(TextField),
      'Je confirme ma présence au TP.',
    );
    await tester.pump();
    await tester.tap(find.byTooltip('Envoyer'));
    await tester.pump();
    expect(find.text('Je confirme ma présence au TP.'), findsOneWidget);
    expect(
      CommunicationStore.instance
          .conversationById('teacher-mariam')
          .messages
          .last
          .sentByStudent,
      isTrue,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('administrative request creates a structured conversation', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const NouvelleDemandePage(),
      ),
    );
    await tester.tap(find.text('Scolarité'));
    await tester.pump();
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Document administratif').last);
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byType(TextField),
      'Je souhaite une attestation signée.',
    );
    await tester.pump();
    await tester.ensureVisible(
      find.byKey(const Key('send-administrative-request')),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('send-administrative-request')));
    await tester.pumpAndSettle();
    expect(find.text('Je souhaite une attestation signée.'), findsOneWidget);
    expect(CommunicationStore.instance.conversations.first.name, 'Scolarité');
  });

  testWidgets('communication surfaces render responsively in dark mode', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    for (final page in <Widget>[
      const MessageriePage(),
      const ActualitePage(),
      const EvenementsPage(),
      const TeacherHomePage(),
    ]) {
      await tester.pumpWidget(
        MaterialApp(key: UniqueKey(), theme: AppTheme.darkTheme, home: page),
      );
      await tester.pump();
      expect(
        tester.takeException(),
        isNull,
        reason: '${page.runtimeType} overflowed',
      );
    }
  });
}
