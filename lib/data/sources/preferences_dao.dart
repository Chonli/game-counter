import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:score_counter/data/entities/preferences.dart';
import 'package:score_counter/model/preferences.dart';

part 'preferences_dao.g.dart';

@riverpod
PreferencesDao preferencesDao(Ref ref) {
  final box = Hive.box<PreferencesEntity>('preferences');

  return PreferencesDao(box);
}

class PreferencesDao {
  PreferencesDao(this.box);

  @visibleForTesting
  final Box<PreferencesEntity> box;

  static const _boxId = 1;

  Preferences getPreferences() =>
      getPreferencesEntity()?.toModel() ?? Preferences();

  @visibleForTesting
  PreferencesEntity? getPreferencesEntity() => box.get(_boxId);

  Future<void> setPreferences(Preferences preferences) {
    final preference = PreferencesEntity(
      themeMode: preferences.themeMode.name,
      language: preferences.language,
    );

    return box.put(_boxId, preference);
  }
}
