import 'package:dart_mappable/dart_mappable.dart';
import 'package:score_counter/data/entities/round.dart';

part 'round.mapper.dart';

@MappableClass() // no need to set caseStyle here
class Round with RoundMappable {
  Round({required this.id, required this.index, required this.playerByScores});

  final int id;
  final int index;
  final Map<int, int> playerByScores;
}

extension RoundExtension on Round {
  RoundEntity toEntity() {
    return RoundEntity(id: id, index: index, playerByScores: playerByScores);
  }

  int restScoreForThisRounds(int maxScoreByRound) =>
      maxScoreByRound - playerByScores.values.reduce((a, b) => a + b);
}
