import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:score_counter/data/repositories/games.dart';
import 'package:score_counter/data/sources/games_dao.dart';
import 'package:score_counter/model/game.dart';
import 'package:score_counter/model/game_options.dart';
import 'package:score_counter/model/player.dart';
import 'package:score_counter/model/round.dart';
import 'package:score_counter/module/game/notifier.dart';
import 'package:score_counter/objectbox.g.dart';

import '../../common/container.dart';

// Test Notifier with real database and real repository
void main() {
  late ProviderContainer container;
  late GamesRepository repo;
  late GamesDao dao;
  late Store db;

  setUp(() {
    db = Store(getObjectBoxModel(), directory: "memory:test-db");

    // Initialize the GamesDao with the test database
    dao = GamesDao(db);

    repo = GamesRepository(dao);
    container = createContainer(
      overrides: [gamesRepositoryProvider.overrideWithValue(repo)],
    );
  });

  tearDown(() {
    dao.clearGames();
    db.close();
  });

  group('CurrentGame Notifier', () {
    test('removeRound should update the game and remove the round', () async {
      final game = Game(
        id: 0,
        rounds: [
          Round(id: 0, index: 1, playerByScores: {1: 10, 2: 20}),
          Round(id: 0, index: 2, playerByScores: {1: 30, 2: 40}),
          Round(id: 0, index: 3, playerByScores: {1: 50, 2: 15}),
        ],
        players: [
          Player(id: 0, name: 'Player 1', color: Colors.black),
          Player(id: 0, name: 'Player 2', color: Colors.blue),
        ],
        name: 'Test Game',
        createDate: DateTime(2025, 1, 1),
        gameOptions: GameOptions(),
      );
      final addGame = await repo.addOrUpdateGame(game);
      final roundToRemove = addGame.rounds.first;
      final gameId = addGame.id;

      // Force the notifier to build the initial state
      container.read(currentGameProvider(gameId));
      await container.pump();

      final initialGame = container.read(currentGameProvider(gameId));
      expect(initialGame?.rounds.length, 3);
      expect(initialGame?.players.first.totalScore, 90);

      await container
          .read(currentGameProvider(gameId).notifier)
          .removeRound(roundToRemove);

      final gameUpdated = container.read(currentGameProvider(gameId));
      expect(gameUpdated?.rounds.contains(roundToRemove), false);
      expect(gameUpdated?.rounds.length, 2);
      expect(gameUpdated?.rounds.first.index, 2);
      expect(gameUpdated?.players.first.totalScore, 80);
    });

    test('addOrUpdateRound should update the game and add the round', () async {
      final roundToAdd = Round(id: 0, index: 3, playerByScores: {1: 10, 2: 20});
      final game = Game(
        id: 0,
        name: 'Test Game',
        createDate: DateTime(2025, 1, 1),
        rounds: [
          Round(id: 0, index: 1, playerByScores: {1: 50, 2: 15}),
          Round(id: 0, index: 2, playerByScores: {1: 30, 2: 40}),
        ],
        players: [
          Player(id: 0, name: 'Player 1', color: Colors.black),
          Player(id: 0, name: 'Player 2', color: Colors.blue),
        ],
        gameOptions: GameOptions(),
      );
      final addGame = await repo.addOrUpdateGame(game);
      final gameId = addGame.id;

      // Force the notifier to build the initial state
      container.read(currentGameProvider(gameId));
      await container.pump();

      final initialGame = container.read(currentGameProvider(gameId));
      expect(initialGame?.rounds.length, 2);
      expect(initialGame?.players.first.totalScore, 80);

      await container
          .read(currentGameProvider(gameId).notifier)
          .addOrUpdateRound(roundToAdd);

      final retGame = container.read(currentGameProvider(gameId));
      expect(retGame?.rounds.length, 3);
      expect(retGame?.rounds.last.id, 3);
      expect(retGame?.players.first.totalScore, 90);
    });

    test(
      'addOrUpdateRound should update the game and update the existing round',
      () async {
        final initialScore = {1: 30, 2: 40};

        final game = Game(
          id: 0,
          name: 'Test Game',
          createDate: DateTime(2025, 1, 1),
          rounds: [
            Round(id: 0, index: 1, playerByScores: {1: 10, 2: 20}),
            Round(id: 0, index: 2, playerByScores: initialScore),
            Round(id: 0, index: 3, playerByScores: {1: 70, 2: 80}),
          ],
          players: [
            Player(id: 0, name: 'Player 1', color: Colors.black),
            Player(id: 0, name: 'Player 2', color: Colors.blue),
          ],
          gameOptions: GameOptions(),
        );
        final addGame = await repo.addOrUpdateGame(game);
        final gameId = addGame.id;

        // Force the notifier to build the initial state
        container.read(currentGameProvider(gameId));
        await container.pump();

        final notifier = container.read(currentGameProvider(gameId).notifier);
        final intialGame = container.read(currentGameProvider(gameId));

        expect(
          intialGame?.rounds
              .firstWhereOrNull((round) => round.index == 2)
              ?.playerByScores,
          initialScore,
        );
        expect(intialGame?.rounds.length, 3);
        expect(intialGame?.players.first.totalScore, 110);

        final updatedRound = Round(
          id: 2,
          index: 2,
          playerByScores: {1: 50, 2: 60},
        );
        await notifier.addOrUpdateRound(updatedRound);

        final gameUpdated = container.read(currentGameProvider(gameId));
        expect(
          gameUpdated?.rounds
              .firstWhereOrNull((test) => test.index == 2)
              ?.playerByScores,
          updatedRound.playerByScores,
        );
        expect(gameUpdated?.rounds.length, 3);
        expect(gameUpdated?.players.first.totalScore, 130);
      },
    );
  });
}
