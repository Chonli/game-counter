import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'preferences.mapper.dart';

@MappableClass()
class Preferences with PreferencesMappable {
  final ThemeMode themeMode;
  final String language;

  Preferences({this.themeMode = ThemeMode.system, this.language = 'en'});
}
