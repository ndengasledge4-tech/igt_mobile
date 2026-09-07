import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/student_model.dart';

class StudentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createStudent(StudentModel student, String uid) async {
    await _firestore
        .collection('students')
        .doc(uid)
        .set(student.toMap(uid: uid));
  }

  Future<StudentModel?> getStudent(String uid) async {
    final document = await _firestore
        .collection('students')
        .doc(uid)
        .get();

    if (!document.exists) {
      return null;
    }

    final data = document.data()!;

    return StudentModel(
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      matricule: data['matricule'] ?? '',
      formationId: data['formationId'] ?? '',
      classId: data['classId'] ?? '',
      campusId: data['campusId'] ?? '',
      level: data['level'] ?? '',
      academicYear: data['academicYear'] ?? '',
      accountStatus: data['accountStatus'] ?? '',
    );
  }
}
