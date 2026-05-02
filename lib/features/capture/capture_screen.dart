import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/app_providers.dart';
import '../../shared/jlpt_level.dart';
import '../lessons/lesson_card.dart';
import '../settings/settings_controller.dart';
import 'capture_controller.dart';
import 'phone_camera_frame_source.dart';

class CaptureScreen extends ConsumerWidget {
  const CaptureScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final capture = ref.watch(captureControllerProvider);
    final settings = ref.watch(settingsControllerProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _CameraPreviewPanel(),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: settings.when(
                        data: (value) => DropdownButtonFormField<JlptLevel>(
                          initialValue: value.level,
                          decoration: const InputDecoration(
                            labelText: 'Level',
                            border: OutlineInputBorder(),
                          ),
                          items: [
                            for (final level in JlptLevel.values)
                              DropdownMenuItem(
                                value: level,
                                child: Text(level.label),
                              ),
                          ],
                          onChanged: capture.isRunning
                              ? null
                              : (level) {
                                  if (level != null) {
                                    ref
                                        .read(
                                          settingsControllerProvider.notifier,
                                        )
                                        .setLevel(level);
                                  }
                                },
                        ),
                        loading: () => const LinearProgressIndicator(),
                        error: (error, _) => Text(error.toString()),
                      ),
                    ),
                    const SizedBox(width: 12),
                    FilledButton.icon(
                      onPressed: capture.isGenerating
                          ? null
                          : () {
                              final controller = ref.read(
                                captureControllerProvider.notifier,
                              );
                              if (capture.isRunning) {
                                controller.stop();
                              } else {
                                controller.start();
                              }
                            },
                      icon: Icon(
                        capture.isRunning ? Icons.stop : Icons.play_arrow,
                      ),
                      label: Text(capture.isRunning ? 'Stop' : 'Start'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                settings.maybeWhen(
                  data: (value) => SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Mute TTS'),
                    value: value.ttsMuted,
                    onChanged: (muted) => ref
                        .read(settingsControllerProvider.notifier)
                        .setTtsMuted(muted),
                  ),
                  orElse: () => const SizedBox.shrink(),
                ),
                if (capture.isGenerating) ...[
                  const SizedBox(height: 8),
                  const LinearProgressIndicator(),
                ],
                if (capture.errorMessage != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    capture.errorMessage!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (capture.currentLesson != null)
          LessonCard(lesson: capture.currentLesson!)
        else
          const _EmptyLessonPanel(),
      ],
    );
  }
}

class _CameraPreviewPanel extends ConsumerWidget {
  const _CameraPreviewPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final frameSource = ref.watch(frameSourceProvider);
    final controller = frameSource is PhoneCameraFrameSource
        ? frameSource.controller
        : null;
    final placeholderColor = Theme.of(
      context,
    ).colorScheme.surfaceContainerHighest;

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = (constraints.maxWidth * 0.72).clamp(220.0, 360.0);
        return SizedBox(
          height: height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: controller != null && controller.value.isInitialized
                ? CameraPreview(controller)
                : DecoratedBox(
                    decoration: BoxDecoration(color: placeholderColor),
                    child: const Center(
                      child: Icon(Icons.camera_alt_outlined, size: 44),
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class _EmptyLessonPanel extends StatelessWidget {
  const _EmptyLessonPanel();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 180,
        child: Center(
          child: Text(
            'No lesson yet',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}
