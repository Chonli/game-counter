import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:score_counter/l10n/l10n.dart';

class PreferencesPage extends ConsumerWidget {
  const PreferencesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.preferences_title)),
      body: ListView(
        children: [
          ListTile(
            title: Text(l10n.preferences_theme),
            trailing: SegmentedButton<ThemeMode>(
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
              selected: const <ThemeMode>{ThemeMode.light},
            ),
          ),
          ListTile(
            title: Text(l10n.preferences_language),
            trailing: SegmentedButton<String>(
              segments: <ButtonSegment<String>>[
                ButtonSegment<String>(
                  value: l10n.lang_english,
                  label: Text(l10n.lang_english),
                ),
                ButtonSegment<String>(
                  value: l10n.lang_french,
                  label: Text(l10n.lang_french),
                ),
              ],
              selected: <String>{l10n.lang_english},
            ),
          ),
        ],
      ),
    );
  }
}
