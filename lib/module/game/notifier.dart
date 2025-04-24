import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:score_counter/data/repositories/games.dart';
import 'package:score_counter/model/game.dart';

part 'notifier.g.dart';

@riverpod
class CurrentGame extends _$CurrentGame {
  @override
  FutureOr<Game?> build(int gameId) {
    final repo = ref.read(gamesRepositoryProvider);

    return repo.getGame(gameId);
  }
}
