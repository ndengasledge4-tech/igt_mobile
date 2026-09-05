enum MockNotificationKind { result, document, news, schedule, warning }

class MockNotificationItem {
  final String title;
  final String message;
  final String time;
  final MockNotificationKind kind;
  final bool unread;

  const MockNotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.kind,
    this.unread = false,
  });
}

abstract final class MockNotificationsData {
  const MockNotificationsData._();

  static const items = [
    MockNotificationItem(
      title: 'Résultats disponibles',
      message: 'Les notes du contrôle continu n°2 sont disponibles.',
      time: '2h',
      kind: MockNotificationKind.result,
      unread: true,
    ),
    MockNotificationItem(
      title: 'Nouveau document',
      message: 'Le polycopié d’algorithmique, chapitre 6, a été mis en ligne.',
      time: '5h',
      kind: MockNotificationKind.document,
    ),
    MockNotificationItem(
      title: 'Nouvelle actualité',
      message: 'Conférence internationale sur l’IA — inscriptions ouvertes.',
      time: 'Hier, 14:30',
      kind: MockNotificationKind.news,
    ),
    MockNotificationItem(
      title: 'Modification de cours',
      message: 'Le cours de mathématiques du lundi est reporté.',
      time: 'Hier, 09:15',
      kind: MockNotificationKind.schedule,
    ),
    MockNotificationItem(
      title: 'Rappel important',
      message: 'La date limite de paiement des frais est le 31 août 2025.',
      time: '25 juillet',
      kind: MockNotificationKind.warning,
    ),
  ];
}
