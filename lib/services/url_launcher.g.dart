// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_launcher.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(urlLauncher)
const urlLauncherProvider = UrlLauncherProvider._();

final class UrlLauncherProvider
    extends $FunctionalProvider<AppUrlLauncher, AppUrlLauncher, AppUrlLauncher>
    with $Provider<AppUrlLauncher> {
  const UrlLauncherProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'urlLauncherProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$urlLauncherHash();

  @$internal
  @override
  $ProviderElement<AppUrlLauncher> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppUrlLauncher create(Ref ref) {
    return urlLauncher(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppUrlLauncher value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppUrlLauncher>(value),
    );
  }
}

String _$urlLauncherHash() => r'cb183523688f2eda23f79026900af9b3dd4fc10f';
