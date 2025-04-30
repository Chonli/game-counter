import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:score_counter/data/repositories/games.dart';
import 'package:score_counter/model/game.dart';
import 'package:score_counter/model/round.dart';

part 'notifier.g.dart';

@riverpod
class CurrentGame extends _$CurrentGame {
  @override
  FutureOr<Game?> build(int gameId) {
    final repo = ref.read(gamesRepositoryProvider);

    return repo.getGame(gameId);
  }

  void addOrUpdateRound(Round round) {
    final game = state.valueOrNull;
    if (game == null) {
      return;
    }

    final existRound = game.rounds.firstWhereOrNull((r) => r.id == round.id);

    if (existRound != null) {
      // update round
    } else {
      // create round
    }
  }
}
