import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:score_counter/model/game.dart';
import 'package:score_counter/model/player.dart';
import 'package:score_counter/model/round.dart';

void main() {
  group('GameExtension', () {
    test('toEntity should map Game to GameEntity correctly', () {
      final game = Game(
        id: 1,
        name: 'Test Game',
        createDate: DateTime(2023, 10, 10),
        maxScoreByRound: 100,
        maxScore: 500,
        maxRounds: 10,
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
      expect(gameEntity.maxScoreByRound, equals(game.maxScoreByRound));
      expect(gameEntity.maxScore, equals(game.maxScore));
      expect(gameEntity.maxRounds, equals(game.maxRounds));
    });

    test('updatePlayerScore should update totalScore for each player', () {
      final game = Game(
        id: 1,
        name: 'Test Game',
        createDate: DateTime(2023, 10, 10),
        maxScore: 50,
        maxRounds: 2,
        players: [
          Player(id: 1, name: 'Player 1', color: Colors.black),
          Player(id: 2, name: 'Player 2', color: Colors.blue),
        ],
        rounds: [
          Round(id: 1, playerByScores: {1: 10, 2: 30}, index: 0),
          Round(id: 2, playerByScores: {1: 20, 2: 40}, index: 1),
        ],
      );

      expect(game.players[0].totalScore, equals(0)); // default value
      expect(game.players[1].totalScore, equals(0)); // default value
      expect(game.hasReachedMaxScore, false);
      expect(game.hasReachedMaxRounds, true);

      game.updatePlayerScore();

      expect(game.players[0].totalScore, equals(30)); // 10 + 20
      expect(game.players[1].totalScore, equals(70)); // 30 + 40
      expect(game.hasReachedMaxScore, true);
    });

    test('updatePlayerScore should do nothing if rounds are empty', () {
      final game = Game(
        id: 1,
        name: 'Test Game',
        createDate: DateTime(2024, 1, 1),
        maxScore: 50,
        maxRounds: 5,
        maxScoreByRound: 30,
        players: [
          Player(id: 1, name: 'Player 1', color: Colors.black),
          Player(id: 2, name: 'Player 2', color: Colors.blue),
        ],
        rounds: [],
      );

      expect(game.players[0].totalScore, equals(0)); // default value
      expect(game.players[1].totalScore, equals(0)); // default value
      expect(game.hasReachedMaxRounds, false);
      expect(game.hasReachedMaxScore, false);

      game.updatePlayerScore();

      expect(game.players[0].totalScore, equals(0)); // default value
      expect(game.players[1].totalScore, equals(0)); // default value
      expect(game.hasReachedMaxRounds, false);
      expect(game.hasReachedMaxScore, false);
    });
  });
}
