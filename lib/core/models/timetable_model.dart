class TimetableModel {
  final String classId;
  final String subjectId;
  final String day;
  final String startTime;
  final String endTime;
  final String room;
  final String teacherName;

  const TimetableModel({
    required this.classId,
    required this.subjectId,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.room,
    required this.teacherName,
  });

  Map<String, dynamic> toMap({required String uid}) {
    return {
      'uid': uid,
      'classId': classId,
      'subjectId': subjectId,
      'day': day.trim(),
      'startTime': startTime.trim(),
      'endTime': endTime.trim(),
      'room': room.trim(),
      'teacherName': teacherName.trim(),
    };
  }
}
