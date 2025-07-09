import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:objectbox/objectbox.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:score_counter/core/database.dart';
import 'package:score_counter/data/entities/preferences.dart';
import 'package:score_counter/model/preferences.dart';

part 'preferences_dao.g.dart';

@riverpod
PreferencesDao preferencesDao(Ref ref) {
  final db = ref.watch(databaseProvider);
  final box = db.box<PreferencesEntity>();

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

  void setPreferences(Preferences preferences) {
    final preference = PreferencesEntity(
      id: _boxId,
      themeMode: preferences.themeMode.name,
      language: preferences.language,
    );

    box.put(preference);
  }
}
