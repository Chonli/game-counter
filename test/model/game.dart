import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:score_counter/model/game.dart';
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
        maxScoreByRound: 10,
        maxScore: 50,
        maxRounds: 5,
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

    test('updatePlayerScore updates total scores correctly', () {
      game.updatePlayerScore();

      expect(game.players[0].totalScore, 15);
      expect(game.players[1].totalScore, 35);
    });

    test('hasReachedMaxScore returns true when a player reaches max score', () {
      game.players[0].totalScore = 50;

      expect(game.hasReachedMaxScore, true);
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
        game.maxScoreByRound = null;

        expect(game.hasMaxScoreByRound, false);
      },
    );
  });
}
