import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../gemini/firebase_bootstrap.dart';
import 'app_settings.dart';
import 'settings_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    return settings.when(
      data: (value) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Capture interval',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Slider(
                    min: AppSettings.minCaptureInterval.inSeconds.toDouble(),
                    max: 60,
                    divisions: 11,
                    value: value.captureInterval.inSeconds.toDouble(),
                    label: '${value.captureInterval.inSeconds}s',
                    onChanged: (seconds) => ref
                        .read(settingsControllerProvider.notifier)
                        .setCaptureInterval(Duration(seconds: seconds.round())),
                  ),
                  Text('${value.captureInterval.inSeconds} seconds'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: SwitchListTile(
              title: const Text('Mute TTS'),
              value: value.ttsMuted,
              onChanged: (muted) => ref
                  .read(settingsControllerProvider.notifier)
                  .setTtsMuted(muted),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              title: const Text('Firebase AI Logic'),
              subtitle: Text(
                FirebaseBootstrap.liveGeminiEnabled
                    ? 'Live Gemini on mobile'
                    : 'Demo Gemini fallback',
              ),
            ),
          ),
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text(error.toString())),
    );
  }
}
