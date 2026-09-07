import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Inscription avec email, mot de passe et informations personnelles
  Future<UserCredential> register({
    required String email,
    required String password,
    required String nom,
    required String prenom,
    required String matricule,
    required String telephone,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user != null) {
        await FirebaseFirestore.instance
            .collection('students')
            .doc(user.uid)
            .set({
          'uid': user.uid,
          'nom': nom,
          'prenom': prenom,
          'matricule': matricule,
          'email': email,
          'telephone': telephone,
        });
      }

      return credential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw FirebaseAuthException(
            code: 'email-already-in-use',
            message: 'Cette adresse e-mail est déjà utilisée.',
          );

        case 'invalid-email':
          throw FirebaseAuthException(
            code: 'invalid-email',
            message: 'L’adresse e-mail n’est pas valide.',
          );

        case 'weak-password':
          throw FirebaseAuthException(
            code: 'weak-password',
            message: 'Le mot de passe est trop faible.',
          );

        default:
          throw FirebaseAuthException(
            code: e.code,
            message: e.message ??
                'Une erreur est survenue lors de l’inscription.',
          );
      }
    }
  }

  // Connexion
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Déconnexion
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Utilisateur actuellement connecté
  User? get currentUser => _auth.currentUser;
}