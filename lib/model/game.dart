import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:score_counter/data/entities/game.dart';
import 'package:score_counter/model/game_options.dart';
import 'package:score_counter/model/player.dart';
import 'package:score_counter/model/round.dart';

part 'game.mapper.dart';

@MappableClass()
class Game with GameMappable {
  final String id;
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
    final game = GameEntity(
      id: id,
      name: name,
      createDate: createDate,
      gameOptions: gameOptions.toEntity(),
      players: players.map((e) => e.toEntity()).toList(),
      rounds: rounds.map((e) => e.toEntity()).toList(),
    );

    return game;
  }

  bool get hasReachedMaxScore {
    if (gameOptions.maxScore case final int maxScore) {
      return players.any((p) => p.totalScore >= maxScore);
    }

    return false;
  }

  bool get hasReachedMaxRounds {
    if (gameOptions.maxRounds case final int safeMaxRounds) {
      return rounds.length >= safeMaxRounds;
    }

    return false;
  }

  bool get hasMaxScoreByRound => gameOptions.maxScoreByRound != null;

  Player? getPlayer(String id) {
    return players.firstWhereOrNull((p) => p.id == id);
  }

  Player? get playerWithMaxScore {
    return players.fold(
      null,
      (a, b) => a != null && a.totalScore > b.totalScore ? a : b,
    );
  }

  Round? getRound(String id) {
    return rounds.firstWhereOrNull((p) => p.id == id);
  }
}
