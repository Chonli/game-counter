import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:score_counter/model/preferences.dart';

class PreferencesEntity extends HiveObject {
  final String themeMode;
  final String language;

  PreferencesEntity({this.themeMode = 'system', this.language = 'en'});
}

extension PreferencesEntityExtension on PreferencesEntity {
  Preferences toModel() {
    return Preferences(
      themeMode: ThemeMode.values.byName(themeMode),
      language: language,
    );
  }
}
