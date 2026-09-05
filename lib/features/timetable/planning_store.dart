import 'package:flutter/foundation.dart';

import '../../core/models/timetable_model.dart';
import '../../mock/mock_notifications.dart';
import '../communication/communication_store.dart';

class PlanningStore extends ChangeNotifier {
  PlanningStore._() {
    _seed();
  }

  static final PlanningStore instance = PlanningStore._();
  final List<PlanningItem> _items = [];
  final List<MockNotificationItem> _notifications = [];
  late List<SemesterMilestone> milestones;

  List<PlanningItem> get items => List.unmodifiable(_items);
  List<MockNotificationItem> get notifications =>
      List.unmodifiable(_notifications);
  DateTime get today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  List<PlanningItem> itemsFor(DateTime day) =>
      _items.where((item) => _sameDay(item.start, day)).toList()
        ..sort((a, b) => a.start.compareTo(b.start));

  PlanningItem byId(String id) => _items.firstWhere((item) => item.id == id);

  void markUnavailable(String id) {
    final item = byId(id);
    _replace(
      item.copyWith(
        status: PlanningItemStatus.moved,
        isRecentChange: true,
        lastChange: 'Indisponibilité signalée par ${item.teacher}',
      ),
    );
    _notifyChange(
      '${item.subject} — enseignant indisponible. Un nouvel horaire sera communiqué.',
    );
    CommunicationStore.instance.addScheduleNotification(
      title: 'Enseignant indisponible',
      message: '${item.subject} — un nouvel horaire sera communiqué.',
    );
  }

  void moveLesson(String id, DateTime newStart) {
    final item = byId(id);
    final duration = item.end.difference(item.start);
    _replace(
      item.copyWith(
        start: newStart,
        end: newStart.add(duration),
        status: PlanningItemStatus.moved,
        isRecentChange: true,
        lastChange: 'Horaire modifié à l’instant par ${item.teacher}',
      ),
    );
    _notifyChange(
      '${item.subject} — séance de ${_hour(item.start)} déplacée à ${_hour(newStart)}.',
    );
    CommunicationStore.instance.addScheduleNotification(
      title: 'Cours déplacé',
      message:
          '${item.subject} — séance de ${_hour(item.start)} déplacée à ${_hour(newStart)}.',
    );
  }

  void cancelLesson(String id) {
    final item = byId(id);
    _replace(
      item.copyWith(
        status: PlanningItemStatus.cancelled,
        isRecentChange: true,
        lastChange: 'Séance annulée à l’instant par ${item.teacher}',
      ),
    );
    _notifyChange('${item.subject} — séance de ${_hour(item.start)} annulée.');
    CommunicationStore.instance.addScheduleNotification(
      title: 'Cours annulé',
      message: '${item.subject} — séance de ${_hour(item.start)} annulée.',
      cancelled: true,
    );
  }

  void resetDemo() {
    _seed();
    notifyListeners();
  }

  void _replace(PlanningItem updated) {
    _items[_items.indexWhere((item) => item.id == updated.id)] = updated;
    notifyListeners();
  }

  void _notifyChange(String message) {
    _notifications.insert(
      0,
      MockNotificationItem(
        title: 'Planning mis à jour',
        message: message,
        time: 'À l’instant',
        kind: MockNotificationKind.schedule,
        unread: true,
      ),
    );
    notifyListeners();
  }

