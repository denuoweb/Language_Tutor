import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

import '../../firebase_options.dart';

class FirebaseBootstrap {
  static const liveGeminiEnabled = bool.fromEnvironment('FIREBASE_AI_ENABLED');

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (!liveGeminiEnabled) {
      return;
    }

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
