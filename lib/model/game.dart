import 'package:dart_mappable/dart_mappable.dart';
import 'package:score_counter/data/entities/game.dart';
import 'package:score_counter/model/player.dart';
import 'package:score_counter/model/round.dart';

part 'game.mapper.dart';

@MappableClass()
class Game with GameMappable {
  int id;
  String name;
  DateTime createDate;
  int? maxScoreByRound;
  int? maxScore;
  int? maxRounds;
  List<Player> players;
  List<Round> rounds;

  Game({
    required this.id,
    required this.name,
    required this.createDate,
    this.maxScoreByRound,
    this.maxScore,
    this.maxRounds,
    this.players = const [],
    this.rounds = const [],
  });
}

extension GameExtension on Game {
  GameEntity toEntity() {
    final game = GameEntity(
      id: id,
      name: name,
      createDate: createDate,
      maxScoreByRound: maxScoreByRound,
      maxScore: maxScore,
      maxRounds: maxRounds,
    );

    game.players.addAll(players.map((e) => e.toEntity()));
    game.rounds.addAll(rounds.map((e) => e.toEntity()));

    return game;
  }

  void updatePlayerScore() {
    for (final player in players) {
      player.totalScore = rounds.fold(0, (previousValue, element) {
        return previousValue + (element.playerByScores[player.id] ?? 0);
      });
    }
  }

  bool get hasReachedMaxScore {
    final safeMaxScore = maxScore;
    if (safeMaxScore == null) {
      return false;
    }

    return players.any((p) => p.totalScore >= safeMaxScore);
  }

  bool get hasReachedMaxRounds {
    final safeMaxRounds = maxRounds;
    if (safeMaxRounds == null) {
      return false;
    }

    return rounds.length >= safeMaxRounds;
  }

  bool get hasMaxScoreByRound => maxScoreByRound != null;
}
