import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:score_counter/data/repositories/games.dart';
import 'package:score_counter/model/game.dart';
import 'package:score_counter/model/player.dart';
import 'package:score_counter/model/round.dart';

part 'notifier.g.dart';

@riverpod
class CurrentGame extends _$CurrentGame {
  @override
  FutureOr<Game?> build(int gameId) {
    final repo = ref.read(gamesRepositoryProvider);

    final game = repo.getGame(gameId);

    if (game == null) return null;

    return _calculateNewScore(game);
  }

  void removeRound(Round round) {
    final game = state.valueOrNull;
    if (game == null) {
      return;
    }

    final repo = ref.read(gamesRepositoryProvider);
    final updatedRounds = game.rounds..remove(round);
    final updatedGame = _calculateNewScore(
      game.copyWith(rounds: updatedRounds),
    );
    repo.updateGame(updatedGame);
    state = AsyncValue.data(updatedGame);
  }

  Game _calculateNewScore(Game game) {
    // Create a new list of players with updated scores
    final tmpPlayers = <Player>[];
    for (final player in game.players) {
      tmpPlayers.add(
        player.copyWith(
          totalScore: game.rounds.fold(0, (previousValue, element) {
            return (previousValue ?? 0) +
                (element.playerByScores[player.id] ?? 0);
          }),
        ),
      );
    }

    return game.copyWith(players: tmpPlayers);
  }

  void addOrUpdateRound(Round round) {
    final game = state.valueOrNull;
    if (game == null) {
      return;
    }

    final repo = ref.read(gamesRepositoryProvider);
    final updatedRounds = [...game.rounds];
    updatedRounds
      ..removeWhere((r) => r.id == round.id)
      ..add(round)
      ..sort((a, b) => a.index.compareTo(b.index));

    final updatedGame = _calculateNewScore(
      game.copyWith(rounds: updatedRounds),
    );
    repo.updateGame(updatedGame);
    state = AsyncValue.data(updatedGame);
  }
}
