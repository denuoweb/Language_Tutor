enum TargetLanguage {
  japanese(
    code: 'japanese',
    label: 'Japanese',
    endonym: '日本語',
    ttsLocale: 'ja-JP',
    lessonInstructions: 'Use natural Japanese script.',
    pronunciationInstructions: 'Provide the pronunciation in kana.',
    demoSentence: 'ここにノートがあります。',
    demoPronunciation: 'ここにノートがあります。',
    demoVocabulary: 'ノート',
    demoVocabularyPronunciation: 'ノート',
    demoMeaning: 'notebook',
  ),
  arabic(
    code: 'arabic',
    label: 'Arabic',
    endonym: 'العربية',
    ttsLocale: 'ar-SA',
    lessonInstructions: 'Use clear, natural Arabic script.',
    pronunciationInstructions:
        'Provide a concise Latin transliteration for pronunciation.',
    demoSentence: 'يوجد دفتر هنا.',
    demoPronunciation: 'yujadu daftarun huna.',
    demoVocabulary: 'دفتر',
    demoVocabularyPronunciation: 'daftar',
    demoMeaning: 'notebook',
    isRightToLeft: true,
  ),
  mandarinChinese(
    code: 'mandarin_chinese',
    label: 'Mandarin Chinese',
    endonym: '中文',
    ttsLocale: 'zh-CN',
    lessonInstructions: 'Use simplified Chinese characters.',
    pronunciationInstructions:
        'Provide pronunciation in pinyin with tone marks when possible.',
    demoSentence: '这里有一本笔记本。',
    demoPronunciation: 'zhèlǐ yǒu yì běn bǐjìběn.',
    demoVocabulary: '笔记本',
    demoVocabularyPronunciation: 'bǐjìběn',
    demoMeaning: 'notebook',
  ),
  korean(
    code: 'korean',
    label: 'Korean',
    endonym: '한국어',
    ttsLocale: 'ko-KR',
    lessonInstructions: 'Use natural Korean in Hangul.',
    pronunciationInstructions:
        'Provide a concise romanization for pronunciation.',
    demoSentence: '여기에 공책이 있어요.',
    demoPronunciation: 'yeogie gongchaegi isseoyo.',
    demoVocabulary: '공책',
    demoVocabularyPronunciation: 'gongchaek',
    demoMeaning: 'notebook',
  ),
  spanish(
    code: 'spanish',
    label: 'Spanish',
    endonym: 'Español',
    ttsLocale: 'es-ES',
    lessonInstructions: 'Use natural everyday Spanish.',
    pronunciationInstructions:
        'Provide a short pronunciation guide only if it helps.',
    demoSentence: 'Aquí hay un cuaderno.',
    demoPronunciation: 'Aquí hay un cuaderno.',
    demoVocabulary: 'cuaderno',
    demoVocabularyPronunciation: 'cuaderno',
    demoMeaning: 'notebook',
  ),
  french(
    code: 'french',
    label: 'French',
    endonym: 'Français',
    ttsLocale: 'fr-FR',
    lessonInstructions: 'Use natural everyday French.',
    pronunciationInstructions:
        'Provide a short pronunciation guide only if it helps.',
    demoSentence: 'Il y a un cahier ici.',
    demoPronunciation: 'Il y a un cahier ici.',
    demoVocabulary: 'cahier',
    demoVocabularyPronunciation: 'cahier',
    demoMeaning: 'notebook',
  ),
  german(
    code: 'german',
    label: 'German',
    endonym: 'Deutsch',
    ttsLocale: 'de-DE',
    lessonInstructions: 'Use natural everyday German.',
    pronunciationInstructions:
        'Provide a short pronunciation guide only if it helps.',
    demoSentence: 'Hier liegt ein Notizbuch.',
    demoPronunciation: 'Hier liegt ein Notizbuch.',
    demoVocabulary: 'Notizbuch',
    demoVocabularyPronunciation: 'Notizbuch',
    demoMeaning: 'notebook',
  ),
  italian(
    code: 'italian',
    label: 'Italian',
    endonym: 'Italiano',
    ttsLocale: 'it-IT',
    lessonInstructions: 'Use natural everyday Italian.',
    pronunciationInstructions:
        'Provide a short pronunciation guide only if it helps.',
    demoSentence: 'Qui c\'è un quaderno.',
    demoPronunciation: 'Qui c\'è un quaderno.',
    demoVocabulary: 'quaderno',
    demoVocabularyPronunciation: 'quaderno',
    demoMeaning: 'notebook',
  ),
  portuguese(
    code: 'portuguese',
    label: 'Portuguese',
    endonym: 'Português',
    ttsLocale: 'pt-PT',
    lessonInstructions: 'Use natural everyday Portuguese.',
    pronunciationInstructions:
        'Provide a short pronunciation guide only if it helps.',
    demoSentence: 'Há um caderno aqui.',
    demoPronunciation: 'Há um caderno aqui.',
    demoVocabulary: 'caderno',
    demoVocabularyPronunciation: 'caderno',
    demoMeaning: 'notebook',
  ),
  russian(
    code: 'russian',
    label: 'Russian',
    endonym: 'Русский',
    ttsLocale: 'ru-RU',
    lessonInstructions: 'Use natural Russian in Cyrillic.',
    pronunciationInstructions:
        'Provide a concise Latin transliteration for pronunciation.',
    demoSentence: 'Здесь есть блокнот.',
    demoPronunciation: 'Zdes yest bloknot.',
    demoVocabulary: 'блокнот',
    demoVocabularyPronunciation: 'bloknot',
    demoMeaning: 'notebook',
  );

  const TargetLanguage({
    required this.code,
    required this.label,
    required this.endonym,
    required this.ttsLocale,
    required this.lessonInstructions,
    required this.pronunciationInstructions,
    required this.demoSentence,
    required this.demoPronunciation,
    required this.demoVocabulary,
    required this.demoVocabularyPronunciation,
    required this.demoMeaning,
    this.isRightToLeft = false,
  });

  final String code;
  final String label;
  final String endonym;
  final String ttsLocale;
  final String lessonInstructions;
  final String pronunciationInstructions;
  final String demoSentence;
  final String demoPronunciation;
  final String demoVocabulary;
  final String demoVocabularyPronunciation;
  final String demoMeaning;
  final bool isRightToLeft;

  String get menuLabel => '$label ($endonym)';

  static TargetLanguage fromCode(String value) {
    final normalized = value.trim().toLowerCase();
    return TargetLanguage.values.firstWhere(
      (language) =>
          language.code == normalized ||
          language.label.toLowerCase() == normalized,
      orElse: () => TargetLanguage.japanese,
    );
  }
}
