// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'games.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Games)
final gamesProvider = GamesProvider._();

final class GamesProvider extends $NotifierProvider<Games, List<Game>> {
  GamesProvider._()
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

String _$gamesHash() => r'a5dfe049347ca1e3016dacbdee7dd0b06453250e';

abstract class _$Games extends $Notifier<List<Game>> {
  List<Game> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<Game>, List<Game>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Game>, List<Game>>,
              List<Game>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
