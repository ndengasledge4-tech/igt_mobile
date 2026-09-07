import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';

class FirebaseService {
  FirebaseService._();

  static Future<FirebaseApp> initialize() async {
    if (Firebase.apps.isNotEmpty) {
      return Firebase.app();
    }

    return Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
