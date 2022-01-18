import 'package:game_counter/model/player.dart';
import 'package:hive/hive.dart';

part 'game.g.dart';

@HiveType(typeId: 1)
class Game {
  Game({
    required this.id,
    required this.name,
    required this.players,
    required this.date,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<Player> players;

  @HiveField(3)
  DateTime date;

  int get numberPalyer => players.length;

  int get numberTurn => players.first.score.turns.length;
}
