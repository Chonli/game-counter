import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score_counter/l10n/l10n.dart';

class PreferencesPage extends ConsumerWidget {
  const PreferencesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return Scaffold(
      //appBar: AppBar(title: Text(l10n.preferences_title)),
      body: ListView(
        children: [
          // ListTile(
          //   title: Text(l10n.theme),
          //   trailing: Switch(
          //     value: false,
          //     onChanged: (value) {
          //       // Handle theme change
          //     },
          //   ),
          // ),
          // ListTile(
          //   title: Text(l10n.language),
          //   trailing: DropdownButton<String>(
          //     value: 'en',
          //     items: const [
          //       DropdownMenuItem(value: 'en', child: Text('English')),
          //       DropdownMenuItem(value: 'fr', child: Text('Français')),
          //       // Add more languages as needed
          //     ],
          //     onChanged: (value) {
          //       // Handle language change
          //     },
          //   ),
          //),
          // Add more preference options as needed
        ],
      ),
    );
  }
}
