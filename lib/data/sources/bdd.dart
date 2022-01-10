import 'dart:io';

import 'package:game_counter/model/game.dart';
import 'package:hive/hive.dart';

class HiveBdd {
  HiveBdd();

  Future<void> init() async {
    Hive
      ..init(Directory.current.path)
      ..registerAdapter(GameAdapter());
    gamebox = await Hive.openBox<Game>('gameBox');
  }

  late Box<Game> gamebox;

  void createGame(Game game) {
    if (!gamebox.values.contains(game)) {
      gamebox.add(game);
    }
  }

  Iterable<Game> getGames() {
    return gamebox.values;
  }
}
