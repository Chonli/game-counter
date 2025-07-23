import 'package:flutter_test/flutter_test.dart';
import 'package:score_counter/data/entities/game.dart';
import 'package:score_counter/data/entities/game_options.dart';
import 'package:score_counter/data/entities/player.dart';
import 'package:score_counter/data/entities/round.dart';
import 'package:score_counter/data/sources/games_dao.dart';
import 'package:score_counter/objectbox.g.dart';

void main() {
  late GamesDao gamesDao;
  late Store db;

  setUp(() async {
    db = Store(getObjectBoxModel(), directory: "memory:test-db");

    // Initialize the GamesDao with the test database
    gamesDao = GamesDao(db);
  });

  tearDown(() {
    gamesDao.clearGames();
    db.close();
  });

  group('GamesDao', () {
    test('should return a list of games when getGames is called', () async {
      final mockGames = <GameEntity>[
        GameEntity(id: 0, name: 'Game 1', createDate: DateTime.now())
          ..gameOptions.target = GameOptionsEntity(
            maxRounds: 10,
            maxScore: 100,
            maxScoreByRound: 10,
          ),
        GameEntity(id: 0, name: 'Game 2', createDate: DateTime.now())
          ..gameOptions.target = GameOptionsEntity(
            maxRounds: 5,
            maxScore: 200,
            maxScoreByRound: 60,
          ),
        GameEntity(id: 0, name: 'Game 3', createDate: DateTime.now()),
      ];
      for (final game in mockGames) {
        await gamesDao.addOrUpdateGame(game);
      }

      final result = gamesDao.getGames();
      expect(result.length, 3);

      final first = gamesDao.getGame(1);
      expect(first?.name, mockGames.first.name);
      expect(
        first?.gameOptions.target?.maxRounds,
        mockGames.first.gameOptions.target?.maxRounds,
      );
      expect(
        first?.gameOptions.target?.maxScore,
        mockGames.first.gameOptions.target?.maxScore,
      );
      expect(
        first?.gameOptions.target?.maxScoreByRound,
        mockGames.first.gameOptions.target?.maxScoreByRound,
      );
      expect(first?.id, 1);
    });

    test('should return a game updated with a new id', () async {
      final mockGame = GameEntity(
        id: 0,
        name: 'Game 12',
        createDate: DateTime.now(),
      );
      final newGame = await gamesDao.addOrUpdateGame(mockGame);

      expect(newGame.name, mockGame.name);
      expect(newGame.id, 1);
    });

    test(
      'should return null when getGameById is called with an invalid id',
      () {
        final result = gamesDao.getGame(999);

        expect(result, null);

        final result2 = gamesDao.getGame(-12);

        expect(result2, null);

        final result3 = gamesDao.getGame(0);

        expect(result3, null);
      },
    );

    test('should update a game when addOrUpdateGame is called', () async {
      final game = GameEntity(
        id: 0,
        name: 'Updated Game 1',
        createDate: DateTime.now(),
      );
      game.players.addAll([
        PlayerEntity(id: 0, name: 'Player 1', color: 0xFF112233),
        PlayerEntity(id: 0, name: 'Player 2', color: 0xFF112244),
      ]);
      game.gameOptions.target = GameOptionsEntity(
        id: 0,
        maxScoreByRound: 100,
        maxScore: 1000,
        maxRounds: 10,
      );
      final newGame = await gamesDao.addOrUpdateGame(game);
      expect(newGame.id, 1);
      expect(newGame.name, 'Updated Game 1');
      expect(newGame.players.length, 2);
      expect(newGame.gameOptions.target?.maxScoreByRound, 100);
      expect(newGame.gameOptions.target?.maxScore, 1000);
      expect(newGame.gameOptions.target?.maxRounds, 10);

      // update games values
      final newId = newGame.id;
      const newName = 'Updated Game 2';
      newGame.name = newName;
      newGame.players.add(
        PlayerEntity(id: 0, name: 'Player 3', color: 0xFF11FF33),
      );
      const playerByScores = {1: 20, 2: 30};
      newGame.rounds.add(
        RoundEntity(id: 0, index: 0, playerByScores: playerByScores),
      );

      final gameUpdated = await gamesDao.addOrUpdateGame(newGame);

      expect(gameUpdated.id, newId);
      expect(gameUpdated.name, newName);
      expect(gameUpdated.players.length, 3);
      expect(gameUpdated.rounds.first.index, 0);
      expect(gameUpdated.rounds.first.playerByScores, playerByScores);
      expect(
        gameUpdated.gameOptions.target?.maxRounds,
        game.gameOptions.target?.maxRounds,
      );
    });

    test('should delete a game when deleteGame is called', () async {
      final mockGame = GameEntity(
        id: 0,
        name: 'Updated Game 1',
        createDate: DateTime.now(),
      );
      // Add a game to the database
      final result = await gamesDao.addOrUpdateGame(mockGame);

      final newId = result.id;
      expect(result.name, mockGame.name);
      expect(gamesDao.getGame(newId), isA<GameEntity>());

      // remove the game
      gamesDao.removeGame(newId);

      expect(gamesDao.getGame(newId), null);
    });

    test('should clear all games when clearGames is called', () async {
      await gamesDao.addOrUpdateGame(
        GameEntity(id: 0, name: 'A', createDate: DateTime.now()),
      );
      await gamesDao.addOrUpdateGame(
        GameEntity(id: 0, name: 'B', createDate: DateTime.now()),
      );

      expect(gamesDao.getGames().length, 2);

      gamesDao.clearGames();
      expect(gamesDao.getGames().length, 0);
    });

    test('should update players of a game', () async {
      final game = GameEntity(
        id: 0,
        name: 'With Players',
        createDate: DateTime.now(),
      );
      game.players.add(
        PlayerEntity(id: 0, name: 'Player 1', color: 0xFF000001),
      );
      final persisted = await gamesDao.addOrUpdateGame(game);

      persisted.players.first.name = 'Player 1 Updated';
      gamesDao.updatePlayersOfGame(persisted);

      final updated = gamesDao.getGame(persisted.id);

      // As players are empty now, update should do nothing (no crash)
      expect(updated?.players.length, 1);
      expect(updated?.players.first.name, 'Player 1 Updated');

      // Remove the only player from the game and update
      updated?.players.clear();
      gamesDao.updatePlayersOfGame(updated!);
      expect(gamesDao.getGame(updated.id)?.players.length, 0);
    });

    test('should update rounds of a game', () async {
      final game = GameEntity(
        id: 0,
        name: 'With Rounds',
        createDate: DateTime.now(),
      );
      game.rounds.add(RoundEntity(id: 0, index: 1, playerByScores: {1: 10}));
      final persisted = await gamesDao.addOrUpdateGame(game);

      persisted.rounds.first.index = 2;
      gamesDao.updateRoundsOfGame(persisted);

      final updated = gamesDao.getGame(persisted.id);

      // As players are empty now, update should do nothing (no crash)
      expect(updated?.rounds.length, 1);
      expect(updated?.rounds.first.index, 2);

      // Remove the only player from the game and update
      updated?.rounds.clear();
      gamesDao.updateRoundsOfGame(updated!);
      expect(gamesDao.getGame(updated.id)?.rounds.length, 0);
    });

    test('should clear all rounds of game', () async {
      final game = GameEntity(
          id: 0,
          name: 'Many rounds',
          createDate: DateTime.now(),
        )
        ..rounds.addAll([
          RoundEntity(id: 0, index: 1, playerByScores: {1: 10}),
          RoundEntity(id: 0, index: 2, playerByScores: {1: 20}),
        ]);
      final saved = await gamesDao.addOrUpdateGame(game);

      expect(saved.rounds.length, 2);

      gamesDao.clearRoundsOfGame(saved.id);
      final afterClear = gamesDao.getGame(saved.id);
      expect(afterClear?.rounds.length, 0);
    });

    test('should add or update a round', () async {
      final round = RoundEntity(id: 0, index: 3, playerByScores: {1: 42});
      final savedRound = await gamesDao.addOrUpdateRound(round);

      expect(savedRound.id, isNonZero);
      expect(savedRound.index, 3);
      expect(savedRound.playerByScores[1], 42);

      // Update
      savedRound.index = 5;
      final updatedRound = await gamesDao.addOrUpdateRound(savedRound);
      expect(updatedRound.index, 5);
    });

    test('should remove a round', () async {
      final round = RoundEntity(id: 0, index: 7, playerByScores: {1: 99});
      final savedRound = await gamesDao.addOrUpdateRound(round);

      expect(gamesDao.getGames().length, anyOf(0, 1, 2, 3)); // Just avoid crash

      gamesDao.removeRound(savedRound.id);

      // Attempt to get the round from ObjectBox, should throw or return null
      final removed = gamesDao.db.box<RoundEntity>().get(savedRound.id);
      expect(removed, null);
    });
  });
}
