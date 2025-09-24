import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:score_counter/data/entities/hive_registrar.g.dart';
import 'package:score_counter/data/entities/preferences.dart';
import 'package:score_counter/data/sources/preferences_dao.dart';
import 'package:score_counter/model/preferences.dart';

void main() {
  group('PreferencesDao', () {
    late PreferencesDao preferencesDao;
    late Box<PreferencesEntity> box;

    setUpAll(() {
      // Initialize the test database
      Hive
        ..init('${Directory.current.path}/test')
        ..registerAdapters();
    });

    tearDownAll(() async {
      await Hive.deleteBoxFromDisk('test-pref');
    });

    setUp(() async {
      box = await Hive.openBox<PreferencesEntity>('test-pref');

      // Initialize the GamesDao with the test database
      preferencesDao = PreferencesDao(box);
    });

    tearDown(() async {
      await box.clear();
      await box.close();
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

    test('getPreferences should return Preferences from entity', () async {
      final pref = Preferences(themeMode: ThemeMode.dark, language: 'fr');

      await preferencesDao.setPreferences(pref);

      final preferences = preferencesDao.getPreferences();

      expect(preferences, isA<Preferences>());
      expect(preferences.themeMode, pref.themeMode);
      expect(preferences.language, pref.language);
    });

    test(
      'getPreferencesEntity should return Preferences from entity and id always equals 1',
      () async {
        final pref = Preferences(themeMode: ThemeMode.dark, language: 'fr');

        await preferencesDao.setPreferences(pref);

        var prefEntity = preferencesDao.getPreferencesEntity();

        expect(prefEntity, isA<PreferencesEntity>());
        expect(prefEntity?.themeMode, pref.themeMode.name);
        expect(prefEntity?.language, pref.language);

        final pref2 = Preferences(themeMode: ThemeMode.system, language: 'es');

        await preferencesDao.setPreferences(pref2);

        prefEntity = preferencesDao.getPreferencesEntity();

        expect(prefEntity, isA<PreferencesEntity>());
        expect(prefEntity?.themeMode, pref2.themeMode.name);
        expect(prefEntity?.language, pref2.language);
      },
    );
  });
}
