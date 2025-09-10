import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:score_counter/model/round.dart';

class RoundEntity extends HiveObject {
  String id;
  int index;
  Map<String, int> playerByScores;

  RoundEntity({
    required this.id,
    required this.index,
    this.playerByScores = const <String, int>{},
  });
}

extension RoundEntityExtension on RoundEntity {
  Round toModel() {
    return Round(id: id, index: index, playerByScores: playerByScores);
  }
}
