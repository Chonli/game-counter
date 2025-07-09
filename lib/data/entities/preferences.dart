import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:score_counter/model/preferences.dart';

@Entity()
class PreferencesEntity {
  @Id(assignable: true)
  int id;
  final String themeMode;
  final String language;

  PreferencesEntity({
    required this.id,
    this.themeMode = 'system',
    this.language = 'en',
  });
}

extension PreferencesEntityExtension on PreferencesEntity {
  Preferences toModel() {
    return Preferences(
      themeMode: ThemeMode.values.byName(themeMode),
      language: language,
    );
  }
}
