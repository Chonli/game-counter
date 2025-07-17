// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentGameHash() => r'd8f79ea9ac1926834f14c0c6ac49bdefd19c9f05';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$CurrentGame extends BuildlessAutoDisposeAsyncNotifier<Game?> {
  late final int gameId;

  FutureOr<Game?> build(int gameId);
}

/// See also [CurrentGame].
@ProviderFor(CurrentGame)
const currentGameProvider = CurrentGameFamily();

/// See also [CurrentGame].
class CurrentGameFamily extends Family<AsyncValue<Game?>> {
  /// See also [CurrentGame].
  const CurrentGameFamily();

  /// See also [CurrentGame].
  CurrentGameProvider call(int gameId) {
    return CurrentGameProvider(gameId);
  }

  @override
  CurrentGameProvider getProviderOverride(
    covariant CurrentGameProvider provider,
  ) {
    return call(provider.gameId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'currentGameProvider';
}

/// See also [CurrentGame].
class CurrentGameProvider
    extends AutoDisposeAsyncNotifierProviderImpl<CurrentGame, Game?> {
  /// See also [CurrentGame].
  CurrentGameProvider(int gameId)
    : this._internal(
        () => CurrentGame()..gameId = gameId,
        from: currentGameProvider,
        name: r'currentGameProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$currentGameHash,
        dependencies: CurrentGameFamily._dependencies,
        allTransitiveDependencies: CurrentGameFamily._allTransitiveDependencies,
        gameId: gameId,
      );

  CurrentGameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.gameId,
  }) : super.internal();

  final int gameId;

  @override
  FutureOr<Game?> runNotifierBuild(covariant CurrentGame notifier) {
    return notifier.build(gameId);
  }

  @override
  Override overrideWith(CurrentGame Function() create) {
    return ProviderOverride(
      origin: this,
      override: CurrentGameProvider._internal(
        () => create()..gameId = gameId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        gameId: gameId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CurrentGame, Game?> createElement() {
    return _CurrentGameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentGameProvider && other.gameId == gameId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, gameId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CurrentGameRef on AutoDisposeAsyncNotifierProviderRef<Game?> {
  /// The parameter `gameId` of this provider.
  int get gameId;
}

class _CurrentGameProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CurrentGame, Game?>
    with CurrentGameRef {
  _CurrentGameProviderElement(super.provider);

  @override
  int get gameId => (origin as CurrentGameProvider).gameId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
