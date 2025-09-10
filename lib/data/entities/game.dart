import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:score_counter/data/entities/game_options.dart';
import 'package:score_counter/data/entities/player.dart';
import 'package:score_counter/data/entities/round.dart';
import 'package:score_counter/model/game.dart';

class GameEntity extends HiveObject {
  String id;
  String name;
  DateTime createDate;
  GameOptionsEntity gameOptions;
  List<PlayerEntity> players;
  List<RoundEntity> rounds;

  GameEntity({
    required this.id,
    required this.name,
    required this.createDate,
    required this.gameOptions,
    required this.players,
    this.rounds = const <RoundEntity>[],
  });
}

extension GameEntityExtension on GameEntity {
  Game toModel() {
    return Game(
      id: id,
      name: name,
      createDate: createDate,
      players: players.map((e) => e.toModel()).toList(),
      rounds: rounds.map((e) => e.toModel()).toList(),
      gameOptions: gameOptions.toModel(),
    );
  }
}
