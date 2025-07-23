import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:score_counter/data/repositories/games.dart';
import 'package:score_counter/model/game.dart';
import 'package:score_counter/model/game_options.dart';
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

  group('GamesNotifier', () {
    test('createGame adds a new game to the state', () async {
      final game = Game(
        id: 1,
        name: 'Test Game',
        createDate: DateTime(2025, 1, 1),
        gameOptions: GameOptions(),
      );
      when(
        () => mockRepo.addOrUpdateGame(game),
      ).thenAnswer((_) => Future.value(game));
      when(() => mockRepo.getGames()).thenReturn([game]);

      final notifier = container.read(gamesProvider.notifier);
      await notifier.createOrUpdateGame(game);

      final games = container.read(gamesProvider);
      expect(games.length, 1);
      expect(games.first.id, game.id);
      expect(games.first.name, game.name);
    });

    test('removeGame removes a game from the state', () async {
      final game = Game(
        id: 1,
        name: 'Test Game',
        createDate: DateTime(2025, 1, 1),
        gameOptions: GameOptions(),
      );
      when(
        () => mockRepo.addOrUpdateGame(game),
      ).thenAnswer((_) => Future.value(game));
      when(() => mockRepo.removeGame(1)).thenReturn(null);
      when(() => mockRepo.getGames()).thenReturn([game]);

      final notifier = container.read(gamesProvider.notifier);
      await notifier.createOrUpdateGame(game);
      final games = container.read(gamesProvider);
      expect(games.length, 1);

      when(() => mockRepo.getGames()).thenReturn([]);
      notifier.removeGame(1);

      final games2 = container.read(gamesProvider);
      expect(games2.isEmpty, true);
    });
  });
}
