// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'preferences.dart';

class PreferencesMapper extends ClassMapperBase<Preferences> {
  PreferencesMapper._();

  static PreferencesMapper? _instance;
  static PreferencesMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PreferencesMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Preferences';

  static ThemeMode _$themeMode(Preferences v) => v.themeMode;
  static const Field<Preferences, ThemeMode> _f$themeMode =
      Field('themeMode', _$themeMode, opt: true, def: ThemeMode.system);
  static String _$language(Preferences v) => v.language;
  static const Field<Preferences, String> _f$language =
      Field('language', _$language, opt: true, def: 'en');

  @override
  final MappableFields<Preferences> fields = const {
    #themeMode: _f$themeMode,
    #language: _f$language,
  };

  static Preferences _instantiate(DecodingData data) {
    return Preferences(
        themeMode: data.dec(_f$themeMode), language: data.dec(_f$language));
  }

  @override
  final Function instantiate = _instantiate;

  static Preferences fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Preferences>(map);
  }

  static Preferences fromJson(String json) {
    return ensureInitialized().decodeJson<Preferences>(json);
  }
}

mixin PreferencesMappable {
  String toJson() {
    return PreferencesMapper.ensureInitialized()
        .encodeJson<Preferences>(this as Preferences);
  }

  Map<String, dynamic> toMap() {
    return PreferencesMapper.ensureInitialized()
        .encodeMap<Preferences>(this as Preferences);
  }

  PreferencesCopyWith<Preferences, Preferences, Preferences> get copyWith =>
      _PreferencesCopyWithImpl<Preferences, Preferences>(
          this as Preferences, $identity, $identity);
  @override
  String toString() {
    return PreferencesMapper.ensureInitialized()
        .stringifyValue(this as Preferences);
  }

  @override
  bool operator ==(Object other) {
    return PreferencesMapper.ensureInitialized()
        .equalsValue(this as Preferences, other);
  }

  @override
  int get hashCode {
    return PreferencesMapper.ensureInitialized().hashValue(this as Preferences);
  }
}

extension PreferencesValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Preferences, $Out> {
  PreferencesCopyWith<$R, Preferences, $Out> get $asPreferences =>
      $base.as((v, t, t2) => _PreferencesCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PreferencesCopyWith<$R, $In extends Preferences, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({ThemeMode? themeMode, String? language});
  PreferencesCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PreferencesCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Preferences, $Out>
    implements PreferencesCopyWith<$R, Preferences, $Out> {
  _PreferencesCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Preferences> $mapper =
      PreferencesMapper.ensureInitialized();
  @override
  $R call({ThemeMode? themeMode, String? language}) =>
      $apply(FieldCopyWithData({
        if (themeMode != null) #themeMode: themeMode,
        if (language != null) #language: language
      }));
  @override
  Preferences $make(CopyWithData data) => Preferences(
      themeMode: data.get(#themeMode, or: $value.themeMode),
      language: data.get(#language, or: $value.language));

  @override
  PreferencesCopyWith<$R2, Preferences, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PreferencesCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
