import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

/// Stub Firebase options kept in git so the repo contains no live project keys.
///
/// Replace this file locally with `flutterfire configure --out lib/firebase_options.dart`
/// before running with `--dart-define=FIREBASE_AI_ENABLED=true`.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    throw UnsupportedError(
      'Firebase is not configured. Run `flutterfire configure` to generate '
      '`lib/firebase_options.dart`, keep the generated platform files local, '
      'and only then enable `FIREBASE_AI_ENABLED`.',
    );
  }
}
