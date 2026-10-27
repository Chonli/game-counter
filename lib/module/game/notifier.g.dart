// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentGame)
final currentGameProvider = CurrentGameFamily._();

final class CurrentGameProvider extends $NotifierProvider<CurrentGame, Game?> {
  CurrentGameProvider._({
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

String _$currentGameHash() => r'7b04d253ac2fcd421e4a604d97c85add7324cebd';

final class CurrentGameFamily extends $Family
    with $ClassFamilyOverride<CurrentGame, Game?, Game?, Game?, String> {
  CurrentGameFamily._()
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
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Game?, Game?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Game?, Game?>,
              Game?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
