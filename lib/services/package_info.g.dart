// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_info.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(packageInfo)
const packageInfoProvider = PackageInfoProvider._();

final class PackageInfoProvider
    extends $FunctionalProvider<AppPackageInfo, AppPackageInfo, AppPackageInfo>
    with $Provider<AppPackageInfo> {
  const PackageInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'packageInfoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$packageInfoHash();

  @$internal
  @override
  $ProviderElement<AppPackageInfo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppPackageInfo create(Ref ref) {
    return packageInfo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppPackageInfo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppPackageInfo>(value),
    );
  }
}

String _$packageInfoHash() => r'7d3d66644bbe841350bb8441bb058f39ee35bca8';
