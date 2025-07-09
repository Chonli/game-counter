import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:score_counter/data/sources/preferences_dao.dart';
import 'package:score_counter/model/preferences.dart';

part 'preferences.g.dart';

@riverpod
PreferencesRepository preferencesRepository(Ref ref) {
  final dao = ref.watch(preferencesDaoProvider);

  return PreferencesRepository(dao);
}

class PreferencesRepository {
  final PreferencesDao _dao;

  PreferencesRepository(this._dao);

  Preferences getPreferences() => _dao.getPreferences();

  void setPreferences(Preferences preferences) =>
      _dao.setPreferences(preferences);
}
