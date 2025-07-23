import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:score_counter/data/repositories/games.dart';
import 'package:score_counter/model/game.dart';

part 'games.g.dart';

@riverpod
class Games extends _$Games {
  @override
  List<Game> build() {
    final repo = ref.watch(gamesRepositoryProvider);

    return repo.getGames();
  }

  Future<void> createOrUpdateGame(Game game) async {
    final repo = ref.read(gamesRepositoryProvider);

    await repo.addOrUpdateGame(game);

    state = repo.getGames();
  }

  void removeGame(int id) {
    final repo = ref.read(gamesRepositoryProvider);
    repo.removeGame(id);
    state = repo.getGames();
  }
}
