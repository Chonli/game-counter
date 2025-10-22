import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:score_counter/extension/game_nullable.dart';
import 'package:score_counter/model/game.dart';
import 'package:score_counter/model/game_options.dart';
import 'package:score_counter/model/player.dart';
import 'package:score_counter/model/round.dart';
import 'package:score_counter/services/generator_utilities.dart';

import '../common/mock.dart';

void main() {
  const gameName = 'Test Game';
  late MockUuid mockUuid;
  late GeneratorUtility generator;
  final playerNames = ['Alice', 'Bob'];
  final newPlayerNames = ['Alice', 'Bob', 'Chris'];
  final colors = [Colors.red, Colors.blue, Colors.green];
  final options = GameOptions(maxRounds: 5);
  final fakeDate = DateTime(2024, 1, 1);

  setUp(() {
    mockUuid = MockUuid();
    generator = GeneratorUtility(mockUuid);

    when(
      () => mockUuid.v4(),
    ).thenReturn(DateTime.now().microsecondsSinceEpoch.toString());
  });

  test('Initialize new game if null', () {
    final game = (null as Game?).initializeOrUpdate(
      name: gameName,
      generator: generator,
      validPlayers: playerNames,
      playerColors: colors,
      gameOptions: options,
    );

    expect(game.name, gameName);
    expect(game.players.length, playerNames.length);
    expect(game.rounds.length, 0);
    expect(game.gameOptions, options);
    expect(game.players.map((p) => p.name).toList(), playerNames);
    expect(game.players.map((p) => p.color).toList(), colors.take(2).toList());
    expect(game.createDate, isA<DateTime>());
    expect(game.id, isNotNull);
  });

  test('Update game with extra player', () {
    final existing = Game(
      id: 'GAMEID',
      name: 'Old Name',
      createDate: fakeDate,
      players: [
        Player(id: '1', name: 'Alice', color: Colors.red, totalScore: 5),
        Player(id: '2', name: 'Bob', color: Colors.blue, totalScore: 3),
      ],
      rounds: [
        Round(playerByScores: {'1': 10, '2': 0}, id: '1', index: 1),
        Round(playerByScores: {'1': 4, '2': 6}, id: '2', index: 2),
      ],
      gameOptions: options,
    );

    final updated = existing.initializeOrUpdate(
      name: gameName,
      generator: generator,
      validPlayers: newPlayerNames,
      playerColors: colors,
      gameOptions: options,
    );

    expect(updated.name, gameName);
    expect(updated.id, existing.id); // should keep id
    expect(updated.createDate, fakeDate); // keep date
    expect(updated.players.length, 3);
    expect(updated.players[2].name, 'Chris');
    expect(updated.rounds.length, 2);
    for (final round in updated.rounds) {
      expect(
        round.playerByScores.keys,
        containsAll(updated.players.map((p) => p.id)),
      );
      // Newly added player Chris score: 0
      expect(round.playerByScores[updated.players[2].id], 0);
    }
  });

  test('Update game with player removal', () {
    final existing = Game(
      id: 'GAMEID',
      name: 'Old Name',
      createDate: fakeDate,
      players: [
        Player(id: '1', name: 'Alice', color: Colors.red, totalScore: 5),
        Player(id: '2', name: 'Bob', color: Colors.blue, totalScore: 3),
        Player(id: '3', name: 'Chris', color: Colors.green, totalScore: 0),
      ],
      rounds: [
        Round(playerByScores: {'1': 10, '2': 0, '3': 5}, id: '1', index: 1),
      ],
      gameOptions: options,
    );

    final reducedPlayers = ['Alice', 'Bob'];
    final reducedColors = [Colors.red, Colors.blue];

    final updated = existing.initializeOrUpdate(
      name: gameName,
      generator: generator,
      validPlayers: reducedPlayers,
      playerColors: reducedColors,
      gameOptions: options,
    );
    expect(updated.players.length, 2);
    expect(updated.players.map((p) => p.name), containsAll(['Alice', 'Bob']));
    expect(updated.rounds.first.playerByScores.length, 2);
    expect(updated.rounds.first.playerByScores.keys, isNot(contains('3')));
  });

  test('No update to round if only player data changed', () {
    final existing = Game(
      id: 'G',
      name: 'N',
      createDate: fakeDate,
      players: [
        Player(id: 'a', name: 'Old Name', color: Colors.green, totalScore: 0),
        Player(id: 'b', name: 'Old Name2', color: Colors.red, totalScore: 0),
      ],
      rounds: [
        Round(playerByScores: {'a': 10, 'b': 8}, id: '1', index: 1),
      ],
      gameOptions: options,
    );

    final sameNames = ['Alice', 'Bob'];
    final sameColors = [Colors.green, Colors.red];

    final updated = existing.initializeOrUpdate(
      name: gameName,
      generator: generator,
      validPlayers: sameNames,
      playerColors: sameColors,
      gameOptions: options,
    );

    expect(
      updated.rounds,
      existing.rounds,
    ); // Should be identical instances (no need to rebuild)
    expect(updated.players[0].name, 'Alice');
    expect(updated.players[1].name, 'Bob');
  });
}
