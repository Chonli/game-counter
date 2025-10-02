// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generator_utilities.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(generatorUtilities)
const generatorUtilitiesProvider = GeneratorUtilitiesProvider._();

final class GeneratorUtilitiesProvider
    extends
        $FunctionalProvider<
          GeneratorUtility,
          GeneratorUtility,
          GeneratorUtility
        >
    with $Provider<GeneratorUtility> {
  const GeneratorUtilitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'generatorUtilitiesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$generatorUtilitiesHash();

  @$internal
  @override
  $ProviderElement<GeneratorUtility> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GeneratorUtility create(Ref ref) {
    return generatorUtilities(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GeneratorUtility value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GeneratorUtility>(value),
    );
  }
}

String _$generatorUtilitiesHash() =>
    r'4e6102f1cf44ea90c27f05f55794cf59a65d1b31';
