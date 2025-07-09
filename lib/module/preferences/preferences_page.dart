import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:score_counter/l10n/l10n.dart';
import 'package:score_counter/notifier/preferences.dart';

class PreferencesPage extends ConsumerWidget {
  const PreferencesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final preferences = ref.watch(preferencesNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.preferences_title)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Wrap(
              spacing: 12,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(l10n.preferences_theme),
                SegmentedButton<ThemeMode>(
                  segments: <ButtonSegment<ThemeMode>>[
                    ButtonSegment<ThemeMode>(
                      value: ThemeMode.system,
                      label: Text(l10n.theme_mode_system),
                    ),
                    ButtonSegment<ThemeMode>(
                      value: ThemeMode.light,
                      label: Text(l10n.theme_mode_light),
                    ),
                    ButtonSegment<ThemeMode>(
                      value: ThemeMode.dark,
                      label: Text(l10n.theme_mode_dark),
                    ),
                  ],
                  selected: <ThemeMode>{preferences.themeMode},
                  onSelectionChanged: (selected) {
                    ref
                        .read(preferencesNotifierProvider.notifier)
                        .setThemeMode(selected.first);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(l10n.preferences_language),
                SegmentedButton<String>(
                  segments: <ButtonSegment<String>>[
                    ButtonSegment<String>(
                      value: 'en',
                      label: Text(l10n.lang_english),
                    ),
                    ButtonSegment<String>(
                      value: 'fr',
                      label: Text(l10n.lang_french),
                    ),
                  ],
                  selected: <String>{preferences.language},
                  onSelectionChanged: (selected) {
                    ref
                        .read(preferencesNotifierProvider.notifier)
                        .setLanguage(selected.first);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
