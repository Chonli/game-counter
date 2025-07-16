import 'package:dart_mappable/dart_mappable.dart';
import 'package:score_counter/data/entities/game_options.dart';

part 'game_options.mapper.dart';

@MappableClass()
class GameOptions with GameOptionsMappable {
  final int? maxScoreByRound;
  final int? maxScore;
  final int? maxRounds;
  GameOptions({this.maxScoreByRound, this.maxScore, this.maxRounds});
}

extension GameOptionsEntityExtension on GameOptions {
  GameOptionsEntity toEntity() {
    return GameOptionsEntity(
      maxScoreByRound: maxScoreByRound,
      maxScore: maxScore,
      maxRounds: maxRounds,
    );
  }
}
