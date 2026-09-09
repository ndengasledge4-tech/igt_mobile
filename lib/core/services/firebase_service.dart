import 'package:cloud_firestore/cloud_firestore.dart';

import '../exceptions/registration_exception.dart';
import '../models/student_model.dart';

class FirebaseService {
  FirebaseService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<void> createStudentProfile({
    required String uid,
    required StudentModel student,
  }) async {
    final studentReference = _firestore.collection('students').doc(uid);

    final identifierReference = _firestore
        .collection('student_identifiers')
        .doc(student.normalizedMatricule);

    await _firestore.runTransaction<void>((transaction) async {
      final identifierSnapshot = await transaction.get(identifierReference);

      if (identifierSnapshot.exists) {
        throw const RegistrationException(
          code: 'student-id-already-used',
          userMessage: 'Cet identifiant étudiant est déjà utilisé.',
        );
      }

      transaction.set(identifierReference, <String, Object?>{
        'uid': uid,
        'createdAt': FieldValue.serverTimestamp(),
      });

      transaction.set(studentReference, <String, Object?>{
        ...student.toMap(uid: uid),
        'createdAt': FieldValue.serverTimestamp(),
      });
    });
  }
}
