# Ambient SRS Language Tutor — Tightened SRS v1.1

## 1. Product Definition

**Product:** Ambient SRS Language Tutor

**Hackathon:** Beaver Hackathon 2026

**Track:** Gemini AI Track

**Primary platform:** Flutter mobile app targeting iOS and Android

**Primary AI service:** Firebase AI Logic / Gemini API

**Gemini path:** We use Gemini 2.5 Flash through Firebase AI Logic, Google's official mobile SDK path for calling Gemini from Flutter.

**MVP camera source:** Phone camera

**Stretch camera source:** Ray-Ban Meta Gen 2 through native iOS/Android bridge

**MVP language:** Japanese

**Core learning mode:** Passive environment-based sentence generation plus SRS review


The app shall periodically capture images from the phone camera, send selected still frames to Gemini, generate one level-appropriate Japanese learning item, speak it aloud, and save it as an SRS card.

Gemini is central to the MVP:

* Use Gemini image understanding for camera frames.
* Use Gemini structured output for lesson JSON.
* Use Gemini to generate level-appropriate Japanese.
* Use Gemini to generate SRS card metadata.

The Ray-Ban Meta Gen 2 integration shall remain optional. The app must remain fully functional with only the phone camera. Meta’s Wearables Device Access Toolkit is available as a developer-preview SDK for mobile apps, and Meta describes it as enabling access to AI-glasses camera/audio capabilities, but it should not be treated as an MVP dependency. ([Meta for Developers][1])

---

## 2. Researched Stack Decisions

### 2.1 Runtime baseline

Use the current stable Flutter/Dart channel for development. Flutter 3.41 was announced on February 11, 2026, and Dart 3.11 was released the same day. Flutter’s own archive documentation identifies the stable channel as the recommended channel for new users and production app releases. ([Flutter][2])

Recommended environment constraint:

```yaml
environment:
  sdk: ">=3.9.0 <4.0.0"
```

Reason: the latest `camera` and `json_annotation` packages require Dart 3.9+, while most Firebase packages only require Dart 3.2+. ([Dart packages][3])

---

### 2.2 Gemini model choice

Use:

```text
gemini-2.5-flash
```

Do **not** use a `latest` alias for the hackathon demo. Google’s Gemini model docs say stable model names usually do not change and that production apps should use a specific stable model; `latest` aliases can be hot-swapped. ([Google AI for Developers][4])

`gemini-2.5-flash` is listed by Firebase AI Logic as a stable Gemini 2.5 Flash model, released June 17, 2025, with shutdown no earlier than June 17, 2026. ([Firebase][5]) It supports text, code, image, audio, and video inputs with text output, which fits the image-to-Japanese-lesson use case. ([Google Cloud Documentation][6])

Use structured output, not prompt-only JSON. Firebase AI Logic supports `responseSchema` and `application/json` for structured responses, and its docs explicitly say Gemini can produce structured responses for multimodal requests including images. ([Firebase][7])

---

### 2.3 Local database choice

Use **Drift**, not Hive.

Reason: Hive’s stable `hive_flutter` package is still at `1.1.0`, uploaded years ago, while Drift `2.32.1` is current and actively updated. ([Dart packages][8]) Drift is also a better fit for due-card queries, review history, scheduling, and future analytics. Drift’s docs recommend `package:drift/native.dart` for newer Android/iOS projects and state that, starting with Drift 2.32.0 and `sqlite3` 3.x, no extra SQLite setup package is necessary. ([Drift][9])

---

## 3. Dependency Specification

As of this research pass, use these stable package versions:

```yaml
dependencies:
  flutter:
    sdk: flutter

  firebase_core: ^4.7.0
  firebase_ai: ^3.11.0

  camera: ^0.12.0+1
  flutter_tts: ^4.2.5
  permission_handler: ^12.0.1

  flutter_riverpod: ^3.3.1

  drift: ^2.32.1
  path_provider: ^2.1.5
  path: ^1.9.1

  json_annotation: ^4.11.0
  uuid: ^4.5.3

dev_dependencies:
  build_runner: ^2.15.0
  drift_dev: ^2.32.1
  json_serializable: ^6.13.2
```

Version evidence:

