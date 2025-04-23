// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'round.dart';

class RoundMapper extends ClassMapperBase<Round> {
  RoundMapper._();

  static RoundMapper? _instance;
  static RoundMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RoundMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Round';

  static int _$id(Round v) => v.id;
  static const Field<Round, int> _f$id = Field('id', _$id);
  static int _$index(Round v) => v.index;
  static const Field<Round, int> _f$index = Field('index', _$index);
  static Map<int, int> _$playerByScores(Round v) => v.playerByScores;
  static const Field<Round, Map<int, int>> _f$playerByScores =
      Field('playerByScores', _$playerByScores);

  @override
  final MappableFields<Round> fields = const {
    #id: _f$id,
    #index: _f$index,
    #playerByScores: _f$playerByScores,
  };

  static Round _instantiate(DecodingData data) {
    return Round(
        id: data.dec(_f$id),
        index: data.dec(_f$index),
        playerByScores: data.dec(_f$playerByScores));
  }

  @override
  final Function instantiate = _instantiate;

  static Round fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Round>(map);
  }

  static Round fromJson(String json) {
    return ensureInitialized().decodeJson<Round>(json);
  }
}

mixin RoundMappable {
  String toJson() {
    return RoundMapper.ensureInitialized().encodeJson<Round>(this as Round);
  }

  Map<String, dynamic> toMap() {
    return RoundMapper.ensureInitialized().encodeMap<Round>(this as Round);
  }

  RoundCopyWith<Round, Round, Round> get copyWith =>
      _RoundCopyWithImpl<Round, Round>(this as Round, $identity, $identity);
  @override
  String toString() {
    return RoundMapper.ensureInitialized().stringifyValue(this as Round);
  }

  @override
  bool operator ==(Object other) {
    return RoundMapper.ensureInitialized().equalsValue(this as Round, other);
  }

  @override
  int get hashCode {
    return RoundMapper.ensureInitialized().hashValue(this as Round);
  }
}

extension RoundValueCopy<$R, $Out> on ObjectCopyWith<$R, Round, $Out> {
  RoundCopyWith<$R, Round, $Out> get $asRound =>
      $base.as((v, t, t2) => _RoundCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class RoundCopyWith<$R, $In extends Round, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, int, int, ObjectCopyWith<$R, int, int>> get playerByScores;
  $R call({int? id, int? index, Map<int, int>? playerByScores});
  RoundCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _RoundCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Round, $Out>
    implements RoundCopyWith<$R, Round, $Out> {
  _RoundCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Round> $mapper = RoundMapper.ensureInitialized();
  @override
  MapCopyWith<$R, int, int, ObjectCopyWith<$R, int, int>> get playerByScores =>
      MapCopyWith(
          $value.playerByScores,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(playerByScores: v));
  @override
  $R call({int? id, int? index, Map<int, int>? playerByScores}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (index != null) #index: index,
        if (playerByScores != null) #playerByScores: playerByScores
      }));
  @override
  Round $make(CopyWithData data) => Round(
      id: data.get(#id, or: $value.id),
      index: data.get(#index, or: $value.index),
      playerByScores: data.get(#playerByScores, or: $value.playerByScores));

  @override
  RoundCopyWith<$R2, Round, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _RoundCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
