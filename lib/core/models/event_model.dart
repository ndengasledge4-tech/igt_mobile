class EventModel {
  final String title;
  final String description;
  final String location;
  final DateTime eventDate;
  final String startTime;
  final String? campusId;
  final List<String> images;
  final bool participationOpen;

  const EventModel({
    required this.title,
    required this.description,
    required this.location,
    required this.eventDate,
    required this.startTime,
    this.campusId,
    required this.images,
    required this.participationOpen,
  });

  Map<String, dynamic> toMap({required String uid}) {
    return {
      'uid': uid,
      'title': title.trim(),
      'description': description.trim(),
      'location': location.trim(),
      'eventDate': eventDate,
      'startTime': startTime.trim(),
      'campusId': campusId,
      'images': images,
      'participationOpen': participationOpen,
    };
  }
}