| Package              | Latest stable found | Purpose                                                 |
| -------------------- | ------------------: | ------------------------------------------------------- |
| `firebase_core`      |             `4.7.0` | Firebase initialization ([Dart packages][10])           |
| `firebase_ai`        |            `3.11.0` | Firebase AI Logic / Gemini access ([Dart packages][11]) |
| `camera`             |          `0.12.0+1` | Camera preview and capture ([Dart packages][3])         |
| `flutter_tts`        |             `4.2.5` | Japanese TTS ([Dart packages][12])                      |
| `permission_handler` |            `12.0.1` | Runtime permission handling ([Dart packages][13])       |
| `flutter_riverpod`   |             `3.3.1` | State management ([Dart packages][14])                  |
| `drift`              |            `2.32.1` | Local relational persistence ([Dart packages][15])      |
| `path_provider`      |             `2.1.5` | App storage paths ([Dart packages][16])                 |
| `path`               |             `1.9.1` | Cross-platform path operations ([Dart packages][17])    |
| `uuid`               |             `4.5.3` | Card IDs ([Dart packages][18])                          |
| `json_annotation`    |            `4.11.0` | Typed JSON models ([Dart packages][19])                 |
| `json_serializable`  |            `6.13.2` | JSON parsing/codegen ([Dart packages][20])              |
| `build_runner`       |            `2.15.0` | Code generation runner ([Dart packages][21])            |
| `drift_dev`          |            `2.32.1` | Drift code generation ([Dart packages][22])             |

Firebase’s own setup docs say the Flutter Firebase AI Logic plugin is `firebase_ai`, installed with `firebase_core`, and that Firebase AI Logic can be called directly from Flutter apps. ([Firebase][23])

---

# 4. Scope

## 4.1 MVP Scope

The MVP shall include:

1. Phone camera preview.
2. Manual start/stop passive capture mode.
3. Periodic still-frame capture.
4. Gemini image analysis.
5. Structured JSON lesson generation.
6. Japanese sentence, reading, English meaning, and vocabulary display.
7. Japanese TTS playback.
8. Local SRS card creation.
9. Due-card review screen.
10. Again / Hard / Good / Easy review grading.
11. Local persistence with Drift.
12. Camera-source abstraction for future Ray-Ban support.

## 4.2 Stretch Scope

The stretch scope may include:

1. Ray-Ban Meta Gen 2 audio output over Bluetooth.
2. Native Ray-Ban camera bridge.
3. Camera-source selector.
4. Deduplication cooldown.
5. App Check.
6. Export to Anki-compatible format.
7. Review statistics.
8. User-configurable capture interval.

## 4.3 Explicitly Out of Scope

The hackathon MVP shall not include:

1. Account system.
2. Cloud sync.
3. Production Ray-Ban app publishing.
4. Continuous video analysis.
5. Perfect JLPT classification.
6. Offline Gemini inference.
7. Multi-language support beyond Japanese.
8. Pronunciation scoring.
9. Long grammar explanations.
10. Image retention by default.

---

# 5. Functional Requirements

## FR-1: Camera Preview

The app shall display a live phone-camera preview.

Acceptance criteria:

* The user can see the camera feed.
* The app requests camera permission before preview.
* The app handles denied permission without crashing.
* The app initializes the camera controller before rendering preview.

Flutter’s camera cookbook recommends obtaining available cameras, creating and initializing a `CameraController`, using `CameraPreview`, and waiting for initialization before displaying the preview. ([Flutter Documentation][24])

---

## FR-2: Passive Capture Mode

The app shall provide a `Start Ambient Learning` and `Stop` control.

Acceptance criteria:

* When started, the app captures one still frame at a configured interval.
* Default interval shall be 10 seconds.
* Minimum interval shall be 5 seconds.
* When stopped, no further frames shall be captured or sent to Gemini.
* The app shall never send continuous video for MVP.

---

## FR-3: Frame Source Abstraction

The app shall define a common frame-source interface.

```dart
abstract interface class FrameSource {
  Stream<CameraFrame> get frames;
  Future<void> start({Duration interval});
  Future<void> stop();
}
```

Required implementations:

```text
PhoneCameraFrameSource
```

Optional implementation:

```text
RayBanFrameSource
```

