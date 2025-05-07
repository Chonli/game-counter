import 'package:flutter_test/flutter_test.dart';
import 'package:score_counter/data/entities/game.dart';
import 'package:score_counter/data/entities/player.dart';
import 'package:score_counter/data/entities/round.dart';
import 'package:score_counter/data/sources/games_dao.dart';
import 'package:score_counter/objectbox.g.dart';

import 'utils.dart';

void main() {
  late GamesDao gamesDao;
  late Store db;

  setUp(() async {
    db = await openStore(directory: "memory:test-db");
    final box = db.box<GameEntity>();
    final roundBox = db.box<RoundEntity>();

    // Initialize the GamesDao with the test database
    gamesDao = GamesDao(box, roundBox);
  });

  tearDown(() {
    gamesDao.clearGames();
    db.close();
  });

  group('GamesDao', () {
    test('should return a list of games when getGames is called', () {
      final mockGames = <GameEntity>[
        GameEntity(id: 0, name: 'Game 1', createDate: DateTime.now()),
        GameEntity(id: 0, name: 'Game 2', createDate: DateTime.now()),
        GameEntity(id: 0, name: 'Game 3', createDate: DateTime.now()),
      ];
      for (final game in mockGames) {
        gamesDao.addGame(game);
      }

      final result = gamesDao.getGames();

      expect(result.length, 3);
      final first = gamesDao.getGame(1);

      expect(first?.name, mockGames.first.name);
    });

    test('should return a game when getGameById is called with a valid id', () {
      final mockGame = GameEntity(
        id: 0,
        name: 'Game 12',
        createDate: DateTime.now(),
      );
      final newID = gamesDao.addGame(mockGame);

      final result = gamesDao.getGame(newID);

      expect(result?.name, mockGame.name);
      expect(result?.id, newID);
    });

    test(
      'should return null when getGameById is called with an invalid id',
      () {
        final result = gamesDao.getGame(999);

        expect(result, null);
      },
    );

    test('should update a game when updateGame is called', () {
      final mockGame = GameEntity(
        id: 0,
        name: 'Updated Game 1',
        createDate: DateTime.now(),
      );
      mockGame.players.addAll([
        PlayerEntity(id: 0, name: 'Player 1', color: 0xFF112233),
        PlayerEntity(id: 0, name: 'Player 2', color: 0xFF112244),
      ]);
      final newID = gamesDao.addGame(mockGame);
      final newMockGame = mockGame.updateId(newID);
      const newName = 'Updated Game 2';
      newMockGame.name = newName;
      const playerByScores = {1: 20, 2: 30};
      newMockGame.rounds.add(
        RoundEntity(id: 0, index: 0, playerByScores: playerByScores),
      );

      final result = gamesDao.updateGame(newMockGame);

      expect(result, newID);
      final resultGame = gamesDao.getGame(newID);
      expect(resultGame?.name, newName);
      expect(resultGame?.rounds.first.index, 0);
      expect(resultGame?.rounds.first.playerByScores, playerByScores);
    });

    test('should delete a game when deleteGame is called', () {
      final mockGame = GameEntity(
        id: 0,
        name: 'Updated Game 1',
        createDate: DateTime.now(),
      );
      final newID = gamesDao.addGame(mockGame);

      final result = gamesDao.getGame(newID);

      expect(result?.name, mockGame.name);
      expect(result?.id, newID);
      gamesDao.removeGame(newID);

      expect(gamesDao.getGame(newID), null);
    });
  });
}
