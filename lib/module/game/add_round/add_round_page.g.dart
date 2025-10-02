// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_round_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(_CurrentRound)
const _currentRoundProvider = _CurrentRoundFamily._();

final class _CurrentRoundProvider
    extends $NotifierProvider<_CurrentRound, Round> {
  const _CurrentRoundProvider._({
    required _CurrentRoundFamily super.from,
    required Round super.argument,
  }) : super(
         retry: null,
         name: r'_currentRoundProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$_currentRoundHash();

  @override
  String toString() {
    return r'_currentRoundProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  _CurrentRound create() => _CurrentRound();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Round value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Round>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _CurrentRoundProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$_currentRoundHash() => r'fcb48c0249549ce61c9138b55d02d85b6cc476f0';

final class _CurrentRoundFamily extends $Family
    with $ClassFamilyOverride<_CurrentRound, Round, Round, Round, Round> {
  const _CurrentRoundFamily._()
    : super(
        retry: null,
        name: r'_currentRoundProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _CurrentRoundProvider call(Round round) =>
      _CurrentRoundProvider._(argument: round, from: this);

  @override
  String toString() => r'_currentRoundProvider';
}

abstract class _$CurrentRound extends $Notifier<Round> {
  late final _$args = ref.$arg as Round;
  Round get round => _$args;

  Round build(Round round);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<Round, Round>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Round, Round>,
              Round,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
