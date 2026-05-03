import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/target_language.dart';
import 'due_cards_provider.dart';
import 'review_controller.dart';
import 'review_grade.dart';

class ReviewScreen extends ConsumerWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dueCards = ref.watch(dueCardsProvider);
    final review = ref.watch(reviewControllerProvider);

    return dueCards.when(
      data: (cards) {
        if (cards.isEmpty) {
          return const Center(child: Text('No cards due'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: cards.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final card = cards[index];
            final revealed = review.isRevealed(card.id);
            final language = TargetLanguage.fromCode(card.targetLanguage);
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
                        Chip(label: Text(card.targetLevel)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      card.targetText,
                      textDirection: language.isRightToLeft
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    if (revealed) ...[
                      const SizedBox(height: 8),
                      Text(card.pronunciation),
                      const SizedBox(height: 8),
                      Text(card.english),
                      const SizedBox(height: 8),
                      Text(card.grammarNote),
                      const SizedBox(height: 8),
                      _VocabularyLine(cardId: card.id),
                    ],
                    const SizedBox(height: 16),
                    if (!revealed)
                      OutlinedButton.icon(
                        onPressed: () => ref
                            .read(reviewControllerProvider.notifier)
                            .reveal(card.id),
                        icon: const Icon(Icons.visibility_outlined),
                        label: const Text('Reveal'),
                      )
                    else
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final grade in ReviewGrade.values)
                            FilledButton.tonal(
                              onPressed: review.isRecording
                                  ? null
                                  : () => ref
                                        .read(reviewControllerProvider.notifier)
                                        .grade(card.id, grade),
                              child: Text(grade.label),
                            ),
                        ],
                      ),
                    if (review.errorMessage != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        review.errorMessage!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text(error.toString())),
    );
  }
}

class _VocabularyLine extends ConsumerWidget {
  const _VocabularyLine({required this.cardId});

  final String cardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vocab = ref.watch(cardVocabularyProvider(cardId));
    return vocab.maybeWhen(
      data: (items) => Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final item in items)
            Chip(
              label: Text(
                '${item.targetText} · ${item.pronunciation} · ${item.meaning}',
              ),
            ),
        ],
      ),
      orElse: () => const SizedBox.shrink(),
    );
  }
}
