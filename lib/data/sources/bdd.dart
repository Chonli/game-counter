import 'dart:io';

import 'package:game_counter/model/game.dart';
import 'package:game_counter/model/player.dart';
import 'package:game_counter/model/score.dart';
import 'package:hive/hive.dart';

class HiveBdd {
  HiveBdd();

  Future<void> init() async {
    final path = Directory.current.path;
    Hive
      ..init(path)
      ..registerAdapter(GameAdapter())
      ..registerAdapter(PlayerAdapter())
      ..registerAdapter(ScoreAdapter());
    gamebox = await Hive.openBox<Game>('gameBox');
  }

  late Box<Game> gamebox;

  void createOrUpdateGame(Game game) {
    gamebox.put(game.id, game);
  }

  Iterable<Game> getGames() {
    return gamebox.values;
  }

  Game? getGame(String id) {
    return gamebox.get(id);
  }
}
