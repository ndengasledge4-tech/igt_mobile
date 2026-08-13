class ClassModel {
  final String name;
  final String level;
  final String formationId;
  final String campusId;
  final String academicYear;

  const ClassModel({
    required this.name,
    required this.level,
    required this.formationId,
    required this.campusId,
    required this.academicYear,
  });

  Map<String, dynamic> toMap({required String uid}) {
    return {
      'uid': uid,
      'name': name.trim(),
      'level': level.trim(),
      'formationId': formationId,
      'campusId': campusId,
      'academicYear': academicYear.trim(),
    };
  }
}