Acceptance criteria:

* Gemini code receives `CameraFrame` objects, not direct camera-controller objects.
* Phone and Ray-Ban sources share the same downstream pipeline.
* Failure of Ray-Ban source initialization does not break phone-camera mode.

---

## FR-4: Gemini Image Analysis

The app shall send compressed still images to Gemini through Firebase AI Logic.

Acceptance criteria:

* Each request includes one JPEG image and a structured prompt.
* The app uses `gemini-2.5-flash`.
* The request uses structured output with a response schema.
* Failed requests do not create SRS cards.
* The UI remains responsive during request execution.

Firebase AI Logic’s image docs say Gemini can analyze image files provided inline or by URL, and that Firebase AI Logic can make the request directly from the app. ([Firebase][25])

---

## FR-5: Structured Lesson Output

Gemini shall return one and only one learning item per accepted frame.

Required schema:

```json
{
  "sceneLabel": "string",
  "english": "string",
  "japanese": "string",
  "reading": "string",
  "keyVocabulary": [
    {
      "japanese": "string",
      "reading": "string",
      "meaning": "string",
      "approxJlpt": "N5 | N4 | N3 | N2 | N1 | unknown"
    }
  ],
  "grammarNote": "string",
  "confidence": 0.0
}
```

Acceptance criteria:

* Response must parse into a typed Dart model.
* Missing required fields invalidate the result.
* `confidence < 0.60` should not auto-save.
* The app shall display a recoverable error on parse failure.

Implementation note: use `json_serializable` for typed parsing. Its documentation supports generated `fromJson` / `toJson` methods and can generate JSON Schema from annotated classes, which is useful for keeping Dart model definitions aligned with the Gemini response schema. ([Dart packages][20])

---

## FR-6: Level Selection

The app shall allow the user to select:

```text
N5, N4, N3, N2, N1
```

Acceptance criteria:

* Selected level is included in the Gemini prompt.
* Selected level is persisted locally.
* Default level is `N5`.
* The app describes levels as approximate difficulty, not certified JLPT classification.

---

## FR-7: Lesson Display

The app shall display the current lesson.

Required fields:

```text
English
Japanese
Reading
Vocabulary
Approximate level
Grammar note
```

Acceptance criteria:

* Japanese text is visually prominent.
* Reading is visible below Japanese.
* English meaning is visible but secondary.
* Grammar note is no longer than one sentence.

---

## FR-8: Text-to-Speech

The app shall speak the generated Japanese sentence.

Acceptance criteria:

* Japanese TTS plays automatically when a lesson is generated.
* User can mute TTS.
* TTS must not block the UI.
* TTS should route through the system-selected audio output.

If Ray-Ban Meta glasses are paired as Bluetooth audio, this should be sufficient for the hackathon demo; no custom glasses-speaker SDK is required for MVP.

---

## FR-9: SRS Card Creation

The app shall create one SRS card from each accepted lesson.

Acceptance criteria:

* Card is created only after valid Gemini response.
* Card is saved locally.
* Card receives an initial due time.
* Duplicate cards are avoided when the same vocabulary appears repeatedly within the cooldown window.

---

## FR-10: SRS Review

The app shall provide a review screen.

Acceptance criteria:

* App queries all cards where `dueAt <= now`.
* Japanese sentence is shown first.
* User can reveal English, reading, vocabulary, and grammar note.
* User can grade the review as `Again`, `Hard`, `Good`, or `Easy`.
* Review grade updates due date, interval, ease, repetition count, and lapse count.

---

## FR-11: Local Persistence

The app shall use Drift for local persistence.

Required tables:

```text
learning_cards
review_events
settings
recent_generation_cache
```

Acceptance criteria:

* Cards persist after app restart.
* Due cards can be queried efficiently.
* Review events are recorded.
* Settings persist across app restart.
* The app can run SRS review offline.

---

## FR-12: Ray-Ban Extension

The app shall include architecture support for a future Ray-Ban source, but this shall not block MVP completion.

Acceptance criteria:

* `RayBanFrameSource` exists as an interface or stub.
* Flutter uses platform channels for native iOS/Android bridge work.
* Phone camera remains default.
* If Ray-Ban camera access is unavailable, the app still demos successfully.

