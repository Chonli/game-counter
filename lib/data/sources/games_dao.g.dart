// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'games_dao.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(gamesDao)
const gamesDaoProvider = GamesDaoProvider._();

final class GamesDaoProvider
    extends $FunctionalProvider<GamesDao, GamesDao, GamesDao>
    with $Provider<GamesDao> {
  const GamesDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gamesDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gamesDaoHash();

  @$internal
  @override
  $ProviderElement<GamesDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GamesDao create(Ref ref) {
    return gamesDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GamesDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GamesDao>(value),
    );
  }
}

String _$gamesDaoHash() => r'517273a96b84ca50c28d9cd8cfd295fa8921cce3';
