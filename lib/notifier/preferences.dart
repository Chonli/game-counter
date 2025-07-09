import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:score_counter/data/repositories/preferences.dart';
import 'package:score_counter/model/preferences.dart';

part 'preferences.g.dart';

@riverpod
class PreferencesNotifier extends _$PreferencesNotifier {
  @override
  Preferences build() {
    final repo = ref.read(preferencesRepositoryProvider);

    return repo.getPreferences();
  }

  void setThemeMode(ThemeMode themeMode) {
    final repo = ref.read(preferencesRepositoryProvider);
    final preferences = state.copyWith(themeMode: themeMode);

    repo.setPreferences(preferences);
    state = preferences;
  }

  void setLanguage(String language) {
    final repo = ref.read(preferencesRepositoryProvider);
    final preferences = state.copyWith(language: language);

    repo.setPreferences(preferences);
    state = preferences;
  }
}
