// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'game.dart';

class GameMapper extends ClassMapperBase<Game> {
  GameMapper._();

  static GameMapper? _instance;
  static GameMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameMapper._());
      GameOptionsMapper.ensureInitialized();
      PlayerMapper.ensureInitialized();
      RoundMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Game';

  static int _$id(Game v) => v.id;
  static const Field<Game, int> _f$id = Field('id', _$id);
  static String _$name(Game v) => v.name;
  static const Field<Game, String> _f$name = Field('name', _$name);
  static DateTime _$createDate(Game v) => v.createDate;
  static const Field<Game, DateTime> _f$createDate =
      Field('createDate', _$createDate);
  static GameOptions _$gameOptions(Game v) => v.gameOptions;
  static const Field<Game, GameOptions> _f$gameOptions =
      Field('gameOptions', _$gameOptions);
  static List<Player> _$players(Game v) => v.players;
  static const Field<Game, List<Player>> _f$players =
      Field('players', _$players, opt: true, def: const []);
  static List<Round> _$rounds(Game v) => v.rounds;
  static const Field<Game, List<Round>> _f$rounds =
      Field('rounds', _$rounds, opt: true, def: const []);

  @override
  final MappableFields<Game> fields = const {
    #id: _f$id,
    #name: _f$name,
    #createDate: _f$createDate,
    #gameOptions: _f$gameOptions,
    #players: _f$players,
    #rounds: _f$rounds,
  };

  static Game _instantiate(DecodingData data) {
    return Game(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        createDate: data.dec(_f$createDate),
        gameOptions: data.dec(_f$gameOptions),
        players: data.dec(_f$players),
        rounds: data.dec(_f$rounds));
  }

  @override
  final Function instantiate = _instantiate;

  static Game fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Game>(map);
  }

  static Game fromJson(String json) {
    return ensureInitialized().decodeJson<Game>(json);
  }
}

mixin GameMappable {
  String toJson() {
    return GameMapper.ensureInitialized().encodeJson<Game>(this as Game);
  }

  Map<String, dynamic> toMap() {
    return GameMapper.ensureInitialized().encodeMap<Game>(this as Game);
  }

  GameCopyWith<Game, Game, Game> get copyWith =>
      _GameCopyWithImpl<Game, Game>(this as Game, $identity, $identity);
  @override
  String toString() {
    return GameMapper.ensureInitialized().stringifyValue(this as Game);
  }

  @override
  bool operator ==(Object other) {
    return GameMapper.ensureInitialized().equalsValue(this as Game, other);
  }

  @override
  int get hashCode {
    return GameMapper.ensureInitialized().hashValue(this as Game);
  }
}

extension GameValueCopy<$R, $Out> on ObjectCopyWith<$R, Game, $Out> {
  GameCopyWith<$R, Game, $Out> get $asGame =>
      $base.as((v, t, t2) => _GameCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class GameCopyWith<$R, $In extends Game, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  GameOptionsCopyWith<$R, GameOptions, GameOptions> get gameOptions;
  ListCopyWith<$R, Player, PlayerCopyWith<$R, Player, Player>> get players;
  ListCopyWith<$R, Round, RoundCopyWith<$R, Round, Round>> get rounds;
  $R call(
      {int? id,
      String? name,
      DateTime? createDate,
      GameOptions? gameOptions,
      List<Player>? players,
      List<Round>? rounds});
  GameCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GameCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Game, $Out>
    implements GameCopyWith<$R, Game, $Out> {
  _GameCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Game> $mapper = GameMapper.ensureInitialized();
  @override
  GameOptionsCopyWith<$R, GameOptions, GameOptions> get gameOptions =>
      $value.gameOptions.copyWith.$chain((v) => call(gameOptions: v));
  @override
  ListCopyWith<$R, Player, PlayerCopyWith<$R, Player, Player>> get players =>
      ListCopyWith($value.players, (v, t) => v.copyWith.$chain(t),
          (v) => call(players: v));
  @override
  ListCopyWith<$R, Round, RoundCopyWith<$R, Round, Round>> get rounds =>
      ListCopyWith($value.rounds, (v, t) => v.copyWith.$chain(t),
          (v) => call(rounds: v));
  @override
  $R call(
          {int? id,
          String? name,
          DateTime? createDate,
          GameOptions? gameOptions,
          List<Player>? players,
          List<Round>? rounds}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (createDate != null) #createDate: createDate,
        if (gameOptions != null) #gameOptions: gameOptions,
        if (players != null) #players: players,
        if (rounds != null) #rounds: rounds
      }));
  @override
  Game $make(CopyWithData data) => Game(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      createDate: data.get(#createDate, or: $value.createDate),
      gameOptions: data.get(#gameOptions, or: $value.gameOptions),
      players: data.get(#players, or: $value.players),
      rounds: data.get(#rounds, or: $value.rounds));

  @override
  GameCopyWith<$R2, Game, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _GameCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
