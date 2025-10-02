// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentGame)
const currentGameProvider = CurrentGameFamily._();

final class CurrentGameProvider extends $NotifierProvider<CurrentGame, Game?> {
  const CurrentGameProvider._({
    required CurrentGameFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'currentGameProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$currentGameHash();

  @override
  String toString() {
    return r'currentGameProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CurrentGame create() => CurrentGame();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Game? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Game?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentGameProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$currentGameHash() => r'399f0813a7a5c0c03bbc0e678d4c6f77769e529c';

final class CurrentGameFamily extends $Family
    with $ClassFamilyOverride<CurrentGame, Game?, Game?, Game?, String> {
  const CurrentGameFamily._()
    : super(
        retry: null,
        name: r'currentGameProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CurrentGameProvider call(String gameId) =>
      CurrentGameProvider._(argument: gameId, from: this);

  @override
  String toString() => r'currentGameProvider';
}

abstract class _$CurrentGame extends $Notifier<Game?> {
  late final _$args = ref.$arg as String;
  String get gameId => _$args;

  Game? build(String gameId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<Game?, Game?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Game?, Game?>,
              Game?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
