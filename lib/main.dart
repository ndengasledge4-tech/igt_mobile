import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'firebase_options.dart'; // Généré automatiquement par `flutterfire configure`. Ne pas modifier à la main.

/// Point d'entrée de l'application.
/// `main` est déclaré `async` car Firebase doit être totalement initialisé
/// AVANT que le premier écran ne s'affiche (sinon FirebaseAuth.instance /
/// FirebaseFirestore.instance risquent d'être utilisés trop tôt).
Future<void> main() async {
  // Garantit que le moteur Flutter est prêt avant tout appel à un plugin natif
  // (obligatoire dès qu'on fait un `await` avant `runApp`).
  WidgetsFlutterBinding.ensureInitialized();

  // Initialise Firebase avec la configuration correspondant à la plateforme
  // courante (Android / iOS / Web / Windows...), définie dans firebase_options.dart.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Une fois Firebase prêt, on peut lancer l'application normalement.
  runApp(const IgtApp());
}
