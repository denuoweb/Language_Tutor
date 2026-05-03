enum ProficiencyLevel {
  beginner(
    'Beginner',
    'Use a short, concrete sentence with high-frequency vocabulary.',
  ),
  elementary(
    'Elementary',
    'Use simple daily-life phrasing with one small grammatical step beyond the basics.',
  ),
  intermediate(
    'Intermediate',
    'Use natural everyday language with moderate grammar variety and more specific vocabulary.',
  ),
  upperIntermediate(
    'Upper Intermediate',
    'Use more precise wording and richer sentence structure while staying practical.',
  ),
  advanced(
    'Advanced',
    'Use nuanced or structurally complex language that still clearly matches the image.',
  );

  const ProficiencyLevel(this.label, this.promptGuidance);

  static const schemaValues = <String>[
    'Beginner',
    'Elementary',
    'Intermediate',
    'Upper Intermediate',
    'Advanced',
    'unknown',
  ];

  final String label;
  final String promptGuidance;

  static ProficiencyLevel fromLabel(String value) {
    switch (value.trim().toLowerCase()) {
      case 'beginner':
      case 'n5':
        return ProficiencyLevel.beginner;
      case 'elementary':
      case 'n4':
        return ProficiencyLevel.elementary;
      case 'intermediate':
      case 'n3':
        return ProficiencyLevel.intermediate;
      case 'upper intermediate':
      case 'upper_intermediate':
      case 'n2':
        return ProficiencyLevel.upperIntermediate;
      case 'advanced':
      case 'n1':
        return ProficiencyLevel.advanced;
      default:
        return ProficiencyLevel.beginner;
    }
  }

  static String normalizeApproxLevel(String value) {
    final normalized = value.trim().toLowerCase();
    if (normalized.isEmpty || normalized == 'unknown') {
      return 'unknown';
    }

    switch (normalized) {
      case 'beginner':
      case 'n5':
        return ProficiencyLevel.beginner.label;
      case 'elementary':
      case 'n4':
        return ProficiencyLevel.elementary.label;
      case 'intermediate':
      case 'n3':
        return ProficiencyLevel.intermediate.label;
      case 'upper intermediate':
      case 'upper_intermediate':
      case 'n2':
        return ProficiencyLevel.upperIntermediate.label;
      case 'advanced':
      case 'n1':
        return ProficiencyLevel.advanced.label;
      default:
        return 'unknown';
    }
  }
}
