// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'games.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Games)
const gamesProvider = GamesProvider._();

final class GamesProvider extends $NotifierProvider<Games, List<Game>> {
  const GamesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gamesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gamesHash();

  @$internal
  @override
  Games create() => Games();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Game> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Game>>(value),
    );
  }
}

String _$gamesHash() => r'c71f4714121a7471c1ead49281fa2657924cf77b';

abstract class _$Games extends $Notifier<List<Game>> {
  List<Game> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<Game>, List<Game>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Game>, List<Game>>,
              List<Game>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
