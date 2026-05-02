import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/app_providers.dart';
import '../../data/database/app_database.dart';
import '../../shared/clock.dart';

final dueCardsProvider = StreamProvider<List<LearningCard>>((ref) {
  return ref.watch(srsRepositoryProvider).watchDueCards(systemNow());
});

final cardVocabularyProvider =
    FutureProvider.family<List<StoredVocabItem>, String>((ref, cardId) {
      return ref.watch(srsRepositoryProvider).getVocabularyForCard(cardId);
    });
