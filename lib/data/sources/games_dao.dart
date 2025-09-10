import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:score_counter/data/entities/game.dart';

part 'games_dao.g.dart';

@Riverpod(keepAlive: true)
GamesDao gamesDao(Ref ref) {
  final box = Hive.box<GameEntity>('games');

  return GamesDao(box);
}

class GamesDao {
  const GamesDao(this.box);

  @visibleForTesting
  final Box<GameEntity> box;

  // Games methods
  GameEntity? getGame(String id) {
    return box.get(id);
  }

  List<GameEntity> getGames() {
    return box.values.toList();
  }

  Future<void> addOrUpdateGame(GameEntity game) {
    return box.put(game.id, game);
  }

  void removeGame(String id) {
    box.delete(id);
  }
}
