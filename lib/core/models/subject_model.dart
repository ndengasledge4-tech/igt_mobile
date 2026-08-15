class SubjectModel {
  final String name;
  final double coefficient;
  final String classId;
  final String teacherName;

  const SubjectModel({
    required this.name,
    required this.coefficient,
    required this.classId,
    required this.teacherName,
  });

  Map<String, dynamic> toMap({required String uid}) {
    return {
      'uid': uid,
      'name': name.trim(),
      'coefficient': coefficient,
      'classId': classId,
      'teacherName': teacherName.trim(),
    };
  }
}
