import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:score_counter/data/entities/game.dart';
import 'package:score_counter/data/entities/hive_registrar.g.dart';
import 'package:score_counter/data/repositories/games.dart';
import 'package:score_counter/data/sources/games_dao.dart';
import 'package:score_counter/model/game.dart';
import 'package:score_counter/model/game_options.dart';
import 'package:score_counter/model/player.dart';
import 'package:score_counter/model/round.dart';
import 'package:score_counter/module/game/notifier.dart';

import '../../common/container.dart';

// Test Notifier with real database and real repository
void main() {
  late ProviderContainer container;
  late GamesRepository repo;
  late GamesDao dao;
  late Box<GameEntity> box;

  setUpAll(() {
    // Initialize the test database
    Hive
      ..init('${Directory.current.path}/test')
      ..registerAdapters();
  });

  tearDownAll(() async {
    await Hive.deleteBoxFromDisk('test-game');
  });

  setUp(() async {
    box = await Hive.openBox<GameEntity>('test-game');

    // Initialize the GamesDao with the test database
    dao = GamesDao(box);

    repo = GamesRepository(dao);
    container = createContainer(
      overrides: [gamesRepositoryProvider.overrideWithValue(repo)],
    );
  });

  tearDown(() async {
    await dao.clearGames();
    await box.close();
  });

  group('CurrentGame Notifier', () {
    test('removeRound should update the game and remove the round', () async {
      final game = Game(
        id: "10",
        rounds: [
          Round(id: "22", index: 1, playerByScores: {"66": 10, "67": 20}),
          Round(id: "23", index: 2, playerByScores: {"66": 30, "67": 40}),
          Round(id: "24", index: 3, playerByScores: {"66": 50, "67": 15}),
        ],
        players: [
          Player(id: "66", name: 'Player 1', color: Colors.black),
          Player(id: "67", name: 'Player 2', color: Colors.blue),
        ],
        name: 'Test Game',
        createDate: DateTime(2025, 1, 1),
        gameOptions: GameOptions(),
      );
      await repo.addOrUpdateGame(game);
      final roundToRemove = game.rounds.first;
      final gameId = game.id;

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
      final roundToAdd = Round(
        id: "30",
        index: 3,
        playerByScores: {"3": 10, "2": 20},
      );
      final game = Game(
        id: "34",
        name: 'Test Game',
        createDate: DateTime(2025, 1, 1),
        rounds: [
          Round(id: "44", index: 1, playerByScores: {"3": 50, "2": 15}),
          Round(id: "45", index: 2, playerByScores: {"3": 30, "2": 40}),
        ],
        players: [
          Player(id: "3", name: 'Player 1', color: Colors.black),
          Player(id: "2", name: 'Player 2', color: Colors.blue),
        ],
        gameOptions: GameOptions(),
      );

      await repo.addOrUpdateGame(game);
      final gameId = game.id;

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
      expect(retGame?.rounds.last.id, roundToAdd.id);
      expect(retGame?.players.first.totalScore, 90);
    });

    test(
      'addOrUpdateRound should update the game and update the existing round',
      () async {
        final initialScore = {"22": 30, "23": 40};
        final initialScoreId = "99-85";

        final game = Game(
          id: "88",
          name: 'Test Game',
          createDate: DateTime(2025, 1, 1),
          rounds: [
            Round(id: "7", index: 1, playerByScores: {"22": 10, "23": 20}),
            Round(id: initialScoreId, index: 2, playerByScores: initialScore),
            Round(id: "9", index: 3, playerByScores: {"22": 70, "23": 80}),
          ],
          players: [
            Player(id: "22", name: 'Player 1', color: Colors.black),
            Player(id: "23", name: 'Player 2', color: Colors.blue),
          ],
          gameOptions: GameOptions(),
        );

        await repo.addOrUpdateGame(game);
        final gameId = game.id;

        // Force the notifier to build the initial state
        container.read(currentGameProvider(gameId));
        await container.pump();

        final notifier = container.read(currentGameProvider(gameId).notifier);
        final intialGame = container.read(currentGameProvider(gameId));

        expect(
          intialGame?.getRound(initialScoreId)?.playerByScores,
          initialScore,
        );
        expect(intialGame?.rounds.length, 3);
        expect(intialGame?.players.first.totalScore, 110);

        final updatedRound = Round(
          id: initialScoreId,
          index: 2,
          playerByScores: {"22": 50, "23": 60},
        );
        await notifier.addOrUpdateRound(updatedRound);

        final gameUpdated = container.read(currentGameProvider(gameId));
        expect(
          gameUpdated?.getRound(initialScoreId)?.playerByScores,
          updatedRound.playerByScores,
        );
        expect(gameUpdated?.rounds.length, 3);
        expect(gameUpdated?.players.first.totalScore, 130);
      },
    );
  });
}