  void _seed() {
    _items.clear();
    _notifications.clear();
    final base = today;
    DateTime at(int offset, int hour, [int minute = 0]) =>
        base.add(Duration(days: offset, hours: hour, minutes: minute));
    _items.addAll([
      PlanningItem(
        id: 'mobile',
        subject: 'Développement mobile',
        start: at(0, 10),
        end: at(0, 12),
        type: PlanningItemType.tp,
        status: PlanningItemStatus.inProgress,
        teacher: 'Pr. Mariam Diarra',
        room: 'Lab Innovation 2',
        campus: 'Campus Centre',
        group: 'L3 GI · Groupe A',
        resources: const ['Brief du TP 06', 'Starter Flutter'],
      ),
      PlanningItem(
        id: 'architecture',
        subject: 'Architecture logicielle',
        start: at(0, 14),
        end: at(0, 16),
        type: PlanningItemType.course,
        status: PlanningItemStatus.confirmed,
        teacher: 'Dr Karim Mansouri',
        room: 'Amphi B',
        group: 'L3 GI',
        resources: const ['Support · Architecture hexagonale'],
      ),
      PlanningItem(
        id: 'networks',
        subject: 'Réseaux avancés',
        start: at(1, 8),
        end: at(1, 10),
        type: PlanningItemType.td,
        status: PlanningItemStatus.moved,
        teacher: 'Mme Amina Belhaj',
        room: 'Salle B12',
        group: 'L3 GI · Groupe A',
        lastChange: 'Déplacé hier à 16:42 · salle mise à jour',
        isRecentChange: true,
      ),
      PlanningItem(
        id: 'database',
        subject: 'Bases de données distribuées',
        start: at(2, 14),
        end: at(2, 16),
        type: PlanningItemType.tp,
        status: PlanningItemStatus.cancelled,
        teacher: 'Dr Salima Brahmi',
        room: 'Laboratoire Info 1',
        group: 'L3 GI · Groupe B',
        lastChange: 'Annulé ce matin par l’enseignante',
        isRecentChange: true,
      ),
      PlanningItem(
        id: 'security',
        subject: 'Sécurité des systèmes',
        start: at(3, 9),
        end: at(3, 11),
        type: PlanningItemType.exam,
        status: PlanningItemStatus.scheduled,
        teacher: 'Jury pédagogique',
        room: 'Amphi Principal',
        group: 'L3 GI',
      ),
      PlanningItem(
        id: 'career',
        subject: 'Forum carrières & numérique',
        start: at(5, 11),
        end: at(5, 15),
        type: PlanningItemType.event,
        status: PlanningItemStatus.scheduled,
        teacher: 'Service Relations entreprises',
        room: 'Atrium',
        campus: 'Campus Centre',
        group: 'Tous les étudiants',
      ),
      PlanningItem(
        id: 'project',
        subject: 'Dossier de projet tutoré',
        start: at(9, 17),
        end: at(9, 18),
        type: PlanningItemType.deadline,
        status: PlanningItemStatus.scheduled,
        teacher: 'Équipe pédagogique',
        room: 'Dépôt en ligne',
        group: 'L3 GI',
      ),
    ]);
    milestones = [
      SemesterMilestone(
        title: 'Début des enseignements',
        subtitle: 'Accueil pédagogique et ouverture des cours',
        date: base.subtract(const Duration(days: 70)),
        type: SemesterMilestoneType.teaching,
      ),
      SemesterMilestone(
        title: 'Contrôles continus',
        subtitle: 'Évaluations intermédiaires · semaines 7 et 8',
        date: base.subtract(const Duration(days: 14)),
        endDate: base.subtract(const Duration(days: 7)),
        type: SemesterMilestoneType.assessment,
      ),
      SemesterMilestone(
        title: 'Semaine de respiration',
        subtitle: 'Suspension des enseignements',
        date: base.add(const Duration(days: 18)),
        endDate: base.add(const Duration(days: 24)),
        type: SemesterMilestoneType.holiday,
      ),
      SemesterMilestone(
        title: 'Examens du semestre',
        subtitle: 'Épreuves écrites et pratiques',
        date: base.add(const Duration(days: 43)),
        endDate: base.add(const Duration(days: 52)),
        type: SemesterMilestoneType.exam,
      ),
      SemesterMilestone(
        title: 'Soutenances de projets',
        subtitle: 'Présentation devant les jurys',
        date: base.add(const Duration(days: 59)),
        type: SemesterMilestoneType.defense,
      ),
      SemesterMilestone(
        title: 'Publication des résultats',
        subtitle: 'Résultats et relevés disponibles dans Académique',
        date: base.add(const Duration(days: 70)),
        type: SemesterMilestoneType.result,
      ),
    ];
  }

  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
  static String _hour(DateTime date) =>
      '${date.hour.toString().padLeft(2, '0')} h${date.minute == 0 ? '' : ' ${date.minute.toString().padLeft(2, '0')}'}';
}
