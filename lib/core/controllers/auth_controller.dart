import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/auth_repository.dart';

class AuthController {
  final AuthRepository _authRepository;

  AuthController({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepository();

  Future<UserCredential> register({
    required String email,
    required String password,
    required String matricule,
    required String nom,
    required String prenom,
    required String telephone,
  }) async {
    return await _authRepository.register(
      email: email,
      password: password,
      matricule: matricule,
      nom: nom,
      prenom: prenom,
      telephone: telephone,
    );
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _authRepository.login(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await _authRepository.logout();
  }

  User? get currentUser => _authRepository.currentUser;
}