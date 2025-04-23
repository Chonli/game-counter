import 'package:objectbox/objectbox.dart';
import 'package:score_counter/data/entities/player.dart';
import 'package:score_counter/data/entities/round.dart';
import 'package:score_counter/model/game.dart';

@Entity()
class GameEntity {
  @Id()
  int id;
  String name;
  DateTime createDate;
  List<PlayerEntity> players;
  List<RoundEntity> rounds;

  GameEntity({
    this.id = 0,
    required this.name,
    required this.createDate,
    this.players = const [],
    this.rounds = const [],
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
    );
  }
}
