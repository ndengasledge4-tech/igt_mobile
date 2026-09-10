import 'package:firebase_auth/firebase_auth.dart';

import '../exceptions/registration_exception.dart';
import '../models/student_model.dart';
import '../services/auth_service.dart';
import 'student_repository.dart';

abstract interface class RegistrationRepository {
  Future<String> registerStudent({
    required StudentModel student,
    required String password,
  });
}

class AuthRepository implements RegistrationRepository {
  AuthRepository({
    AuthService? authService,
    StudentRepository? studentRepository,
  }) : _authService = authService ?? AuthService(),
       _studentRepository = studentRepository ?? StudentRepository();

  final AuthService _authService;
  final StudentRepository _studentRepository;

  @override
  Future<String> registerStudent({
    required StudentModel student,
    required String password,
  }) async {
    User? createdUser;

    try {
      final credential = await _authService.createAccount(
        email: student.email,
        password: password,
      );
      createdUser = credential.user;

      if (createdUser == null) {
        throw const RegistrationException(
          code: 'auth-user-missing',
          userMessage: 'Le compte n’a pas pu être créé. Réessayez.',
        );
      }

      await _studentRepository.createProfile(
        uid: createdUser.uid,
        student: student,
      );

      // createUserWithEmailAndPassword connecte automatiquement l’utilisateur.
      // Une demande en attente ne doit pas ouvrir l’espace étudiant.
      try {
        await _authService.signOut();
      } on FirebaseAuthException {
        // Le compte et le profil sont déjà valides. Un échec de déconnexion
        // ne doit pas les supprimer ni transformer l’inscription en échec.
      }

      return createdUser.uid;
    } on FirebaseAuthException catch (error) {
      throw _mapAuthException(error);
    } on RegistrationException {
      if (createdUser != null && !await _rollbackAuthentication()) {
        throw const RegistrationException(
          code: 'rollback-failed',
          userMessage:
              'Le profil n’a pas été créé, mais le compte de connexion '
              'existe peut-être. Contactez le support avant de réessayer.',
        );
      }
      rethrow;
    } on FirebaseException catch (error) {
      final rollbackSucceeded =
          createdUser == null || await _rollbackAuthentication();

      if (!rollbackSucceeded) {
        throw const RegistrationException(
          code: 'rollback-failed',
          userMessage:
              'Le profil n’a pas été créé, mais le compte de connexion '
              'existe peut-être. Contactez le support avant de réessayer.',
        );
      }

      throw _mapFirebaseException(error);
    } catch (_) {
      final rollbackSucceeded =
          createdUser == null || await _rollbackAuthentication();

      if (!rollbackSucceeded) {
        throw const RegistrationException(
          code: 'rollback-failed',
          userMessage:
              'Le profil n’a pas été créé, mais le compte de connexion '
              'existe peut-être. Contactez le support avant de réessayer.',
        );
      }

      throw const RegistrationException(
        code: 'unknown',
        userMessage: 'Une erreur inattendue est survenue. Réessayez.',
      );
    }
  }

  Future<bool> _rollbackAuthentication() async {
    try {
      await _authService.deleteCurrentUser();
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  RegistrationException _mapAuthException(FirebaseAuthException error) {
    switch (error.code) {
      case 'email-already-in-use':
        return const RegistrationException(
          code: 'email-already-in-use',
          userMessage: 'Un compte utilise déjà cette adresse email.',
        );
      case 'invalid-email':
        return const RegistrationException(
          code: 'invalid-email',
          userMessage: 'L’adresse email n’est pas valide.',
        );
      case 'weak-password':
        return const RegistrationException(
          code: 'weak-password',
          userMessage: 'Le mot de passe est trop faible.',
        );
      case 'network-request-failed':
        return const RegistrationException(
          code: 'network-request-failed',
          userMessage: 'Connexion réseau indisponible. Vérifiez Internet.',
        );
      case 'operation-not-allowed':
        return const RegistrationException(
          code: 'operation-not-allowed',
          userMessage: 'L’inscription par email n’est pas activée.',
        );
      default:
        return const RegistrationException(
          code: 'authentication-error',
          userMessage: 'La création du compte de connexion a échoué.',
        );
    }
  }

  RegistrationException _mapFirebaseException(FirebaseException error) {
    switch (error.code) {
      case 'unavailable':
        return const RegistrationException(
          code: 'firestore-unavailable',
          userMessage: 'Le service est temporairement indisponible. Réessayez.',
        );
      case 'permission-denied':
        return const RegistrationException(
          code: 'permission-denied',
          userMessage:
              'Le profil n’a pas pu être enregistré. '
              'Vérifiez la configuration Firebase.',
        );
      default:
        return const RegistrationException(
          code: 'firestore-error',
          userMessage: 'Le profil étudiant n’a pas pu être enregistré.',
        );
    }
  }
}
