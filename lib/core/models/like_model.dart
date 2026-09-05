class LikeModel {
  final String newsId;
  final String studentId;

  const LikeModel({required this.newsId, required this.studentId});

  Map<String, dynamic> toMap({required String uid}) {
    return {'uid': uid, 'newsId': newsId, 'studentId': studentId};
  }
}
