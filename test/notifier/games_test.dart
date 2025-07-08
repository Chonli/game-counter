import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:score_counter/data/repositories/games.dart';
import 'package:score_counter/model/game.dart';
import 'package:score_counter/notifier/games.dart';

import '../common/container.dart';
import '../common/mock.dart';

void main() {
  late ProviderContainer container;
  late MockGamesRepository mockRepo;

  setUp(() {
    mockRepo = MockGamesRepository();
    container = createContainer(
      overrides: [gamesRepositoryProvider.overrideWithValue(mockRepo)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('GamesNotifier', () {
    test('createGame adds a new game to the state', () async {
      // Arrange
      final game = Game(
        id: 1,
        name: 'Test Game',
        createDate: DateTime(2025, 1, 1),
      );
      when(() => mockRepo.createGame(game)).thenReturn(1);

      // Act
      final notifier = container.read(gamesProvider.notifier);
      notifier.createGame(game);

      // Assert
      final state = container.read(gamesProvider);
      expect(state.value, [game.copyWith(id: 1)]);
    });

    test('removeGame removes a game from the state', () async {
      // Arrange
      final game = Game(
        id: 1,
        name: 'Test Game',
        createDate: DateTime(2025, 1, 1),
      );
      when(() => mockRepo.createGame(game)).thenReturn(1);
      when(() => mockRepo.removeGame(1)).thenReturn(null);

      // Act
      final notifier = container.read(gamesProvider.notifier);
      notifier.createGame(game);
      notifier.removeGame(1);

      // Assert
      final state = container.read(gamesProvider);
      expect(state.value, []);
    });
  });
}
