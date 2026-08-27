import 'package:flutter/foundation.dart';

enum CommunicationNotificationKind {
  courseMoved,
  courseCancelled,
  result,
  document,
  message,
  announcement,
  event,
  administrative,
}

enum NotificationDestination {
  planning,
  result,
  document,
  conversation,
  news,
  event,
}

@immutable
class CommunicationNotification {
  final String id;
  final String title;
  final String content;
  final String source;
  final DateTime date;
  final CommunicationNotificationKind kind;
  final NotificationDestination destination;
  final String? targetId;
  final bool unread;

  const CommunicationNotification({
    required this.id,
    required this.title,
    required this.content,
    required this.source,
    required this.date,
    required this.kind,
    required this.destination,
    this.targetId,
    this.unread = true,
  });

  CommunicationNotification copyWith({bool? unread}) =>
      CommunicationNotification(
        id: id,
        title: title,
        content: content,
        source: source,
        date: date,
        kind: kind,
        destination: destination,
        targetId: targetId,
        unread: unread ?? this.unread,
      );
}

enum ConversationCategory { teachers, administration, services, groups }

enum PresenceStatus { online, available, away, offline }

@immutable
class ChatMessage {
  final String id;
  final String text;
  final DateTime sentAt;
  final bool sentByStudent;
  final String author;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.sentAt,
    required this.sentByStudent,
    required this.author,
  });
}

@immutable
class UniversityConversation {
  final String id;
  final String name;
  final String role;
  final String initials;
  final ConversationCategory category;
  final PresenceStatus status;
  final List<ChatMessage> messages;
  final int unreadCount;

  const UniversityConversation({
    required this.id,
    required this.name,
    required this.role,
    required this.initials,
    required this.category,
    required this.status,
    required this.messages,
    this.unreadCount = 0,
  });

  UniversityConversation copyWith({
    List<ChatMessage>? messages,
    int? unreadCount,
  }) => UniversityConversation(
    id: id,
    name: name,
    role: role,
    initials: initials,
    category: category,
    status: status,
    messages: messages ?? this.messages,
    unreadCount: unreadCount ?? this.unreadCount,
  );
}

@immutable
class CommunicationArticle {
  final String id;
  final String title;
  final String excerpt;
  final String content;
  final String category;
  final String source;
  final DateTime publishedAt;
  final String imageAsset;
  final bool featured;

  const CommunicationArticle({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.content,
    required this.category,
    required this.source,
    required this.publishedAt,
    required this.imageAsset,
    this.featured = false,
  });
}

@immutable
class UniversityEvent {
  final String id;
  final String title;
  final String description;
  final DateTime startsAt;
  final String location;
  final String organizer;
  final String imageAsset;
  final List<(String, String)> program;
  final bool participating;

  const UniversityEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.startsAt,
    required this.location,
    required this.organizer,
    required this.imageAsset,
    required this.program,
    this.participating = false,
  });

  UniversityEvent copyWith({bool? participating}) => UniversityEvent(
    id: id,
    title: title,
    description: description,
    startsAt: startsAt,
    location: location,
    organizer: organizer,
    imageAsset: imageAsset,
    program: program,
    participating: participating ?? this.participating,
  );
}

class CommunicationStore extends ChangeNotifier {
  CommunicationStore._() {
    resetDemo();
  }

  static final CommunicationStore instance = CommunicationStore._();
  final List<CommunicationNotification> _notifications = [];
  final List<UniversityConversation> _conversations = [];
  final List<CommunicationArticle> _articles = [];
  final List<UniversityEvent> _events = [];

  List<CommunicationNotification> get notifications =>
      List.unmodifiable(_notifications);
  List<UniversityConversation> get conversations =>
      List.unmodifiable(_conversations);
  List<CommunicationArticle> get articles => List.unmodifiable(_articles);
  List<UniversityEvent> get events => List.unmodifiable(_events);
  int get unreadNotifications =>
      _notifications.where((item) => item.unread).length;
  int get unreadMessages =>
      _conversations.fold(0, (sum, item) => sum + item.unreadCount);

  UniversityConversation conversationById(String id) =>
      _conversations.firstWhere((item) => item.id == id);
  CommunicationArticle articleById(String id) =>
      _articles.firstWhere((item) => item.id == id);
  UniversityEvent eventById(String id) =>
      _events.firstWhere((item) => item.id == id);

