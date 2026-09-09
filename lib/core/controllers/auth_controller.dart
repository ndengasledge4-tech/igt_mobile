import 'package:flutter/foundation.dart';

import '../exceptions/registration_exception.dart';
import '../models/student_model.dart';
import '../repositories/auth_repository.dart';
import 'registration_status.dart';

class AuthController extends ChangeNotifier {
  AuthController({RegistrationRepository? repository})
    : _repository = repository ?? AuthRepository();

  final RegistrationRepository _repository;

  RegistrationStatus _status = RegistrationStatus.idle;
  String? _errorMessage;

  RegistrationStatus get status => _status;
  String? get errorMessage => _errorMessage;

  bool get isLoading => _status == RegistrationStatus.loading;

  Future<bool> registerStudent({
    required StudentModel student,
    required String password,
  }) async {
    if (isLoading) return false;

    _status = RegistrationStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.registerStudent(student: student, password: password);

      _status = RegistrationStatus.success;
      notifyListeners();

      return true;
    } on RegistrationException catch (error) {
      _status = RegistrationStatus.failure;
      _errorMessage = error.userMessage;
      notifyListeners();

      return false;
    } catch (_) {
      _status = RegistrationStatus.failure;
      _errorMessage = 'Une erreur inattendue est survenue. Réessayez.';
      notifyListeners();

      return false;
    }
  }

  void clearError() {
    if (_status != RegistrationStatus.failure) return;

    _status = RegistrationStatus.idle;
    _errorMessage = null;
    notifyListeners();
  }
}
