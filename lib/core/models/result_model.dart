class ResultModel {
  final String studentId;
  final String subjectId;
  final double grade;
  final double coefficient;
  final String semester;
  final String academicYear;

  const ResultModel({
    required this.studentId,
    required this.subjectId,
    required this.grade,
    required this.coefficient,
    required this.semester,
    required this.academicYear,
  });

  Map<String, dynamic> toMap({required String uid}) {
    return {
      'uid': uid,
      'studentId': studentId,
      'subjectId': subjectId,
      'grade': grade,
      'coefficient': coefficient,
      'semester': semester,
      'academicYear': academicYear.trim(),
    };
  }
}
