import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/language_tutor_app.dart';
import 'features/gemini/firebase_bootstrap.dart';

Future<void> main() async {
  await FirebaseBootstrap.initialize();

  runApp(const ProviderScope(child: LanguageTutorApp()));
}