  void markNotificationRead(String id) {
    final index = _notifications.indexWhere((item) => item.id == id);
    if (index < 0 || !_notifications[index].unread) return;
    _notifications[index] = _notifications[index].copyWith(unread: false);
    notifyListeners();
  }

  void markAllNotificationsRead() {
    for (var index = 0; index < _notifications.length; index++) {
      _notifications[index] = _notifications[index].copyWith(unread: false);
    }
    notifyListeners();
  }

  void openConversation(String id) {
    final index = _conversations.indexWhere((item) => item.id == id);
    if (index < 0 || _conversations[index].unreadCount == 0) return;
    _conversations[index] = _conversations[index].copyWith(unreadCount: 0);
    notifyListeners();
  }

  void sendMessage(
    String conversationId,
    String text, {
    bool asTeacher = false,
  }) {
    final value = text.trim();
    if (value.isEmpty) return;
    final index = _conversations.indexWhere(
      (item) => item.id == conversationId,
    );
    if (index < 0) return;
    final conversation = _conversations[index];
    final message = ChatMessage(
      id: 'message-${DateTime.now().microsecondsSinceEpoch}',
      text: value,
      sentAt: DateTime.now(),
      sentByStudent: !asTeacher,
      author: asTeacher ? 'Pr. Mariam Diarra' : 'Aymen M.',
    );
    _conversations[index] = conversation.copyWith(
      messages: [...conversation.messages, message],
    );
    notifyListeners();
  }

  String createAdministrativeRequest({
    required String service,
    required String subject,
    required String message,
  }) {
    final id = 'request-${DateTime.now().microsecondsSinceEpoch}';
    _conversations.insert(
      0,
      UniversityConversation(
        id: id,
        name: service,
        role: subject,
        initials: _initials(service),
        category: service == 'Bibliothèque' || service == 'Service informatique'
            ? ConversationCategory.services
            : ConversationCategory.administration,
        status: PresenceStatus.available,
        messages: [
          ChatMessage(
            id: '$id-first',
            text: message,
            sentAt: DateTime.now(),
            sentByStudent: true,
            author: 'Aymen M.',
          ),
        ],
      ),
    );
    notifyListeners();
    return id;
  }

  void addScheduleNotification({
    required String title,
    required String message,
    bool cancelled = false,
  }) {
    _notifications.insert(
      0,
      CommunicationNotification(
        id: 'schedule-${DateTime.now().microsecondsSinceEpoch}',
        title: title,
        content: message,
        source: 'Pr. Mariam Diarra',
        date: DateTime.now(),
        kind: cancelled
            ? CommunicationNotificationKind.courseCancelled
            : CommunicationNotificationKind.courseMoved,
        destination: NotificationDestination.planning,
        targetId: 'mobile',
      ),
    );
    notifyListeners();
  }

  void toggleParticipation(String eventId) {
    final index = _events.indexWhere((item) => item.id == eventId);
    if (index < 0) return;
    _events[index] = _events[index].copyWith(
      participating: !_events[index].participating,
    );
    notifyListeners();
  }

