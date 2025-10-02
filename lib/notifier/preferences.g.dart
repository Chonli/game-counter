// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PrefManager)
const prefManagerProvider = PrefManagerProvider._();

final class PrefManagerProvider
    extends $NotifierProvider<PrefManager, Preferences> {
  const PrefManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'prefManagerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$prefManagerHash();

  @$internal
  @override
  PrefManager create() => PrefManager();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Preferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Preferences>(value),
    );
  }
}

String _$prefManagerHash() => r'225a90188669fbb140fcac4c5f6a670349c8c1e7';

abstract class _$PrefManager extends $Notifier<Preferences> {
  Preferences build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Preferences, Preferences>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Preferences, Preferences>,
              Preferences,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
