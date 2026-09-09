import 'package:flutter_test/flutter_test.dart';

import 'package:igt/core/controllers/auth_controller.dart';
import 'package:igt/core/controllers/registration_status.dart';
import 'package:igt/core/exceptions/registration_exception.dart';
import 'package:igt/core/models/student_account_status.dart';
import 'package:igt/core/models/student_model.dart';
import 'package:igt/core/repositories/auth_repository.dart';

class FakeRegistrationRepository implements RegistrationRepository {
  FakeRegistrationRepository({this.error});

  final RegistrationException? error;

  @override
  Future<String> registerStudent({
    required StudentModel student,
    required String password,
  }) async {
    if (error != null) {
      throw error!;
    }

    return 'uid-test';


  }
}

const student = StudentModel(
  firstName: 'Amira',
  lastName: 'Nsimba',
  email: '[amira@igt.edu](mailto:amira@igt.edu)',
  phone: '+242061234567',
  matricule: '2026IG001',
  accountStatus: StudentAccountStatus.pending,
);

void main() {
  test(
      'passe à success quand le repository réussit',
          () async {
        final controller = AuthController(
          repository: FakeRegistrationRepository(),
        );
        final result = await controller.registerStudent(
        student: student,
        password: 'Solide2026',
        );

        expect(result, isTrue);
        expect(controller.status, RegistrationStatus.success);
        expect(controller.errorMessage, isNull);
        },

  );

  test(
      'expose un message utilisateur quand le repository échoue',
          () async {
        final controller = AuthController(
          repository: FakeRegistrationRepository(
            error: const RegistrationException(
              code: 'email-already-in-use',
              userMessage:
              'Un compte utilise déjà cette adresse email.',
            ),
          ),
        );

        final result = await controller.registerStudent(
        student: student,
        password: 'Solide2026',
        );

        expect(result, isFalse);
        expect(controller.status, RegistrationStatus.failure);
        expect(
        controller.errorMessage,
        contains('déjà'),
        );
      },

  );
}
