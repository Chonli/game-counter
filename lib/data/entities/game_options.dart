import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:score_counter/model/game_options.dart';

class GameOptionsEntity extends HiveObject {
  int? maxScoreByRound;
  int? maxScore;
  int? maxRounds;

  GameOptionsEntity({this.maxScoreByRound, this.maxScore, this.maxRounds});
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
