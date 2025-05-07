import 'dart:convert';

import 'package:objectbox/objectbox.dart';
import 'package:score_counter/model/round.dart';

@Entity()
class RoundEntity {
  @Id()
  int id;
  int index;
  @Transient()
  Map<int, int> playerByScores;

  String? get dbSavePlayerByScores =>
      jsonEncode(playerByScores.map((k, v) => MapEntry(k.toString(), v)));

  set dbSavePlayerByScores(String? value) {
    if (value == null) {
      playerByScores = {};
    } else {
      playerByScores = Map.from(
        json.decode(value).map((k, v) => MapEntry(int.parse(k), v as int)),
      );
    }
  }

  RoundEntity({
    this.id = 0,
    required this.index,
    this.playerByScores = const <int, int>{},
  });
}

extension RoundEntityExtension on RoundEntity {
  Round toModel() {
    return Round(id: id, index: index, playerByScores: playerByScores);
  }
}
