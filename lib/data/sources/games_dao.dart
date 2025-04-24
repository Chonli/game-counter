import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:objectbox/objectbox.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:score_counter/core/database.dart';
import 'package:score_counter/data/entities/game.dart';

part 'games_dao.g.dart';

@riverpod
GamesDao gamesDao(Ref ref) {
  final db = ref.watch(databaseProvider);
  final box = db.box<GameEntity>();

  return GamesDao(box);
}

class GamesDao {
  const GamesDao(this.box);

  final Box<GameEntity> box;

  GameEntity? getGame(int id) {
    return box.get(id);
  }

  List<GameEntity> getGames() {
    return box.getAll();
  }

  int addGame(GameEntity game) {
    return box.put(game);
  }

  int updateGame(GameEntity game) {
    return box.put(game, mode: PutMode.update);
  }

  void removeGame(int id) {
    box.remove(id);
  }
}
