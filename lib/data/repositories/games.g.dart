// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'games.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(gamesRepository)
const gamesRepositoryProvider = GamesRepositoryProvider._();

final class GamesRepositoryProvider
    extends
        $FunctionalProvider<GamesRepository, GamesRepository, GamesRepository>
    with $Provider<GamesRepository> {
  const GamesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gamesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gamesRepositoryHash();

  @$internal
  @override
  $ProviderElement<GamesRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GamesRepository create(Ref ref) {
    return gamesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GamesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GamesRepository>(value),
    );
  }
}

String _$gamesRepositoryHash() => r'66f96d0f669bb67fee6fc216c2f95e9daa427a93';
