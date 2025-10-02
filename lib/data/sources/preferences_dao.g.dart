// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences_dao.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(preferencesDao)
const preferencesDaoProvider = PreferencesDaoProvider._();

final class PreferencesDaoProvider
    extends $FunctionalProvider<PreferencesDao, PreferencesDao, PreferencesDao>
    with $Provider<PreferencesDao> {
  const PreferencesDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'preferencesDaoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$preferencesDaoHash();

  @$internal
  @override
  $ProviderElement<PreferencesDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PreferencesDao create(Ref ref) {
    return preferencesDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PreferencesDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PreferencesDao>(value),
    );
  }
}

String _$preferencesDaoHash() => r'4faf6bd35386767879fb6cb0781555d7b71ed684';
