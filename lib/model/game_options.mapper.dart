// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'game_options.dart';

class GameOptionsMapper extends ClassMapperBase<GameOptions> {
  GameOptionsMapper._();

  static GameOptionsMapper? _instance;
  static GameOptionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameOptionsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'GameOptions';

  static int? _$maxScoreByRound(GameOptions v) => v.maxScoreByRound;
  static const Field<GameOptions, int> _f$maxScoreByRound =
      Field('maxScoreByRound', _$maxScoreByRound, opt: true);
  static int? _$maxScore(GameOptions v) => v.maxScore;
  static const Field<GameOptions, int> _f$maxScore =
      Field('maxScore', _$maxScore, opt: true);
  static int? _$maxRounds(GameOptions v) => v.maxRounds;
  static const Field<GameOptions, int> _f$maxRounds =
      Field('maxRounds', _$maxRounds, opt: true);

  @override
  final MappableFields<GameOptions> fields = const {
    #maxScoreByRound: _f$maxScoreByRound,
    #maxScore: _f$maxScore,
    #maxRounds: _f$maxRounds,
  };

  static GameOptions _instantiate(DecodingData data) {
    return GameOptions(
        maxScoreByRound: data.dec(_f$maxScoreByRound),
        maxScore: data.dec(_f$maxScore),
        maxRounds: data.dec(_f$maxRounds));
  }

  @override
  final Function instantiate = _instantiate;

  static GameOptions fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameOptions>(map);
  }

  static GameOptions fromJson(String json) {
    return ensureInitialized().decodeJson<GameOptions>(json);
  }
}

mixin GameOptionsMappable {
  String toJson() {
    return GameOptionsMapper.ensureInitialized()
        .encodeJson<GameOptions>(this as GameOptions);
  }

  Map<String, dynamic> toMap() {
    return GameOptionsMapper.ensureInitialized()
        .encodeMap<GameOptions>(this as GameOptions);
  }

  GameOptionsCopyWith<GameOptions, GameOptions, GameOptions> get copyWith =>
      _GameOptionsCopyWithImpl<GameOptions, GameOptions>(
          this as GameOptions, $identity, $identity);
  @override
  String toString() {
    return GameOptionsMapper.ensureInitialized()
        .stringifyValue(this as GameOptions);
  }

  @override
  bool operator ==(Object other) {
    return GameOptionsMapper.ensureInitialized()
        .equalsValue(this as GameOptions, other);
  }

  @override
  int get hashCode {
    return GameOptionsMapper.ensureInitialized().hashValue(this as GameOptions);
  }
}

extension GameOptionsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GameOptions, $Out> {
  GameOptionsCopyWith<$R, GameOptions, $Out> get $asGameOptions =>
      $base.as((v, t, t2) => _GameOptionsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class GameOptionsCopyWith<$R, $In extends GameOptions, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? maxScoreByRound, int? maxScore, int? maxRounds});
  GameOptionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GameOptionsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameOptions, $Out>
    implements GameOptionsCopyWith<$R, GameOptions, $Out> {
  _GameOptionsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameOptions> $mapper =
      GameOptionsMapper.ensureInitialized();
  @override
  $R call(
          {Object? maxScoreByRound = $none,
          Object? maxScore = $none,
          Object? maxRounds = $none}) =>
      $apply(FieldCopyWithData({
        if (maxScoreByRound != $none) #maxScoreByRound: maxScoreByRound,
        if (maxScore != $none) #maxScore: maxScore,
        if (maxRounds != $none) #maxRounds: maxRounds
      }));
  @override
  GameOptions $make(CopyWithData data) => GameOptions(
      maxScoreByRound: data.get(#maxScoreByRound, or: $value.maxScoreByRound),
      maxScore: data.get(#maxScore, or: $value.maxScore),
      maxRounds: data.get(#maxRounds, or: $value.maxRounds));

  @override
  GameOptionsCopyWith<$R2, GameOptions, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GameOptionsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
