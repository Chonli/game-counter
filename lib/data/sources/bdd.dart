import 'package:game_counter/model/game.dart';
import 'package:hive/hive.dart';

class HiveBdd {
  HiveBdd() {
    gamebox = Hive.box<Game>('gameBox');
  }

  late Box<Game> gamebox;

  void createGame(Game game) {
    if (gamebox.values.contains(game)) {
      gamebox.add(game);
    }
  }

  Iterable<Game> getGames() {
    return gamebox.values;
  }
}
