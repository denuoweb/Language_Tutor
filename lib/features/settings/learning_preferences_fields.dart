import 'package:flutter/material.dart';

import '../../shared/proficiency_level.dart';
import '../../shared/target_language.dart';
import 'app_settings.dart';

class LearningPreferencesFields extends StatelessWidget {
  const LearningPreferencesFields({
    required this.settings,
    required this.enabled,
    required this.onLanguageChanged,
    required this.onLevelChanged,
    super.key,
  });

  final AppSettings settings;
  final bool enabled;
  final ValueChanged<TargetLanguage> onLanguageChanged;
  final ValueChanged<ProficiencyLevel> onLevelChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 640) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _languageField()),
              const SizedBox(width: 12),
              Expanded(child: _levelField()),
            ],
          );
        }

        return Column(
          children: [
            _languageField(),
            const SizedBox(height: 12),
            _levelField(),
          ],
        );
      },
    );
  }

  Widget _languageField() {
    return DropdownButtonFormField<TargetLanguage>(
      key: ValueKey(settings.language.code),
      initialValue: settings.language,
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: 'Language',
        border: OutlineInputBorder(),
      ),
      items: [
        for (final language in TargetLanguage.values)
          DropdownMenuItem(value: language, child: Text(language.menuLabel)),
      ],
      onChanged: enabled
          ? (language) {
              if (language != null) {
                onLanguageChanged(language);
              }
            }
          : null,
    );
  }

  Widget _levelField() {
    return DropdownButtonFormField<ProficiencyLevel>(
      key: ValueKey(settings.level.label),
      initialValue: settings.level,
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: 'Level',
        border: OutlineInputBorder(),
      ),
      items: [
        for (final level in ProficiencyLevel.values)
          DropdownMenuItem(value: level, child: Text(level.label)),
      ],
      onChanged: enabled
          ? (level) {
              if (level != null) {
                onLevelChanged(level);
              }
            }
          : null,
    );
  }
}
