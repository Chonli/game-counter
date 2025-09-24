import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:score_counter/data/entities/game.dart';
import 'package:score_counter/data/entities/game_options.dart';
import 'package:score_counter/data/entities/hive_registrar.g.dart';
import 'package:score_counter/data/entities/player.dart';
import 'package:score_counter/data/entities/round.dart';
import 'package:score_counter/data/sources/games_dao.dart';

void main() {
  late GamesDao gamesDao;
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
    gamesDao = GamesDao(box);
  });

  tearDown(() async {
    await box.clear();
    await box.close();
  });

  group('GamesDao', () {
    test('should return a list of games when getGames is called', () async {
      const firstID = '01-0012';
      final mockGames = <GameEntity>[
        GameEntity(
          id: firstID,
          name: 'Game 1',
          createDate: DateTime.now(),
          players: [],
          gameOptions: GameOptionsEntity(
            maxRounds: 10,
            maxScore: 100,
            maxScoreByRound: 10,
          ),
        ),
        GameEntity(
          id: '1',
          name: 'Game 2',
          createDate: DateTime.now(),
          players: [],
          gameOptions: GameOptionsEntity(
            maxRounds: 5,
            maxScore: 200,
            maxScoreByRound: 60,
          ),
        ),
        GameEntity(
          id: '3',
          name: 'Game 3',
          createDate: DateTime.now(),
          gameOptions: GameOptionsEntity(),
          players: [],
        ),
      ];
      for (final game in mockGames) {
        await gamesDao.addOrUpdateGame(game);
      }

      final result = gamesDao.getGames();
      expect(result.length, 3);

      final first = gamesDao.getGame(firstID);
      expect(first?.name, mockGames.first.name);
      expect(
        first?.gameOptions.maxRounds,
        mockGames.first.gameOptions.maxRounds,
      );
      expect(first?.gameOptions.maxScore, mockGames.first.gameOptions.maxScore);
      expect(
        first?.gameOptions.maxScoreByRound,
        mockGames.first.gameOptions.maxScoreByRound,
      );
      expect(first?.id, firstID);
    });

    test(
      'should return null when getGameById is called with an invalid id',
      () async {
        const gameID = '0133-0012';
        final mockGame = GameEntity(
          id: gameID,
          name: 'Game 12',
          createDate: DateTime.now(),
          gameOptions: GameOptionsEntity(),
          players: [],
        );
        await gamesDao.addOrUpdateGame(mockGame);

        final result = gamesDao.getGame("999");

        expect(result, null);

        final result2 = gamesDao.getGame("44-12");

        expect(result2, null);
      },
    );

    test('should update a game when addOrUpdateGame is called', () async {
      const gameID = '03012';
      final game = GameEntity(
        id: gameID,
        name: 'Updated Game 1',
        createDate: DateTime.now(),
        gameOptions: GameOptionsEntity(
          maxScoreByRound: 100,
          maxScore: 1000,
          maxRounds: 10,
        ),
        players: [
          PlayerEntity(id: "1", name: 'Player 1', color: 0xFF112233),
          PlayerEntity(id: "2", name: 'Player 2', color: 0xFF112244),
        ],
      );

      await gamesDao.addOrUpdateGame(game);

      final newGame = gamesDao.getGame(gameID);

      expect(newGame, isNotNull);
      expect(newGame?.id, gameID);
      expect(newGame?.name, 'Updated Game 1');
      expect(newGame?.players.length, 2);
      expect(newGame?.gameOptions.maxScoreByRound, 100);
      expect(newGame?.gameOptions.maxScore, 1000);
      expect(newGame?.gameOptions.maxRounds, 10);

      // update games values
      const newName = 'Updated Game 2';
      newGame?.name = newName;
      newGame?.players.add(
        PlayerEntity(id: "3", name: 'Player 3', color: 0xFF11FF33),
      );
      const playerByScores = {"1": 20, "2": 30, "3": 44};
      newGame?.rounds = [
        RoundEntity(id: "12", index: 1, playerByScores: playerByScores),
      ];

      await gamesDao.addOrUpdateGame(newGame!);

      final gameUpdated = gamesDao.getGame(gameID);

      expect(gameUpdated, isNotNull);
      expect(gameUpdated?.id, gameID);
      expect(gameUpdated?.name, newName);
      expect(gameUpdated?.players.length, 3);
      expect(gameUpdated?.rounds.first.index, 1);
      expect(gameUpdated?.rounds.first.playerByScores, playerByScores);
      expect(gameUpdated?.gameOptions.maxRounds, game.gameOptions.maxRounds);
    });

    test('should delete a game when deleteGame is called', () async {
      final mockGame = GameEntity(
        id: 'id',
        name: 'Updated Game 1',
        createDate: DateTime.now(),
        gameOptions: GameOptionsEntity(),
        players: [],
      );
      // Add a game to the database
      await gamesDao.addOrUpdateGame(mockGame);

      final result = gamesDao.getGame(mockGame.id);

      expect(result, isNotNull);
      expect(result?.name, mockGame.name);
      expect(result?.id, mockGame.id);

      // remove the game
      gamesDao.removeGame(mockGame.id);

      expect(await gamesDao.getGame(mockGame.id), isNull);
    });

    test('should clear all games when clearGames is called', () async {
      await gamesDao.addOrUpdateGame(
        GameEntity(
          id: 'dhb',
          name: 'A',
          createDate: DateTime.now(),
          gameOptions: GameOptionsEntity(),
          players: [],
        ),
      );
      await gamesDao.addOrUpdateGame(
        GameEntity(
          id: 'hdfhb',
          name: 'B',
          createDate: DateTime.now(),
          gameOptions: GameOptionsEntity(),
          players: [],
        ),
      );

      expect(gamesDao.getGames().length, 2);

      await gamesDao.clearGames();
      expect(gamesDao.getGames().length, 0);
    });

    test('should update players of a game', () async {
      final game = GameEntity(
        id: 'gggdb',
        name: 'With Players',
        createDate: DateTime.now(),
        gameOptions: GameOptionsEntity(),
        players: [PlayerEntity(id: 'hd', name: 'Player 1', color: 0xFF000001)],
      );

      await gamesDao.addOrUpdateGame(game);

      game.players.first.name = 'Player 1 Updated';
      await gamesDao.addOrUpdateGame(game);

      final updated = gamesDao.getGame('gggdb');

      // As players are empty now, update should do nothing (no crash)
      expect(updated, isNotNull);
      expect(updated?.players.length, 1);
      expect(updated?.players.first.name, 'Player 1 Updated');

      // Remove the only player from the game and update
      updated?.players.clear();
      await gamesDao.addOrUpdateGame(updated!);
      expect(gamesDao.getGame(updated.id)?.players.length, 0);
    });

    test('should update rounds of a game', () async {
      final game = GameEntity(
        id: 'hhf',
        name: 'With Rounds',
        createDate: DateTime.now(),
        gameOptions: GameOptionsEntity(),
        players: [PlayerEntity(id: '1', name: 'Player 1', color: 0xFF000001)],
        rounds: [
          RoundEntity(id: 'jfj', index: 1, playerByScores: {'1': 10}),
        ],
      );

      await gamesDao.addOrUpdateGame(game);

      game.rounds.first.index = 2;
      await gamesDao.addOrUpdateGame(game);

      final updated = gamesDao.getGame(game.id);

      // As players are empty now, update should do nothing (no crash)
      expect(updated, isNotNull);
      expect(updated?.rounds.length, 1);
      expect(updated?.rounds.first.index, 2);

      // Remove the only player from the game and update
      updated?.rounds.clear();
      await gamesDao.addOrUpdateGame(updated!);
      expect(gamesDao.getGame(updated.id)?.rounds.length, 0);
    });

    test('should clear all rounds of game', () async {
      final game = GameEntity(
        id: 'ud',
        name: 'Many rounds',
        createDate: DateTime.now(),
        gameOptions: GameOptionsEntity(),
        players: [PlayerEntity(id: '1', name: 'Player 1', color: 0xFF000001)],
        rounds: [
          RoundEntity(id: 'hh', index: 1, playerByScores: {'1': 10}),
          RoundEntity(id: 'dd', index: 2, playerByScores: {'1': 20}),
        ],
      );

      await gamesDao.addOrUpdateGame(game);

      final saved = gamesDao.getGame('ud');

      expect(saved, isNotNull);
      expect(saved?.rounds.length, 2);

      saved?.rounds = [];
      await gamesDao.addOrUpdateGame(saved!);

      final afterClear = gamesDao.getGame(saved.id);

      expect(afterClear, isNotNull);
      expect(afterClear?.rounds.length, 0);
    });
  });
}
