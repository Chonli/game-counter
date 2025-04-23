// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'player.dart';

class PlayerMapper extends ClassMapperBase<Player> {
  PlayerMapper._();

  static PlayerMapper? _instance;
  static PlayerMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PlayerMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Player';

  static String _$name(Player v) => v.name;
  static const Field<Player, String> _f$name = Field('name', _$name);
  static Color _$color(Player v) => v.color;
  static const Field<Player, Color> _f$color = Field('color', _$color);
  static int _$score(Player v) => v.score;
  static const Field<Player, int> _f$score =
      Field('score', _$score, opt: true, def: 0);

  @override
  final MappableFields<Player> fields = const {
    #name: _f$name,
    #color: _f$color,
    #score: _f$score,
  };

  static Player _instantiate(DecodingData data) {
    return Player(
        name: data.dec(_f$name),
        color: data.dec(_f$color),
        score: data.dec(_f$score));
  }

  @override
  final Function instantiate = _instantiate;

  static Player fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Player>(map);
  }

  static Player fromJson(String json) {
    return ensureInitialized().decodeJson<Player>(json);
  }
}

mixin PlayerMappable {
  String toJson() {
    return PlayerMapper.ensureInitialized().encodeJson<Player>(this as Player);
  }

  Map<String, dynamic> toMap() {
    return PlayerMapper.ensureInitialized().encodeMap<Player>(this as Player);
  }

  PlayerCopyWith<Player, Player, Player> get copyWith =>
      _PlayerCopyWithImpl<Player, Player>(this as Player, $identity, $identity);
  @override
  String toString() {
    return PlayerMapper.ensureInitialized().stringifyValue(this as Player);
  }

  @override
  bool operator ==(Object other) {
    return PlayerMapper.ensureInitialized().equalsValue(this as Player, other);
  }

  @override
  int get hashCode {
    return PlayerMapper.ensureInitialized().hashValue(this as Player);
  }
}

extension PlayerValueCopy<$R, $Out> on ObjectCopyWith<$R, Player, $Out> {
  PlayerCopyWith<$R, Player, $Out> get $asPlayer =>
      $base.as((v, t, t2) => _PlayerCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PlayerCopyWith<$R, $In extends Player, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, Color? color, int? score});
  PlayerCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PlayerCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Player, $Out>
    implements PlayerCopyWith<$R, Player, $Out> {
  _PlayerCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Player> $mapper = PlayerMapper.ensureInitialized();
  @override
  $R call({String? name, Color? color, int? score}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (color != null) #color: color,
        if (score != null) #score: score
      }));
  @override
  Player $make(CopyWithData data) => Player(
      name: data.get(#name, or: $value.name),
      color: data.get(#color, or: $value.color),
      score: data.get(#score, or: $value.score));

  @override
  PlayerCopyWith<$R2, Player, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PlayerCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
