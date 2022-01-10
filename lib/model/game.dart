import 'package:hive/hive.dart';

part 'game.g.dart';

@HiveType(typeId: 1)
class Game {
  Game({
    required this.name,
    required this.numberPalyer,
    required this.date,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  int numberPalyer;

  @HiveField(2)
  DateTime date;
}
