import 'package:hive/hive.dart';

part 'score.g.dart';

@HiveType(typeId: 3)
class Score {
  Score({
    this.turns = const <int>[],
  });

  int get total => turns.reduce((a, b) => a + b);

  @HiveField(0)
  List<int> turns;
}
