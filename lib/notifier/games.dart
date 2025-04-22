import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:score_counter/model/game.dart';

part 'games.g.dart';

@riverpod
class Games extends _$Games {
  @override
  FutureOr<List<Game>> build() {
    return [];
  }

  void addGame(Game game) {
    final oldValue = state.value ?? [];

    state = AsyncData([...oldValue, game]);
  }
}
