import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:score_counter/data/repositories/games.dart';
import 'package:score_counter/model/game.dart';
import 'package:score_counter/model/game_options.dart';
import 'package:score_counter/model/player.dart';
import 'package:score_counter/model/round.dart';
import 'package:score_counter/module/game/notifier.dart';

import '../../common/container.dart';

class MockGamesRepository extends Mock implements GamesRepository {}

void main() {
  late ProviderContainer container;
  late MockGamesRepository mockGamesRepository;

  setUp(() {
    registerFallbackValue(
      Game(
        id: 1,
        name: 'Test',
        createDate: DateTime(2025),
        gameOptions: GameOptions(),
      ),
    );
    mockGamesRepository = MockGamesRepository();
    container = createContainer(
      overrides: [
        gamesRepositoryProvider.overrideWithValue(mockGamesRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('CurrentGame Notifier', () {
    test('removeRound should update the game and remove the round', () async {
      final gameId = 1;
      final roundToRemove = Round(
        id: 1,
        index: 1,
        playerByScores: {1: 10, 2: 20},
      );
      final game = Game(
        id: gameId,
        rounds: [
          roundToRemove,
          Round(id: 2, index: 2, playerByScores: {1: 30, 2: 40}),
          Round(id: 3, index: 3, playerByScores: {1: 50, 2: 15}),
        ],
        players: [
          Player(id: 1, name: 'Player 1', color: Colors.black),
          Player(id: 2, name: 'Player 2', color: Colors.blue),
        ],
        name: 'Test Game',
        createDate: DateTime(2025, 1, 1),
        gameOptions: GameOptions(),
      );

      when(() => mockGamesRepository.getGame(gameId)).thenReturn(game);
      when(
        () => mockGamesRepository.updateGame(any()),
      ).thenAnswer((_) async => game);

      final notifier = container.read(currentGameProvider(gameId).notifier);

      await notifier.build(gameId);
      notifier.removeRound(roundToRemove);

      verify(() => mockGamesRepository.updateGame(any())).called(1);
      final gameUpdated = notifier.state.value;
      expect(gameUpdated?.rounds, isNot(contains(roundToRemove)));
      expect(gameUpdated?.rounds.length, 2);
      expect(gameUpdated?.rounds.first.id, 2);
      expect(gameUpdated?.players.first.totalScore, 80);
    });

    test(
      'addOrUpdateRound should update the game and add or update the round',
      () async {
        final gameId = 1;
        final roundToAdd = Round(
          id: 3,
          index: 3,
          playerByScores: {1: 10, 2: 20},
        );
        final game = Game(
          id: gameId,
          name: 'Test Game',
          createDate: DateTime(2025, 1, 1),
          rounds: [
            Round(id: 2, index: 2, playerByScores: {1: 30, 2: 40}),
            Round(id: 1, index: 1, playerByScores: {1: 50, 2: 15}),
          ],
          players: [
            Player(id: 1, name: 'Player 1', color: Colors.black),
            Player(id: 2, name: 'Player 2', color: Colors.blue),
          ],
          gameOptions: GameOptions(),
        );

        when(() => mockGamesRepository.getGame(gameId)).thenReturn(game);
        when(
          () => mockGamesRepository.updateGame(any()),
        ).thenAnswer((_) async => game);

        final notifier = container.read(currentGameProvider(gameId).notifier);

        await notifier.build(gameId);
        notifier.addOrUpdateRound(roundToAdd);

        verify(() => mockGamesRepository.updateGame(any())).called(1);
        final gameUpdated = notifier.state.value;
        expect(gameUpdated?.rounds, contains(roundToAdd));
        expect(gameUpdated?.rounds.length, 3);
        expect(gameUpdated?.rounds.first.id, 1);
        expect(gameUpdated?.players.first.totalScore, 90);
      },
    );
  });
}
