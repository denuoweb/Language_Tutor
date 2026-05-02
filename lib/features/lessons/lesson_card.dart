import 'package:flutter/material.dart';

import '../../data/models/tutor_result.dart';

class LessonCard extends StatelessWidget {
  const LessonCard({required this.lesson, super.key});

  final TutorResult lesson;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lesson.japanese,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(lesson.reading, style: theme.textTheme.bodyLarge),
            const SizedBox(height: 10),
            Text(lesson.english, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final vocab in lesson.keyVocabulary)
                  Chip(
                    label: Text(
                      '${vocab.japanese} · ${vocab.reading} · ${vocab.meaning}',
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(lesson.grammarNote, style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
