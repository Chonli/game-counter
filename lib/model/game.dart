import 'package:dart_mappable/dart_mappable.dart';
import 'package:score_counter/data/entities/game.dart';
import 'package:score_counter/model/game_options.dart';
import 'package:score_counter/model/player.dart';
import 'package:score_counter/model/round.dart';

part 'game.mapper.dart';

@MappableClass()
class Game with GameMappable {
  final int id;
  final String name;
  final DateTime createDate;
  final GameOptions gameOptions;
  final List<Player> players;
  final List<Round> rounds;

  Game({
    required this.id,
    required this.name,
    required this.createDate,
    required this.gameOptions,
    this.players = const [],
    this.rounds = const [],
  });
}

extension GameExtension on Game {
  GameEntity toEntity() {
    final game = GameEntity(id: id, name: name, createDate: createDate);

    game.players.addAll(players.map((e) => e.toEntity()));
    game.rounds.addAll(rounds.map((e) => e.toEntity()));
    game.gameOptions.target = gameOptions.toEntity();

    return game;
  }

  bool get hasReachedMaxScore {
    final safeMaxScore = gameOptions.maxScore;
    if (safeMaxScore == null) {
      return false;
    }

    return players.any((p) => p.totalScore >= safeMaxScore);
  }

  bool get hasReachedMaxRounds {
    final safeMaxRounds = gameOptions.maxRounds;
    if (safeMaxRounds == null) {
      return false;
    }

    return rounds.length >= safeMaxRounds;
  }

  bool get hasMaxScoreByRound => gameOptions.maxScoreByRound != null;
}
