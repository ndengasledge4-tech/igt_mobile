class DocumentModel {
  final String title;
  final String description;
  final String category;
  final String fileUrl;
  final String fileType;
  final String? campusId;

  const DocumentModel({
    required this.title,
    required this.description,
    required this.category,
    required this.fileUrl,
    required this.fileType,
    this.campusId,
  });

  Map<String, dynamic> toMap({required String uid}) {
    return {
      'uid': uid,
      'title': title.trim(),
      'description': description.trim(),
      'category': category.trim(),
      'fileUrl': fileUrl.trim(),
      'fileType': fileType.trim(),
      'campusId': campusId,
    };
  }
}