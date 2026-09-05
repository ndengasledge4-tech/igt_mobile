class NotificationModel {
  final String title;
  final String message;
  final String type;
  final bool isRead;
  final String? targetId;

  const NotificationModel({
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    this.targetId,
  });

  Map<String, dynamic> toMap({required String uid}) {
    return {
      'uid': uid,
      'title': title.trim(),
      'message': message.trim(),
      'type': type.trim(),
      'isRead': isRead,
      'targetId': targetId,
    };
  }
}
