import 'package:objectbox/objectbox.dart';
import 'package:score_counter/data/entities/player.dart';
import 'package:score_counter/data/entities/round.dart';
import 'package:score_counter/model/game.dart';

@Entity()
class GameEntity {
  @Id()
  int id;
  String name;
  @Property(type: PropertyType.date)
  DateTime createDate;
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
    );
  }
}
