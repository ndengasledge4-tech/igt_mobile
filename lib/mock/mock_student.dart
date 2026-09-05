import '../core/models/student_model.dart';

abstract final class MockStudentData {
  const MockStudentData._();

  static const current = StudentModel(
    firstName: 'Amira',
    lastName: 'Nsimba',
    email: 'amira.nsimba@etudiant.igt.cd',
    phone: '+243 000 000 000',
    matricule: 'IGT-2025-0142',
    formationId: 'licence-informatique',
    classId: 'l2-info',
    campusId: 'campus-principal',
    level: 'Licence 2',
    academicYear: '2025–2026',
    accountStatus: 'active',
  );
}