Meta’s developer preview describes SDK and documentation access, testing on supported AI glasses, and release channels for test users, but this remains a preview flow rather than a guaranteed same-day hackathon dependency. ([GitHub][26])

---

# 6. Non-Functional Requirements

## NFR-1: Latency

Target:

```text
Frame capture → Gemini response → UI display: under 10 seconds
```

Preferred:

```text
Under 5 seconds
```

## NFR-2: API Cost Control

The app shall sample still frames rather than stream continuous video.

Requirements:

* Default capture interval: 10 seconds.
* User may increase interval.
* Minimum allowed interval: 5 seconds.
* No background capture when app is stopped.

## NFR-3: Reliability

The app shall survive:

* Camera permission denial.
* Camera initialization failure.
* Gemini network failure.
* Gemini malformed response.
* TTS failure.
* Local database failure.

The app shall never crash on a single failed generation.

## NFR-4: Privacy Defaults

The app shall not store raw captured images by default.

Requirements:

* Store generated text cards only.
* Discard frame bytes after Gemini request.
* Do not start capture until user taps start.
* Stop capture immediately when user taps stop.

Firebase recommends Firebase App Check before sharing an app publicly to help secure Gemini API access against abuse; for hackathon use it can be deferred, but it should be listed as a post-MVP hardening item. ([Firebase][23])

## NFR-5: Maintainability

The codebase shall use feature-first modules:

```text
lib/
  app/
  features/
    capture/
    gemini/
    lessons/
    srs/
    settings/
    speech/
  data/
    database/
    models/
  shared/
```

## NFR-6: Demoability

The project shall be demonstrable in under 2 minutes.

Required demo path:

1. Open app.
2. Start passive learning.
3. Point camera at an object/action.
4. Generate Japanese lesson.
5. Play TTS.
6. Save card.
7. Review card.
8. Grade card.

---

# 7. Data Model

## 7.1 `learning_cards`

```text
id TEXT PRIMARY KEY
scene_label TEXT NOT NULL
english TEXT NOT NULL
japanese TEXT NOT NULL
reading TEXT NOT NULL
grammar_note TEXT NOT NULL
target_level TEXT NOT NULL
source TEXT NOT NULL
created_at INTEGER NOT NULL
due_at INTEGER NOT NULL
interval_days INTEGER NOT NULL
ease REAL NOT NULL
repetitions INTEGER NOT NULL
lapses INTEGER NOT NULL
suspended INTEGER NOT NULL DEFAULT 0
```

## 7.2 `vocab_items`

```text
id TEXT PRIMARY KEY
card_id TEXT NOT NULL
japanese TEXT NOT NULL
reading TEXT NOT NULL
meaning TEXT NOT NULL
approx_jlpt TEXT NOT NULL
```

## 7.3 `review_events`

```text
id TEXT PRIMARY KEY
card_id TEXT NOT NULL
reviewed_at INTEGER NOT NULL
grade TEXT NOT NULL
previous_due_at INTEGER NOT NULL
next_due_at INTEGER NOT NULL
previous_interval_days INTEGER NOT NULL
next_interval_days INTEGER NOT NULL
previous_ease REAL NOT NULL
next_ease REAL NOT NULL
```

## 7.4 `settings`

```text
key TEXT PRIMARY KEY
value TEXT NOT NULL
updated_at INTEGER NOT NULL
```

## 7.5 `recent_generation_cache`

```text
id TEXT PRIMARY KEY
scene_label TEXT NOT NULL
primary_vocab TEXT NOT NULL
created_at INTEGER NOT NULL
expires_at INTEGER NOT NULL
```

---

# 8. Gemini Prompt Contract

Use a system prompt plus structured schema. The prompt should be short because the schema does most of the enforcement.

```text
You are an ambient Japanese language tutor.

Analyze the camera image. Select exactly one useful object, action, or scene that is visible and appropriate for a language learner.

Target language: Japanese.
Target level: {JLPT_LEVEL}.

Rules:
- Return one useful learning item only.
- Prefer ordinary daily-life phrases.
- Use natural Japanese.
- Include kana reading.
- Keep the grammar note under 20 words.
- Avoid rare vocabulary unless the image clearly requires it.
- Do not invent objects or actions not visible in the image.
```

