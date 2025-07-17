import 'package:objectbox/objectbox.dart';
import 'package:score_counter/data/entities/game_options.dart';
import 'package:score_counter/data/entities/player.dart';
import 'package:score_counter/data/entities/round.dart';
import 'package:score_counter/model/game.dart';
import 'package:score_counter/model/game_options.dart';

@Entity()
class GameEntity {
  @Id(assignable: true)
  int id;
  String name;
  @Property(type: PropertyType.date)
  DateTime createDate;
  final gameOptions = ToOne<GameOptionsEntity>();
  final players = ToMany<PlayerEntity>();
  final rounds = ToMany<RoundEntity>();

  GameEntity({this.id = 0, required this.name, required this.createDate});
}

extension GameEntityExtension on GameEntity {
  Game toModel() {
    return Game(
      id: id,
      name: name,
      createDate: createDate,
      players: players.map((e) => e.toModel()).toList(),
      rounds: rounds.map((e) => e.toModel()).toList(),
      gameOptions: gameOptions.target?.toModel() ?? GameOptions(),
    );
  }
}
