import '../models/student_model.dart';
import '../services/firebase_service.dart';

class StudentRepository {
  StudentRepository({FirebaseService? firebaseService})
    : _firebaseService = firebaseService ?? FirebaseService();

  final FirebaseService _firebaseService;

  Future<void> createProfile({
    required String uid,
    required StudentModel student,
  }) {
    return _firebaseService.createStudentProfile(uid: uid, student: student);
  }
}
