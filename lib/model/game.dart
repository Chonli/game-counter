import 'package:game_counter/model/player.dart';
import 'package:hive/hive.dart';

part 'game.g.dart';

@HiveType(typeId: 1)
class Game {
  Game({
    required this.name,
    required this.players,
    required this.date,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  List<Player> players;

  @HiveField(2)
  DateTime date;

  int get numberPalyer => players.length;
}
