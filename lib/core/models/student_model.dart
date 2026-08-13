class StudentModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String matricule;
  final String formationId;
  final String classId;
  final String campusId;
  final String level;
  final String academicYear;
  final String accountStatus;

  const StudentModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.matricule,
    required this.formationId,
    required this.classId,
    required this.campusId,
    required this.level,
    required this.academicYear,
    required this.accountStatus,
  });

  Map<String, dynamic> toMap({required String uid}) {
    return {
      'uid': uid,
      'firstName': firstName.trim(),
      'lastName': lastName.trim(),
      'fullName': '${firstName.trim()} ${lastName.trim()}',
      'email': email.trim().toLowerCase(),
      'phone': phone.trim(),
      'matricule': matricule.trim(),
      'formationId': formationId,
      'classId': classId,
      'campusId': campusId,
      'level': level.trim(),
      'academicYear': academicYear.trim(),
      'role': 'student',
      'accountStatus': accountStatus,
    };
  }
}
