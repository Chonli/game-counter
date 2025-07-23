import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:score_counter/data/repositories/games.dart';
import 'package:score_counter/data/sources/games_dao.dart';
import 'package:score_counter/model/game.dart';
import 'package:score_counter/model/game_options.dart';
import 'package:score_counter/model/player.dart';
import 'package:score_counter/model/round.dart';
import 'package:score_counter/notifier/games.dart';
import 'package:score_counter/objectbox.g.dart';

import '../common/container.dart';

// Test Notifier with real database
void main() {
  late ProviderContainer container;
  late GamesRepository repo;
  late GamesDao dao;
  late Store db;

  setUp(() async {
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

  group('GamesNotifier', () {
    test('createOrUpdateGame adds a new game to the state', () async {
      final game = Game(
        id: 1,
        name: 'Test Game',
        createDate: DateTime(2025, 1, 1),
        gameOptions: GameOptions(
          maxRounds: 10,
          maxScore: 2000,
          maxScoreByRound: 250,
        ),
        players: [
          Player(id: 0, name: 'toto', color: Colors.red),
          Player(id: 0, name: 'titi', color: Colors.blue),
        ],
        rounds: [],
      );

      final notifier = container.read(gamesProvider.notifier);
      await notifier.createOrUpdateGame(game);

      final games = container.read(gamesProvider);
      expect(games.length, 1);
      expect(games.first.id, game.id);
      expect(games.first.name, game.name);
    });

    test('createOrUpdateGame update an existing game in the state', () async {
      final game = Game(
        id: 0,
        name: 'Test Game',
        createDate: DateTime(2025, 1, 1),
        gameOptions: GameOptions(
          maxRounds: 10,
          maxScore: 2000,
          maxScoreByRound: 250,
        ),
        players: [
          Player(id: 0, name: 'toto', color: Colors.red),
          Player(id: 0, name: 'titi', color: Colors.blue),
        ],
      );

      final notifier = container.read(gamesProvider.notifier);
      await notifier.createOrUpdateGame(game);

      final state = container.read(gamesProvider);
      final first = state.first;
      expect(state.length, 1);
      expect(first.name, 'Test Game');
      expect(first.gameOptions.maxRounds, 10);
      expect(first.gameOptions.maxScore, 2000);
      expect(first.gameOptions.maxScoreByRound, 250);
      expect(first.players.length, 2);
      expect(first.rounds.isEmpty, true);

      // Update game
      await notifier.createOrUpdateGame(
        first.copyWith(
          name: 'Test Game Updated',
          gameOptions: GameOptions(
            maxRounds: null,
            maxScore: null,
            maxScoreByRound: 250,
          ),
          players: [
            ...first.players,
            Player(id: 0, name: 'tata', color: Colors.green),
          ],
          rounds: [Round(id: 0, index: 0, playerByScores: {})],
        ),
      );

      final stateUpdated = container.read(gamesProvider);
      final firstUpdated = stateUpdated.first;
      expect(stateUpdated.length, 1);
      expect(firstUpdated.name, 'Test Game Updated');
      expect(firstUpdated.gameOptions.maxRounds, null);
      expect(firstUpdated.gameOptions.maxScore, null);
      expect(firstUpdated.gameOptions.maxScoreByRound, 250);
      expect(firstUpdated.players.length, 3);
      expect(firstUpdated.rounds.length, 1);
    });

    test('removeGame removes a game from the state', () async {
      final game = Game(
        id: 1,
        name: 'Test Game',
        createDate: DateTime(2025, 1, 1),
        gameOptions: GameOptions(),
      );

      final notifier = container.read(gamesProvider.notifier);
      await notifier.createOrUpdateGame(game);
      notifier.removeGame(1);

      final state = container.read(gamesProvider);
      expect(state, []);
    });
  });
}
