import 'package:game_counter/model/score.dart';
import 'package:hive/hive.dart';

part 'player.g.dart';

@HiveType(typeId: 2)
class Player {
  Player({
    required this.name,
    required this.score,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  Score score;
}
