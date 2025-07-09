import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:score_counter/data/entities/preferences.dart';
import 'package:score_counter/data/sources/preferences_dao.dart';
import 'package:score_counter/model/preferences.dart';
import 'package:score_counter/objectbox.g.dart';

void main() {
  group('PreferencesDao', () {
    late PreferencesDao preferencesDao;
    late Store db;

    setUp(() {
      db = Store(getObjectBoxModel(), directory: "memory:test-db");
      final box = db.box<PreferencesEntity>();

      // Initialize the GamesDao with the test database
      preferencesDao = PreferencesDao(box);
    });

    tearDown(() {
      preferencesDao.box.removeAll();
      db.close();
    });

    test(
      'getPreferences should return default Preferences if entity is null',
      () {
        final preferences = preferencesDao.getPreferences();

        expect(preferences, isA<Preferences>());
        expect(preferences.themeMode, ThemeMode.system);
        expect(preferences.language, 'en');
      },
    );

    test('getPreferences should return Preferences from entity', () {
      final pref = Preferences(themeMode: ThemeMode.dark, language: 'fr');

      preferencesDao.setPreferences(pref);

      final preferences = preferencesDao.getPreferences();

      expect(preferences, isA<Preferences>());
      expect(preferences.themeMode, pref.themeMode);
      expect(preferences.language, pref.language);
    });

    test(
      'getPreferencesEntity should return Preferences from entity and id always equals 1',
      () {
        final pref = Preferences(themeMode: ThemeMode.dark, language: 'fr');

        preferencesDao.setPreferences(pref);

        var prefEntity = preferencesDao.getPreferencesEntity();

        expect(prefEntity, isA<PreferencesEntity>());
        expect(prefEntity?.themeMode, pref.themeMode.name);
        expect(prefEntity?.language, pref.language);
        expect(prefEntity?.id, 1);

        final pref2 = Preferences(themeMode: ThemeMode.system, language: 'es');

        preferencesDao.setPreferences(pref2);

        prefEntity = preferencesDao.getPreferencesEntity();

        expect(prefEntity, isA<PreferencesEntity>());
        expect(prefEntity?.themeMode, pref2.themeMode.name);
        expect(prefEntity?.language, pref2.language);
        expect(prefEntity?.id, 1);
      },
    );
  });
}
