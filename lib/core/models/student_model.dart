import 'student_account_status.dart';

class StudentModel {
  const StudentModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.matricule,
    required this.accountStatus,
    this.formationId,
    this.classId,
    this.campusId,
    this.level,
    this.academicYear,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String matricule;
  final StudentAccountStatus accountStatus;
  final String? formationId;
  final String? classId;
  final String? campusId;
  final String? level;
  final String? academicYear;

  String get normalizedMatricule {
    return matricule.trim().toUpperCase().replaceAll(RegExp(r'\s+'), '');
  }

  Map<String, Object?> toMap({required String uid}) {
    final trimmedFirstName = firstName.trim();
    final trimmedLastName = lastName.trim();

    return <String, Object?>{
      'uid': uid,
      'firstName': trimmedFirstName,
      'lastName': trimmedLastName,
      'fullName': '$trimmedFirstName $trimmedLastName',
      'email': email.trim().toLowerCase(),
      'phone': phone.trim(),
      'matricule': matricule.trim(),
      'matriculeNormalized': normalizedMatricule,
      'role': 'student',
      'accountStatus': accountStatus.firestoreValue,
      if (formationId != null) 'formationId': formationId!.trim(),
      if (classId != null) 'classId': classId!.trim(),
      if (campusId != null) 'campusId': campusId!.trim(),
      if (level != null) 'level': level!.trim(),
      if (academicYear != null) 'academicYear': academicYear!.trim(),
    };
  }
}