  void resetDemo() {
    final now = DateTime.now();
    _notifications
      ..clear()
      ..addAll([
        CommunicationNotification(
          id: 'announcement-rentree',
          title: 'Inscriptions pédagogiques ouvertes',
          content:
              'Les inscriptions pédagogiques 2026–2027 sont ouvertes jusqu’au 4 septembre. Consultez les modalités et les pièces requises.',
          source: 'Direction de la scolarité',
          date: now.subtract(const Duration(minutes: 24)),
          kind: CommunicationNotificationKind.announcement,
          destination: NotificationDestination.news,
          targetId: 'rentree',
        ),
        CommunicationNotification(
          id: 'message-mariam',
          title: 'Nouveau message de Pr. Mariam Diarra',
          content:
              'Le starter Flutter du TP est disponible. Pensez à le télécharger avant la séance.',
          source: 'Pr. Mariam Diarra',
          date: now.subtract(const Duration(hours: 2)),
          kind: CommunicationNotificationKind.message,
          destination: NotificationDestination.conversation,
          targetId: 'teacher-mariam',
        ),
        CommunicationNotification(
          id: 'result-mobile',
          title: 'Résultat publié',
          content:
              'Votre résultat de Projet mobile est disponible dans votre espace académique.',
          source: 'Service académique',
          date: now.subtract(const Duration(days: 2)),
          kind: CommunicationNotificationKind.result,
          destination: NotificationDestination.result,
        ),
        CommunicationNotification(
          id: 'document-attestation',
          title: 'Nouvelle attestation disponible',
          content:
              'Votre attestation d’inscription a été ajoutée à Mes documents.',
          source: 'Scolarité',
          date: now.subtract(const Duration(days: 4)),
          kind: CommunicationNotificationKind.document,
          destination: NotificationDestination.document,
        ),
        CommunicationNotification(
          id: 'event-forum',
          title: 'Forum carrières & numérique',
          content:
              'Les inscriptions au forum sont ouvertes. Rencontrez les entreprises partenaires de l’IGT.',
          source: 'Relations entreprises',
          date: now.subtract(const Duration(days: 9)),
          kind: CommunicationNotificationKind.event,
          destination: NotificationDestination.event,
          targetId: 'forum',
        ),
        CommunicationNotification(
          id: 'admin-payment',
          title: 'Échéance administrative',
          content:
              'Le prochain versement des frais de scolarité est attendu avant le 15 septembre.',
          source: 'Service finances',
          date: now.subtract(const Duration(days: 18)),
          kind: CommunicationNotificationKind.administrative,
          destination: NotificationDestination.document,
        ),
      ]);
    _conversations
      ..clear()
      ..addAll([
        UniversityConversation(
          id: 'teacher-mariam',
          name: 'Pr. Mariam Diarra',
          role: 'Développement mobile',
          initials: 'MD',
          category: ConversationCategory.teachers,
          status: PresenceStatus.online,
          unreadCount: 2,
          messages: [
            ChatMessage(
              id: 'm1',
              text:
                  'Bonjour Aymen, le starter Flutter du TP est maintenant disponible.',
              sentAt: now.subtract(const Duration(hours: 3)),
              sentByStudent: false,
              author: 'Pr. Mariam Diarra',
            ),
            ChatMessage(
              id: 'm2',
              text:
                  'Merci Madame. Est-ce que nous devons préparer la navigation avant le cours ?',
              sentAt: now.subtract(const Duration(hours: 2, minutes: 40)),
              sentByStudent: true,
              author: 'Aymen M.',
            ),
            ChatMessage(
              id: 'm3',
              text: 'Oui, relisez surtout la partie sur les routes nommées.',
              sentAt: now.subtract(const Duration(hours: 2)),
              sentByStudent: false,
              author: 'Pr. Mariam Diarra',
            ),
          ],
        ),
        UniversityConversation(
          id: 'admin-school',
          name: 'Scolarité',
          role: 'Administration',
          initials: 'SC',
          category: ConversationCategory.administration,
          status: PresenceStatus.available,
          unreadCount: 1,
          messages: [
            ChatMessage(
              id: 's1',
              text: 'Votre certificat de scolarité est prêt.',
              sentAt: now.subtract(const Duration(days: 1)),
              sentByStudent: false,
              author: 'Scolarité',
            ),
          ],
        ),
        UniversityConversation(
          id: 'service-it',
          name: 'Service informatique',
          role: 'Assistance portail',
          initials: 'SI',
          category: ConversationCategory.services,
          status: PresenceStatus.away,
          messages: [
            ChatMessage(
              id: 'i1',
              text: 'Votre accès Wi-Fi campus a été réinitialisé.',
              sentAt: now.subtract(const Duration(days: 2)),
              sentByStudent: false,
              author: 'Support IGT',
            ),
          ],
        ),
        UniversityConversation(
          id: 'group-l3',
          name: 'L3 Génie Informatique',
          role: 'Groupe A · 28 membres',
          initials: 'L3',
          category: ConversationCategory.groups,
          status: PresenceStatus.online,
          messages: [
            ChatMessage(
              id: 'g1',
              text: 'Le groupe de projet se retrouve en salle B12 à 13 h.',
              sentAt: now.subtract(const Duration(days: 3)),
              sentByStudent: false,
              author: 'Délégué L3',
            ),
          ],
        ),
      ]);
    _articles
      ..clear()
      ..addAll([
        CommunicationArticle(
          id: 'rentree',
          title: 'Inscriptions pédagogiques 2026–2027',
          excerpt:
              'Le calendrier, les étapes et les pièces à préparer pour finaliser votre rentrée.',
          content:
              'Les inscriptions pédagogiques sont ouvertes jusqu’au 4 septembre 2026. Les étudiants sont invités à vérifier leur situation administrative, choisir leurs unités d’enseignement et déposer les pièces demandées depuis leur espace. Une permanence est assurée par la scolarité de 8 h à 16 h.',
          category: 'Annonce',
          source: 'Direction de la scolarité',
          publishedAt: now.subtract(const Duration(minutes: 24)),
          imageAsset: 'assets/images/news/news2.png',
          featured: true,
        ),
        CommunicationArticle(
          id: 'innovation',
          title: 'Le Lab Innovation ouvre ses portes',
          excerpt:
              'Découvrez les nouveaux équipements accessibles aux projets étudiants.',
          content:
              'Le Lab Innovation accueille désormais les étudiants du lundi au vendredi. Des postes de prototypage, kits mobiles et espaces de travail collaboratif peuvent être réservés auprès du service informatique.',
          category: 'Campus',
          source: 'Communication IGT',
          publishedAt: now.subtract(const Duration(days: 2)),
          imageAsset: 'assets/images/news/news1.png',
        ),
        CommunicationArticle(
          id: 'bibliotheque',
          title: 'Nouvelles ressources numériques',
          excerpt:
              'Plus de 400 ouvrages et revues rejoignent la bibliothèque numérique.',
          content:
              'La bibliothèque enrichit son catalogue avec de nouvelles références en informatique, gestion et télécommunications. L’accès est inclus pour tous les étudiants inscrits.',
          category: 'Ressources',
          source: 'Bibliothèque',
          publishedAt: now.subtract(const Duration(days: 5)),
          imageAsset: 'assets/images/news/news2.png',
        ),
      ]);
    _events
      ..clear()
      ..addAll([
        UniversityEvent(
          id: 'forum',
          title: 'Forum carrières & numérique',
          description:
              'Une journée de rencontres avec les entreprises partenaires, des diplômés et des professionnels du numérique.',
          startsAt: now.add(const Duration(days: 5, hours: 3)),
          location: 'Atrium · Campus Centre',
          organizer: 'Service Relations entreprises',
          imageAsset: 'assets/images/news/news1.png',
          program: const [
            ('09:00', 'Accueil et café réseau'),
            ('10:00', 'Table ronde : métiers du numérique'),
            ('11:30', 'Rencontres entreprises'),
            ('14:00', 'Ateliers CV et entretiens'),
          ],
        ),
        UniversityEvent(
          id: 'integration',
          title: 'Journée d’intégration',
          description:
              'Un temps pour découvrir le campus, les services et rencontrer les associations étudiantes.',
          startsAt: now.add(const Duration(days: 18, hours: 1)),
          location: 'Amphithéâtre principal',
          organizer: 'Vie étudiante',
          imageAsset: 'assets/images/news/news2.png',
          program: const [
            ('09:00', 'Accueil'),
            ('10:00', 'Présentation de l’IGT'),
            ('11:30', 'Visite du campus'),
          ],
        ),
        UniversityEvent(
          id: 'conference',
          title: 'Conférence intelligence artificielle',
          description:
              'Retour sur la conférence consacrée aux usages responsables de l’IA dans l’enseignement supérieur.',
          startsAt: now.subtract(const Duration(days: 12)),
          location: 'Amphithéâtre B',
          organizer: 'Département Informatique',
          imageAsset: 'assets/images/news/news1.png',
          program: const [
            ('14:00', 'Ouverture'),
            ('14:30', 'Conférence'),
            ('16:00', 'Échanges'),
          ],
        ),
      ]);
    notifyListeners();
  }

  static String _initials(String value) => value
      .split(' ')
      .where((part) => part.isNotEmpty)
      .take(2)
      .map((part) => part[0].toUpperCase())
      .join();
}
