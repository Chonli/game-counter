import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:score_counter/data/repositories/games.dart';
import 'package:score_counter/model/game.dart';

part 'games.g.dart';

@riverpod
class Games extends _$Games {
  @override
  FutureOr<List<Game>> build() {
    final repo = ref.watch(gamesRepositoryProvider);

    return repo.getGames();
  }

  void createGame(Game game) {
    final repo = ref.watch(gamesRepositoryProvider);
    final newID = repo.createGame(game);
    final oldValue = state.value ?? [];

    state = AsyncData([...oldValue, game.copyWith(id: newID)]);
  }

  Game? getGame(int id) {
    final repo = ref.read(gamesRepositoryProvider);

    return repo.getGame(id);
  }
}
