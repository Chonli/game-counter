// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_round_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentRoundHash() => r'd82f743abe023b02179a916cc43bd61c35f0010b';

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

abstract class _$CurrentRound extends BuildlessAutoDisposeNotifier<Round> {
  late final Round round;

  Round build(Round round);
}

/// See also [_CurrentRound].
@ProviderFor(_CurrentRound)
const _currentRoundProvider = _CurrentRoundFamily();

/// See also [_CurrentRound].
class _CurrentRoundFamily extends Family<Round> {
  /// See also [_CurrentRound].
  const _CurrentRoundFamily();

  /// See also [_CurrentRound].
  _CurrentRoundProvider call(Round round) {
    return _CurrentRoundProvider(round);
  }

  @override
  _CurrentRoundProvider getProviderOverride(
    covariant _CurrentRoundProvider provider,
  ) {
    return call(provider.round);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_currentRoundProvider';
}

/// See also [_CurrentRound].
class _CurrentRoundProvider
    extends AutoDisposeNotifierProviderImpl<_CurrentRound, Round> {
  /// See also [_CurrentRound].
  _CurrentRoundProvider(Round round)
    : this._internal(
        () => _CurrentRound()..round = round,
        from: _currentRoundProvider,
        name: r'_currentRoundProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$currentRoundHash,
        dependencies: _CurrentRoundFamily._dependencies,
        allTransitiveDependencies:
            _CurrentRoundFamily._allTransitiveDependencies,
        round: round,
      );

  _CurrentRoundProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.round,
  }) : super.internal();

  final Round round;

  @override
  Round runNotifierBuild(covariant _CurrentRound notifier) {
    return notifier.build(round);
  }

  @override
  Override overrideWith(_CurrentRound Function() create) {
    return ProviderOverride(
      origin: this,
      override: _CurrentRoundProvider._internal(
        () => create()..round = round,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        round: round,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<_CurrentRound, Round> createElement() {
    return _CurrentRoundProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _CurrentRoundProvider && other.round == round;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, round.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin _CurrentRoundRef on AutoDisposeNotifierProviderRef<Round> {
  /// The parameter `round` of this provider.
  Round get round;
}

class _CurrentRoundProviderElement
    extends AutoDisposeNotifierProviderElement<_CurrentRound, Round>
    with _CurrentRoundRef {
  _CurrentRoundProviderElement(super.provider);

  @override
  Round get round => (origin as _CurrentRoundProvider).round;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