The response schema should be enforced through Firebase AI Logic structured output rather than merely asking for “JSON only.” Firebase’s structured-output documentation states that response schemas act as a blueprint for model responses and reduce post-processing. ([Firebase][7])

---

# 9. SRS Algorithm

Use a simplified SM-2-like algorithm.

Initial card:

```text
ease = 2.5
intervalDays = 0
repetitions = 0
lapses = 0
dueAt = now
```

Review behavior:

| Grade | Behavior                                                         |
| ----- | ---------------------------------------------------------------- |
| Again | due in 10 minutes, repetitions reset, ease decreases             |
| Hard  | due in 1 day or interval × 1.2, ease decreases                   |
| Good  | normal progression: 1 day, 3 days, then interval × ease          |
| Easy  | longer progression: 3 days initially, then interval × ease × 1.3 |

Acceptance criteria:

* Due dates update deterministically.
* Review events are logged.
* Ease is clamped between `1.30` and `3.00`.
* A card graded `Again` is not lost; it remains active and due soon.

---

# 10. Implementation Best Practices

## 10.1 Camera

Use `takePicture()` for the MVP instead of image stream processing. This is slower than raw image buffers but simpler, less error-prone, and adequate for a 10-second sampling interval. Flutter’s cookbook documents the standard flow: add camera dependencies, get available cameras, initialize `CameraController`, show `CameraPreview`, and take a picture with `CameraController`. ([Flutter Documentation][24])

Do not keep images after Gemini processing unless a debug mode is explicitly enabled.

## 10.2 Gemini

Use `FirebaseAI.googleAI()` or the current Firebase AI Logic Flutter initialization path generated by FlutterFire.

Use `generationConfig` with:

```text
responseMimeType: application/json
responseSchema: TutorResult schema
temperature: 0.3–0.6
```

Use `gemini-2.5-flash`, not `gemini-flash-latest`, because stable model IDs are safer for demos and reproducibility. ([Google AI for Developers][4])

## 10.3 Database

Use Drift with generated tables and DAOs.

Use database access methods like:

```text
watchDueCards()
insertGeneratedCard()
recordReview()
updateCardSchedule()
getSettings()
setSetting()
```

Do not use `SharedPreferences` for cards. It is acceptable only for trivial settings.

## 10.4 JSON Models

Use `json_serializable` for Gemini response models. The package supports typed `fromJson` / `toJson` generation and schema generation, which is useful here because the Gemini response schema and Dart model should remain aligned. ([Dart packages][20])

## 10.5 State Management

Use Riverpod for app state:

```text
captureControllerProvider
geminiTutorServiceProvider
srsRepositoryProvider
dueCardsProvider
settingsProvider
ttsServiceProvider
```

Riverpod’s package page describes it as a reactive caching and data-binding framework with async-code support. ([Dart packages][14])

---

# 11. Revised Build Plan

## Hour 0–2: Foundation

Deliverables:

* Flutter project
* Firebase configured
* Camera permission
* Camera preview
* Start/stop button

## Hour 2–5: Gemini Loop

Deliverables:

* Capture still image
* Send to Gemini
* Parse structured output
* Display generated Japanese lesson

## Hour 5–7: TTS

Deliverables:

* Japanese TTS playback
* Mute toggle
* System audio routing

## Hour 7–11: SRS Persistence

Deliverables:

* Drift schema
* Card insert
* Due-card query
* Review screen

## Hour 11–15: Review Algorithm

Deliverables:

* Again / Hard / Good / Easy buttons
* Due date update
* Review event logging

## Hour 15–20: Polish

Deliverables:

* Deduplication cache
* Error states
* Loading states
* Settings
* Demo mode

## Hour 20–24: Stretch / Presentation

Deliverables:

* Ray-Ban Bluetooth audio demo
* Ray-Ban camera-source stub
* Native bridge attempt only if core app is already stable
* Final demo script built around: "We use Gemini 2.5 Flash through Firebase AI Logic, Google's official mobile SDK path for calling Gemini from Flutter."

Presentation emphasis:

