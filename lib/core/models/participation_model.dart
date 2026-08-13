class ParticipationModel {
  final String eventId;
  final String studentId;
  final String status;

  const ParticipationModel({
    required this.eventId,
    required this.studentId,
    required this.status,
  });

  Map<String, dynamic> toMap({required String uid}) {
    return {
      'uid': uid,
      'eventId': eventId,
      'studentId': studentId,
      'status': status,
    };
  }
}
