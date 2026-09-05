class NewsModel {
  final String title;
  final String content;
  final List<String> images;
  final String category;
  final String authorId;
  final String? campusId;
  final bool commentsAllowed;
  final bool isPublished;

  const NewsModel({
    required this.title,
    required this.content,
    required this.images,
    required this.category,
    required this.authorId,
    this.campusId,
    required this.commentsAllowed,
    required this.isPublished,
  });

  Map<String, dynamic> toMap({required String uid}) {
    return {
      'uid': uid,
      'title': title.trim(),
      'content': content.trim(),
      'images': images,
      'category': category.trim(),
      'authorId': authorId,
      'campusId': campusId,
      'commentsAllowed': commentsAllowed,
      'isPublished': isPublished,
      'likesCount': 0,
      'commentsCount': 0,
    };
  }
}
