# Development

This app runs in two modes:

1. Live Gemini mode on Android and iOS: Firebase AI Logic calls Gemini 2.5 Flash from Flutter.
2. Demo mode fallback on unsupported platforms: deterministic local Gemini substitute.

We use Gemini 2.5 Flash through Firebase AI Logic, Google's official mobile SDK path for calling Gemini from Flutter.

## Local Tooling

```sh
flutter --version
dart --version
firebase --version
```

Install the Firebase CLI if needed:

```sh
npm install -g firebase-tools
firebase login
```

Install the FlutterFire CLI if needed:

```sh
dart pub global activate flutterfire_cli
```

If `flutterfire` is not found after install, add Pub's global bin directory to your shell path:

```sh
export PATH="$PATH:$HOME/.pub-cache/bin"
```

## Project Setup

Install dependencies:

```sh
flutter pub get
```

Generate Drift and JSON code:

```sh
dart run build_runner build
```

Run the app:

```sh
flutter run
```

Run checks:

```sh
dart format --set-exit-if-changed .
flutter analyze
flutter test
```

## Firebase Setup For Live Gemini

Create or select a Firebase project:

```sh
firebase login
firebase projects:list
```

If creating a new project:

```sh
firebase projects:create YOUR_PROJECT_ID --display-name "Language Tutor"
```

Configure Android and iOS apps with FlutterFire:

```sh
flutterfire configure \
  --project YOUR_PROJECT_ID \
  --platforms android,ios \
  --android-package-name com.denuoweb.language_tutor \
  --ios-bundle-id com.denuoweb.languageTutor \
  --out lib/firebase_options.dart
```

This replaces the committed stub at `lib/firebase_options.dart` with Firebase config for your project.

If the Firebase apps already exist and you need to inspect their app IDs:

```sh
firebase apps:list --project YOUR_PROJECT_ID
```

If you need to recover an existing platform config manually:

```sh
firebase apps:sdkconfig ANDROID FIREBASE_ANDROID_APP_ID --project YOUR_PROJECT_ID
firebase apps:sdkconfig IOS FIREBASE_IOS_APP_ID --project YOUR_PROJECT_ID
```

Prefer `flutterfire configure` for this Flutter app because it writes the Dart `DefaultFirebaseOptions` class expected by `lib/features/gemini/firebase_bootstrap.dart`.

Enable Firebase AI Logic:

1. Open Firebase Console.
2. Select `YOUR_PROJECT_ID`.
3. Open AI services / Firebase AI Logic.
4. Click Get started.
5. Select Gemini Developer API for the MVP.
6. Let Firebase enable the required APIs and create the Gemini API key.
7. Do not paste that Gemini API key into Flutter code.

After Firebase is configured for Android and iOS, `flutter run` uses the live
Firebase AI Logic path by default on those platforms.

## Android Toolchain Overrides

If the default Android SDK contains a broken or incomplete NDK, keep `sdk.dir`
pointing at the working SDK and add a custom NDK override in `android/local.properties`:

```properties
sdk.dir=/home/den/Android/Sdk
apkw.ndk.path=/home/den/.local/share/apkw/toolchains/android-ndk-custom/r29
```

The Gradle build reads `apkw.ndk.path` and maps it to `android.ndkPath`.
This is intended for local machine setup and should not be committed.

## Secrets And Firebase

For this mobile app, there should be no local `.env` file and no Gemini API key in the repo.

Firebase config files such as `lib/firebase_options.dart`, `google-services.json`, and `GoogleService-Info.plist` contain project identifiers and Firebase API keys. Firebase documents these API keys as non-secret identifiers, but they should still be restricted and reviewed in Google Cloud Console.

Real secrets must not be read directly by Flutter clients. Mobile apps are untrusted clients, so Firebase Secret Manager is only appropriate for server-side Firebase code such as Cloud Functions or App Hosting.

If this project later adds Cloud Functions, store server-only secrets with Firebase Functions secrets:

```sh
firebase init functions
firebase functions:secrets:set SECRET_NAME
firebase deploy --only functions
```

Read those secrets only inside functions that explicitly bind the secret. Do not forward raw secret values to the app.

If this project later adds Firebase App Hosting, store App Hosting secrets with:

```sh
firebase apphosting:secrets:set SECRET_NAME \
  --project YOUR_PROJECT_ID \
  --location YOUR_REGION \
  --data-file _
```

Then grant the App Hosting backend access:

```sh
firebase apphosting:secrets:grantaccess SECRET_NAME BACKEND_ID \
  --project YOUR_PROJECT_ID \
  --location YOUR_REGION
```

## App Check

Before sharing a live build, configure Firebase App Check for Firebase AI Logic.

1. Add the Firebase App Check Flutter plugin.
2. Register Android and iOS apps in Firebase App Check.
3. Use debug providers for local development.
4. Use Play Integrity for Android release builds.
5. Use App Attest or DeviceCheck for iOS release builds.
6. Pass `FirebaseAppCheck.instance` when constructing `FirebaseAI.googleAI(...)`.
7. Enable enforcement after debug builds and release builds have valid attestations.

App Check is not a secret store. It reduces API abuse by proving requests come from registered app instances.

## Common Commands

```sh
flutter pub get
dart run build_runner build
dart format --set-exit-if-changed .
flutter analyze
flutter test
flutter run
```

If Gradle reports corrupted Kotlin DSL metadata such as `metadata.bin`, clear that
cache and rebuild:

```sh
cd android
./gradlew --stop
rm -rf ~/.gradle/caches/8.14/kotlin-dsl/scripts ~/.gradle/caches/8.14/kotlin-dsl/accessors
./gradlew app:assembleDebug
```

## Files To Keep Out Of Git

Do not commit:

```text
.env
.env.*
*.pem
*.p12
*.keystore
*.jks
service-account*.json
firebase-adminsdk*.json
```

The generated `lib/firebase_options.dart` is not a secret, but review it before committing if the repository is public.

## References

* Firebase Flutter setup: https://firebase.google.com/docs/flutter/setup
* Firebase AI Logic setup: https://firebase.google.com/docs/ai-logic/get-started
* Firebase API key guidance: https://firebase.google.com/docs/projects/api-keys
* Firebase AI Logic App Check: https://firebase.google.com/docs/ai-logic/app-check
* Firebase Functions secrets: https://firebase.google.com/docs/functions/config-env
* Firebase CLI reference: https://firebase.google.com/docs/cli
