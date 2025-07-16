import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:score_counter/model/game.dart';
import 'package:score_counter/model/game_options.dart';
import 'package:score_counter/model/player.dart';
import 'package:score_counter/model/round.dart';

void main() {
  group('GameExtension', () {
    late Game game;

    setUp(() {
      game = Game(
        id: 1,
        name: 'Test Game',
        createDate: DateTime.now(),
        gameOptions: GameOptions(
          maxScoreByRound: 10,
          maxScore: 50,
          maxRounds: 5,
        ),
        players: [
          Player(id: 1, name: 'Player 1', totalScore: 0, color: Colors.black),
          Player(id: 2, name: 'Player 2', totalScore: 0, color: Colors.blue),
        ],
        rounds: [
          Round(playerByScores: {1: 10, 2: 5}, id: 1, index: 3),
          Round(playerByScores: {1: 5, 2: 20}, id: 2, index: 4),
        ],
      );
    });

    test('hasReachedMaxScore returns true when a player reaches max score', () {
      final updateGame = game.copyWith(
        players: [
          Player(id: 1, name: 'Player 1', totalScore: 100, color: Colors.black),
          Player(id: 2, name: 'Player 2', totalScore: 4, color: Colors.blue),
        ],
      );

      expect(updateGame.hasReachedMaxScore, true);
    });

    test(
      'hasReachedMaxScore returns false when no player reaches max score',
      () {
        expect(game.hasReachedMaxScore, false);
      },
    );

    test('hasReachedMaxRounds returns true when max rounds are reached', () {
      game.rounds.addAll(
        List.generate(3, (_) => Round(playerByScores: {}, id: 1, index: 1)),
      );

      expect(game.hasReachedMaxRounds, true);
    });

    test(
      'hasReachedMaxRounds returns false when max rounds are not reached',
      () {
        expect(game.hasReachedMaxRounds, false);
      },
    );

    test('hasMaxScoreByRound returns true when maxScoreByRound is set', () {
      expect(game.hasMaxScoreByRound, true);
    });

    test(
      'hasMaxScoreByRound returns false when maxScoreByRound is not set',
      () {
        final updateGame = game.copyWith(gameOptions: GameOptions());

        expect(updateGame.hasMaxScoreByRound, false);
      },
    );

    test('toEntity should map Game to GameEntity correctly', () {
      final game = Game(
        id: 1,
        name: 'Test Game',
        createDate: DateTime(2023, 10, 10),
        gameOptions: GameOptions(
          maxScoreByRound: 100,
          maxScore: 500,
          maxRounds: 10,
        ),
        players: [
          Player(id: 1, name: 'Player 1', color: Colors.black),
          Player(id: 2, name: 'Player 2', color: Colors.blue),
        ],
        rounds: [
          Round(id: 1, playerByScores: {1: 10, 2: 20}, index: 0),
          Round(id: 2, playerByScores: {1: 30, 2: 40}, index: 1),
        ],
      );

      final gameEntity = game.toEntity();

      expect(gameEntity.id, equals(game.id));
      expect(gameEntity.name, equals(game.name));
      expect(gameEntity.createDate, equals(game.createDate));
      expect(gameEntity.players.length, equals(game.players.length));
      expect(gameEntity.rounds.length, equals(game.rounds.length));
      expect(
        gameEntity.gameOptions.target?.maxScoreByRound,
        equals(game.gameOptions.maxScoreByRound),
      );
      expect(
        gameEntity.gameOptions.target?.maxScore,
        equals(game.gameOptions.maxScore),
      );
      expect(
        gameEntity.gameOptions.target?.maxRounds,
        equals(game.gameOptions.maxRounds),
      );
    });
  });
}
