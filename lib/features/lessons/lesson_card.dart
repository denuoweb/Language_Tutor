import 'package:flutter/material.dart';

import '../../data/models/tutor_result.dart';
import '../../shared/proficiency_level.dart';
import '../../shared/target_language.dart';

class LessonCard extends StatelessWidget {
  const LessonCard({
    required this.lesson,
    required this.language,
    required this.level,
    super.key,
  });

  final TutorResult lesson;
  final TargetLanguage language;
  final ProficiencyLevel level;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(label: Text(language.label)),
                Chip(label: Text(level.label)),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              lesson.targetText,
              textDirection: language.isRightToLeft
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(lesson.pronunciation, style: theme.textTheme.bodyLarge),
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
                      '${vocab.targetText} · ${vocab.pronunciation} · ${vocab.meaning}',
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
