class CommentModel {
  final String newsId;
  final String authorId;
  final String content;

  const CommentModel({
    required this.newsId,
    required this.authorId,
    required this.content,
  });

  Map<String, dynamic> toMap({required String uid}) {
    return {
      'uid': uid,
      'newsId': newsId,
      'authorId': authorId,
      'content': content.trim(),
    };
  }
}
