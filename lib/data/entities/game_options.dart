import 'package:objectbox/objectbox.dart';
import 'package:score_counter/model/game_options.dart';

@Entity()
class GameOptionsEntity {
  @Id(assignable: true)
  int id;
  int? maxScoreByRound;
  int? maxScore;
  int? maxRounds;

  GameOptionsEntity({
    this.id = 0,
    this.maxScoreByRound,
    this.maxScore,
    this.maxRounds,
  });
}

extension GameOptionsEntityExtension on GameOptionsEntity {
  GameOptions toModel() {
    return GameOptions(
      maxScoreByRound: maxScoreByRound,
      maxScore: maxScore,
      maxRounds: maxRounds,
    );
  }
}
