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

  testWidgets('messaging list contains the four institutional channels', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.lightTheme, home: const MessageriePage()),
    );

    expect(find.byKey(const Key('conversation-group-l3')), findsOneWidget);
    expect(find.byKey(const Key('conversation-admin-school')), findsOneWidget);
    expect(
      find.byKey(const Key('conversation-service-academic')),
      findsOneWidget,
    );
    expect(find.byKey(const Key('conversation-igt-ai')), findsOneWidget);
    expect(find.text('Licence 3 — Génie Informatique'), findsOneWidget);
    expect(find.text('Service de la scolarité'), findsOneWidget);
    expect(find.text('Service académique'), findsOneWidget);
    expect(find.text('IGT-IA'), findsWidgets);
  });

  testWidgets('local search filters conversations and exposes empty state', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.lightTheme, home: const MessageriePage()),
    );
    final search = find.byKey(const Key('conversation-search-field'));

    await tester.enterText(search, 'académique');
    await tester.pump();
    expect(
      find.byKey(const Key('conversation-service-academic')),
      findsOneWidget,
    );
    expect(find.byKey(const Key('conversation-group-l3')), findsNothing);

    await tester.enterText(search, 'conversation impossible');
    await tester.pump();
    expect(find.text('Aucune conversation trouvée'), findsOneWidget);

    await tester.tap(find.text('Tout afficher'));
    await tester.pump();
    expect(find.byKey(const Key('conversation-group-l3')), findsOneWidget);
  });

  testWidgets('class conversation exposes group details and mock members', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const ConversationPage(conversationId: 'group-l3'),
      ),
    );

    expect(find.textContaining('42 membres'), findsOneWidget);
    expect(find.text('Grâce K.'), findsOneWidget);
    await tester.tap(find.byKey(const Key('conversation-information-button')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('group-information-sheet')), findsOneWidget);
    expect(find.text('Génie Informatique'), findsOneWidget);
    expect(find.text('Quelques membres'), findsOneWidget);
    expect(find.text('Déléguée'), findsOneWidget);
  });

  testWidgets('IGT-IA returns a local simulated answer', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.darkTheme,
        home: const ConversationPage(conversationId: 'igt-ai'),
      ),
    );

    await tester.enterText(
      find.byKey(const Key('message-composer-field')),
      'Quel est mon prochain cours ?',
    );
    await tester.pump();
    await tester.tap(find.byTooltip('Envoyer'));
    await tester.pumpAndSettle();

    expect(find.text('Quel est mon prochain cours ?'), findsOneWidget);
    expect(find.textContaining('Architecture logicielle'), findsOneWidget);
    expect(find.text('Message envoyé'), findsOneWidget);
    expect(
      CommunicationStore.instance
          .conversationById('igt-ai')
          .messages
          .last
          .sentByStudent,
      isFalse,
    );
  });

  testWidgets('student can send in group, school and academic conversations', (
    tester,
  ) async {
    const scenarios = {
      'group-l3': 'Message au groupe de classe.',
      'admin-school': 'Question pour la scolarité.',
      'service-academic': 'Question sur le planning académique.',
    };

    for (final scenario in scenarios.entries) {
      await tester.pumpWidget(
        MaterialApp(
          key: ValueKey(scenario.key),
          theme: AppTheme.lightTheme,
          home: ConversationPage(conversationId: scenario.key),
        ),
      );
      await tester.enterText(
        find.byKey(const Key('message-composer-field')),
        scenario.value,
      );
      await tester.pump();
      await tester.tap(find.byTooltip('Envoyer'));
      await tester.pumpAndSettle();

      expect(find.text(scenario.value), findsOneWidget);
      expect(
        CommunicationStore.instance
            .conversationById(scenario.key)
            .messages
            .last
            .text,
        scenario.value,
      );
    }
  });

  testWidgets('mock attachment options render in dark mode', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.darkTheme,
        home: const ConversationPage(conversationId: 'admin-school'),
      ),
    );

    await tester.tap(find.byTooltip('Joindre un fichier'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('attachment-options-sheet')), findsOneWidget);
    expect(find.text('Document'), findsOneWidget);
    expect(find.text('Photo'), findsOneWidget);
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