* Use Gemini image understanding for camera frames.
* Use Gemini structured output for lesson JSON.
* Use Gemini to generate level-appropriate Japanese.
* Use Gemini to generate SRS card metadata.

---

# 12. Acceptance Criteria for Hackathon Submission

The submission is acceptable if:

1. The app runs on at least one real iOS or Android phone.
2. The user can start camera-based passive learning.
3. A captured image produces one Gemini-generated Japanese lesson.
4. The lesson includes Japanese, reading, English, and vocabulary.
5. The Japanese sentence is spoken aloud.
6. The lesson is saved as an SRS card.
7. The user can review and grade the card.
8. The app persists cards after restart.
9. The app does not require Ray-Ban camera access to function.
10. The codebase contains a clear `FrameSource` abstraction for future Ray-Ban support.

The strongest realistic demo is:

```text
Phone camera
→ Gemini 2.5 Flash via Firebase AI Logic
→ Structured lesson JSON
→ Level-appropriate Japanese lesson
→ SRS card metadata
→ TTS through phone or Ray-Ban Bluetooth audio
→ Drift-backed SRS review

That is the tightened implementation target.

[1]: https://developers.meta.com/blog/introducing-meta-wearables-device-access-toolkit/?utm_source=chatgpt.com "Introducing the Meta Wearables Device Access Toolkit"
[2]: https://blog.flutter.dev/whats-new-in-flutter-3-41-302ec140e632 "What’s new in Flutter 3.41. Empowering the community | by Kevin Chisholm | Flutter"
[3]: https://pub.dev/packages/camera/versions "camera package - All Versions"
[4]: https://ai.google.dev/gemini-api/docs/models "Models  |  Gemini API  |  Google AI for Developers"
[5]: https://firebase.google.com/docs/ai-logic/models "Learn about supported models  |  Firebase AI Logic"
[6]: https://docs.cloud.google.com/vertex-ai/generative-ai/docs/models/gemini/2-5-flash "Gemini 2.5 Flash  |  Generative AI on Vertex AI  |  Google Cloud Documentation"
[7]: https://firebase.google.com/docs/ai-logic/generate-structured-output "Generate structured output (like JSON and enums) using the Gemini API  |  Firebase AI Logic"
[8]: https://pub.dev/packages/hive_flutter/versions "hive_flutter package - All Versions"
[9]: https://drift.simonbinder.eu/platforms/ "Supported platforms"
[10]: https://pub.dev/packages/firebase_core/versions "firebase_core package - All Versions"
[11]: https://pub.dev/packages/firebase_ai/versions "firebase_ai package - All Versions"
[12]: https://pub.dev/packages/flutter_tts/versions "flutter_tts package - All Versions"
[13]: https://pub.dev/packages/permission_handler/versions "permission_handler package - All Versions"
[14]: https://pub.dev/packages/flutter_riverpod/versions "flutter_riverpod package - All Versions"
[15]: https://pub.dev/packages/drift/versions "drift package - All Versions"
[16]: https://pub.dev/packages/path_provider/versions "path_provider package - All Versions"
[17]: https://pub.dev/packages/path/versions?utm_source=chatgpt.com "path package - All Versions"
[18]: https://pub.dev/packages/uuid/versions "uuid package - All Versions"
[19]: https://pub.dev/packages/json_annotation/versions "json_annotation package - All Versions"
[20]: https://pub.dev/packages/json_serializable "json_serializable | Dart package"
[21]: https://pub.dev/packages/build_runner/versions?utm_source=chatgpt.com "build_runner package - All Versions"
[22]: https://pub.dev/packages/drift_dev/versions?utm_source=chatgpt.com "drift_dev package - All Versions"
[23]: https://firebase.google.com/docs/ai-logic/get-started "Get started with the Gemini API using the Firebase AI Logic SDKs  |  Firebase AI Logic"
[24]: https://docs.flutter.dev/cookbook/plugins/picture-using-camera?utm_source=chatgpt.com "Take a picture using the camera"
[25]: https://firebase.google.com/docs/ai-logic/analyze-images "Analyze image files using the Gemini API  |  Firebase AI Logic"
[26]: https://github.com/facebook/meta-wearables-dat-ios?utm_source=chatgpt.com "Meta Wearables Device Access Toolkit for iOS"
