import 'package:objectbox/objectbox.dart';
import 'package:score_counter/model/round.dart';

@Entity()
class RoundEntity {
  @Id()
  int id;
  int index;
  Map<int, int> playerByScores;

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
