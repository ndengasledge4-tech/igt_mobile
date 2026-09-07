import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository({AuthService? authService})
      : _authService = authService ?? AuthService();

  Future<UserCredential> register({
    required String email,
    required String password,
    required String matricule,
    required String nom,
    required String prenom,
    required String telephone,
  }) async {
    return await _authService.register(
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
    return await _authService.login(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await _authService.logout();
  }

  User? get currentUser => _authService.currentUser;
}