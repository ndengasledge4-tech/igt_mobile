enum PlanningItemType { course, td, tp, exam, event, deadline }

enum PlanningItemStatus { scheduled, confirmed, moved, cancelled, inProgress }

class PlanningItem {
  final String id;
  final String subject;
  final DateTime start;
  final DateTime end;
  final PlanningItemType type;
  final PlanningItemStatus status;
  final String teacher;
  final String room;
  final String? campus;
  final String group;
  final List<String> resources;
  final String? lastChange;
  final bool isRecentChange;

  const PlanningItem({
    required this.id,
    required this.subject,
    required this.start,
    required this.end,
    required this.type,
    required this.status,
    required this.teacher,
    required this.room,
    required this.group,
    this.campus,
    this.resources = const [],
    this.lastChange,
    this.isRecentChange = false,
  });

  PlanningItem copyWith({
    DateTime? start,
    DateTime? end,
    PlanningItemStatus? status,
    String? lastChange,
    bool? isRecentChange,
  }) => PlanningItem(
    id: id,
    subject: subject,
    start: start ?? this.start,
    end: end ?? this.end,
    type: type,
    status: status ?? this.status,
    teacher: teacher,
    room: room,
    group: group,
    campus: campus,
    resources: resources,
    lastChange: lastChange ?? this.lastChange,
    isRecentChange: isRecentChange ?? this.isRecentChange,
  );
}

enum SemesterMilestoneType {
  teaching,
  assessment,
  exam,
  defense,
  holiday,
  result,
  institution,
}

class SemesterMilestone {
  final String title;
  final String subtitle;
  final DateTime date;
  final DateTime? endDate;
  final SemesterMilestoneType type;

  const SemesterMilestone({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.type,
    this.endDate,
  });
}
