import 'dart:async';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/app_providers.dart';
import '../../shared/jlpt_level.dart';
import '../lessons/lesson_card.dart';
import '../settings/settings_controller.dart';
import 'capture_controller.dart';
import 'frame_source.dart';
import 'phone_camera_frame_source.dart';
import 'ray_ban_frame_source.dart';

class CaptureScreen extends ConsumerWidget {
  const CaptureScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final capture = ref.watch(captureControllerProvider);
    final settings = ref.watch(settingsControllerProvider);
    final selectedSource = ref.watch(selectedCaptureSourceProvider);

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
                SegmentedButton<CaptureSource>(
                  segments: const [
                    ButtonSegment<CaptureSource>(
                      value: CaptureSource.phoneCamera,
                      icon: Icon(Icons.phone_android),
                      label: Text('Phone camera'),
                    ),
                    ButtonSegment<CaptureSource>(
                      value: CaptureSource.rayBan,
                      icon: Icon(Icons.visibility),
                      label: Text('Ray-Ban'),
                    ),
                  ],
                  selected: {selectedSource},
                  onSelectionChanged: capture.isRunning || capture.isGenerating
                      ? null
                      : (selection) {
                          if (selection.isEmpty) {
                            return;
                          }
                          ref
                              .read(selectedCaptureSourceProvider.notifier)
                              .setSource(selection.first);
                        },
                ),
                const SizedBox(height: 12),
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
                      label: Text(
                        capture.isRunning
                            ? 'Stop Ambient Learning'
                            : 'Start Ambient Learning',
                      ),
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
    return switch (ref.watch(selectedCaptureSourceProvider)) {
      CaptureSource.phoneCamera => const _PhoneCameraPreviewPanel(
        key: ValueKey(CaptureSource.phoneCamera),
      ),
      CaptureSource.rayBan => const _RayBanPreviewPanel(
        key: ValueKey(CaptureSource.rayBan),
      ),
    };
  }
}

class _PhoneCameraPreviewPanel extends ConsumerStatefulWidget {
  const _PhoneCameraPreviewPanel({super.key});

  @override
  ConsumerState<_PhoneCameraPreviewPanel> createState() =>
      _PhoneCameraPreviewPanelState();
}

class _PhoneCameraPreviewPanelState
    extends ConsumerState<_PhoneCameraPreviewPanel>
    with WidgetsBindingObserver {
  PhoneCameraFrameSource? _phoneCameraFrameSource;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _phoneCameraFrameSource = ref.read(phoneCameraFrameSourceProvider);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
    final phoneCamera = ref.watch(phoneCameraFrameSourceProvider);
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
            child: ListenableBuilder(
              listenable: phoneCamera,
              builder: (context, _) {
                final controller = phoneCamera.controller;
                if (controller != null && controller.value.isInitialized) {
                  return CameraPreview(controller);
                }

                return _CameraPlaceholder(
                  color: placeholderColor,
                  icon: Icons.camera_alt_outlined,
                  isPreparing: phoneCamera.isPreparingPreview,
                  message:
                      phoneCamera.previewMessage ??
                      'Press Start Ambient Learning to open the camera.',
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

class _RayBanPreviewPanel extends ConsumerStatefulWidget {
  const _RayBanPreviewPanel({super.key});

  @override
  ConsumerState<_RayBanPreviewPanel> createState() =>
      _RayBanPreviewPanelState();
}

class _RayBanPreviewPanelState extends ConsumerState<_RayBanPreviewPanel> {
  RayBanFrameSource? _rayBanFrameSource;

  @override
  void initState() {
    super.initState();
    final frameSource = ref.read(rayBanFrameSourceProvider);
    _rayBanFrameSource = frameSource;
    frameSource.attachPreview();
  }

  @override
  void dispose() {
    final frameSource = _rayBanFrameSource;
    if (frameSource != null) {
      unawaited(frameSource.detachPreview());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rayBan = ref.watch(rayBanFrameSourceProvider);
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
            child: ListenableBuilder(
              listenable: rayBan,
              builder: (context, _) {
                final previewFrame = rayBan.previewFrame;
                if (previewFrame != null) {
                  return _ImagePreview(
                    bytes: previewFrame.bytes,
                    semanticLabel: 'Ray-Ban preview frame',
                  );
                }

                return _CameraPlaceholder(
                  color: placeholderColor,
                  icon: Icons.visibility,
                  isPreparing: rayBan.isPreparingPreview,
                  message: rayBan.previewMessage,
                  retryLabel: 'Refresh',
                  onRetry: rayBan.canRetryPreview
                      ? () {
                          unawaited(rayBan.retryPreview());
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
    required this.icon,
    this.isPreparing = false,
    this.message,
    this.retryLabel = 'Retry',
    this.onRetry,
    this.onOpenSettings,
  });

  final Color color;
  final IconData icon;
  final bool isPreparing;
  final String? message;
  final String retryLabel;
  final VoidCallback? onRetry;
  final VoidCallback? onOpenSettings;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      Icon(
        icon,
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

class _ImagePreview extends StatelessWidget {
  const _ImagePreview({required this.bytes, required this.semanticLabel});

  final Uint8List bytes;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: Image.memory(
        bytes,
        fit: BoxFit.cover,
        gaplessPlayback: true,
        semanticLabel: semanticLabel,
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
