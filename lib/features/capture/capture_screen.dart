import 'dart:async';

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

class _CameraPreviewPanel extends ConsumerStatefulWidget {
  const _CameraPreviewPanel();

  @override
  ConsumerState<_CameraPreviewPanel> createState() =>
      _CameraPreviewPanelState();
}

class _CameraPreviewPanelState extends ConsumerState<_CameraPreviewPanel>
    with WidgetsBindingObserver {
  PhoneCameraFrameSource? _phoneCameraFrameSource;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    final frameSource = ref.read(frameSourceProvider);
    if (frameSource is PhoneCameraFrameSource) {
      _phoneCameraFrameSource = frameSource;
      frameSource.attachPreview();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    final frameSource = _phoneCameraFrameSource;
    if (frameSource != null) {
      unawaited(frameSource.detachPreview());
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final frameSource = _phoneCameraFrameSource;
    if (frameSource != null) {
      unawaited(frameSource.handleAppLifecycleState(state));
    }
  }

  @override
  Widget build(BuildContext context) {
    final frameSource = ref.watch(frameSourceProvider);
    final phoneCamera = frameSource is PhoneCameraFrameSource
        ? frameSource
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
            child: phoneCamera == null
                ? _CameraPlaceholder(color: placeholderColor)
                : ListenableBuilder(
                    listenable: phoneCamera,
                    builder: (context, _) {
                      final controller = phoneCamera.controller;
                      if (controller != null &&
                          controller.value.isInitialized) {
                        return CameraPreview(controller);
                      }

                      return _CameraPlaceholder(
                        color: placeholderColor,
                        isPreparing: phoneCamera.isPreparingPreview,
                        message: phoneCamera.previewMessage,
                        retryLabel: phoneCamera.canRequestPermission
                            ? 'Allow camera'
                            : 'Retry',
                        onRetry: phoneCamera.canRetryPreview
                            ? () {
                                unawaited(
                                  phoneCamera.retryPreview(
                                    requestPermission:
                                        phoneCamera.canRequestPermission,
                                  ),
                                );
                              }
                            : null,
                        onOpenSettings: phoneCamera.canOpenPermissionSettings
                            ? () {
                                unawaited(phoneCamera.openPermissionSettings());
                              }
                            : null,
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}

class _CameraPlaceholder extends StatelessWidget {
  const _CameraPlaceholder({
    required this.color,
    this.isPreparing = false,
    this.message,
    this.retryLabel = 'Retry',
    this.onRetry,
    this.onOpenSettings,
  });

  final Color color;
  final bool isPreparing;
  final String? message;
  final String retryLabel;
  final VoidCallback? onRetry;
  final VoidCallback? onOpenSettings;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      Icon(
        Icons.camera_alt_outlined,
        size: 44,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    ];

    if (isPreparing) {
      children.addAll([
        const SizedBox(height: 12),
        const SizedBox(
          width: 28,
          height: 28,
          child: CircularProgressIndicator(strokeWidth: 2.5),
        ),
        const SizedBox(height: 12),
        const Text('Preparing camera...'),
      ]);
    } else if (message != null) {
      children.addAll([
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 280),
          child: Text(
            message!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ]);

      if (onRetry != null || onOpenSettings != null) {
        children.add(const SizedBox(height: 12));
        children.add(
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              if (onRetry != null)
                OutlinedButton(onPressed: onRetry, child: Text(retryLabel)),
              if (onOpenSettings != null)
                FilledButton(
                  onPressed: onOpenSettings,
                  child: const Text('Open settings'),
                ),
            ],
          ),
        );
      }
    }

    return DecoratedBox(
      decoration: BoxDecoration(color: color),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisSize: MainAxisSize.min, children: children),
        ),
      ),
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
