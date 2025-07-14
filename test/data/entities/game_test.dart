import 'package:flutter_test/flutter_test.dart';
import 'package:score_counter/data/entities/game.dart';
import 'package:score_counter/data/entities/player.dart';
import 'package:score_counter/data/entities/round.dart';

void main() {
  group('GameEntityExtension', () {
    test('toModel should convert GameEntity to Game model correctly', () {
      // Arrange
      final playerEntity = PlayerEntity(id: 1, name: 'Player 1', color: 255);
      final roundEntity = RoundEntity(id: 1, playerByScores: {1: 10}, index: 1);
      final gameEntity = GameEntity(
        id: 1,
        name: 'Test Game',
        createDate: DateTime.now(),
        maxScoreByRound: 10,
        maxScore: 100,
        maxRounds: 10,
      );
      gameEntity.players.add(playerEntity);
      gameEntity.rounds.add(roundEntity);

      // Act
      final gameModel = gameEntity.toModel();

      // Assert
      expect(gameModel.id, gameEntity.id);
      expect(gameModel.name, gameEntity.name);
      expect(gameModel.createDate, gameEntity.createDate);
      expect(gameModel.maxScoreByRound, gameEntity.maxScoreByRound);
      expect(gameModel.maxScore, gameEntity.maxScore);
      expect(gameModel.maxRounds, gameEntity.maxRounds);
      expect(gameModel.players.length, 1);
      expect(gameModel.players.first.id, playerEntity.id);
      expect(gameModel.players.first.name, playerEntity.name);
      expect(gameModel.rounds.length, 1);
      expect(gameModel.rounds.first.id, roundEntity.id);
      expect(gameModel.rounds.first.playerByScores, roundEntity.playerByScores);
    });

    test('toModel should handle null values correctly', () {
      // Arrange
      final gameEntity = GameEntity(
        id: 1,
        name: 'Test Game',
        createDate: DateTime.now(),
      );

      // Act
      final gameModel = gameEntity.toModel();

      // Assert
      expect(gameModel.id, gameEntity.id);
      expect(gameModel.name, gameEntity.name);
      expect(gameModel.createDate, gameEntity.createDate);
      expect(gameModel.maxScoreByRound, null);
      expect(gameModel.maxScore, null);
      expect(gameModel.maxRounds, null);
      expect(gameModel.players.isEmpty, true);
      expect(gameModel.rounds.isEmpty, true);
    });
  });
}
