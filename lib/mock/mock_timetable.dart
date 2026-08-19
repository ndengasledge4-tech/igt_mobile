class MockLesson {
  final String subject;
  final String teacher;
  final String room;
  final String day;
  final String startTime;
  final String endTime;

  const MockLesson({
    required this.subject,
    required this.teacher,
    required this.room,
    required this.day,
    required this.startTime,
    required this.endTime,
  });
}

abstract final class MockTimetableData {
  const MockTimetableData._();

  static const lessons = [
    MockLesson(
      subject: 'Algorithmique',
      teacher: 'Dr Karim Mansouri',
      room: 'B12',
      day: 'Lundi',
      startTime: '08:00',
      endTime: '10:00',
    ),
    MockLesson(
      subject: 'Bases de données',
      teacher: 'Mme Amina Belhaj',
      room: 'Lab 2',
      day: 'Lundi',
      startTime: '10:15',
      endTime: '12:15',
    ),
  ];
}
