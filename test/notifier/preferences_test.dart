import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:score_counter/data/repositories/preferences.dart';
import 'package:score_counter/model/preferences.dart';
import 'package:score_counter/notifier/preferences.dart';

import '../common/container.dart';
import '../common/mock.dart';

void main() {
  late ProviderContainer container;
  late MockPreferencesRepository mockRepo;

  setUpAll(() {
    registerFallbackValue(Preferences());
  });

  setUp(() {
    mockRepo = MockPreferencesRepository();
    container = createContainer(
      overrides: [preferencesRepositoryProvider.overrideWithValue(mockRepo)],
    );

    when(() => mockRepo.setPreferences(any())).thenAnswer((_) async {});
  });

  group('PreferencesNotifier', () {
    test('read a new preference init value', () async {
      when(() => mockRepo.getPreferences()).thenAnswer((_) => Preferences());

      final notifier = container.read(preferencesNotifierProvider);

      expect(notifier.language, 'en');
      expect(notifier.themeMode, ThemeMode.system);
    });
  });

  test('setThemeMode updates theme and persists', () {
    final initialPrefs = Preferences(
      themeMode: ThemeMode.light,
      language: 'en',
    );
    when(() => mockRepo.getPreferences()).thenReturn(initialPrefs);

    final notifier = container.read(preferencesNotifierProvider.notifier);
    notifier.setThemeMode(ThemeMode.dark);

    final updated = container.read(preferencesNotifierProvider);

    expect(updated.themeMode, ThemeMode.dark);
    expect(updated.language, 'en');
    verify(() => mockRepo.setPreferences(updated)).called(1);
  });

  test('setLanguage updates language and persists', () {
    final initialPrefs = Preferences(
      themeMode: ThemeMode.light,
      language: 'en',
    );
    when(() => mockRepo.getPreferences()).thenReturn(initialPrefs);

    final notifier = container.read(preferencesNotifierProvider.notifier);
    notifier.setLanguage('fr');

    final updated = container.read(preferencesNotifierProvider);

    expect(updated.language, 'fr');
    expect(updated.themeMode, ThemeMode.light);
    verify(() => mockRepo.setPreferences(updated)).called(1);
  });
}
