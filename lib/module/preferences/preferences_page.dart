import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:score_counter/core/theme/app_spacing.dart';
import 'package:score_counter/core/theme/styles.dart';
import 'package:score_counter/core/widgets/app_gap.dart';
import 'package:score_counter/l10n/l10n.dart';
import 'package:score_counter/notifier/preferences.dart';
import 'package:score_counter/services/package_info.dart';
import 'package:score_counter/services/url_launcher.dart';

class PreferencesPage extends ConsumerWidget {
  const PreferencesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final preferences = ref.watch(preferencesNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.preferences_title)),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: ListView(
          children: [
            Wrap(
              spacing: AppSpacing.sm,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(l10n.preferences_theme, style: AppStyles.subtitle),
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
            AppGap.lg,
            Wrap(
              spacing: AppSpacing.sm,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(l10n.preferences_language, style: AppStyles.subtitle),
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
            AppGap.lg,
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                child: Text(l10n.preferences_about, style: AppStyles.subtitle),
                onPressed: () {
                  final packageInfo = ref.read(packageInfoProvider);

                  showAboutDialog(
                    context: context,
                    applicationName: l10n.home_title,
                    applicationIcon: Image.asset(
                      'assets/launcher_icon/icon.png',
                      width: 42,
                      height: 42,
                    ),
                    applicationLegalese: 'MIT',
                    applicationVersion: '${packageInfo.fullVersion}',
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.all(5)),
                      Text(
                        l10n.about_dev,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(5)),
                      TextButton(
                        onPressed:
                            () => ref
                                .read(urlLauncherProvider)
                                .launch(
                                  'https://github.com/Chonli/game-counter',
                                ),
                        child: Text(
                          l10n.about_project_link,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
