import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:objectbox/objectbox.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:score_counter/core/database.dart';
import 'package:score_counter/data/entities/game.dart';
import 'package:score_counter/data/entities/round.dart';

part 'games_dao.g.dart';

@riverpod
GamesDao gamesDao(Ref ref) {
  final db = ref.watch(databaseProvider);
  final box = db.box<GameEntity>();
  final roundBox = db.box<RoundEntity>();

  return GamesDao(box, roundBox);
}

class GamesDao {
  const GamesDao(this.box, this.roundBox);

  @visibleForTesting
  final Box<GameEntity> box;
  @visibleForTesting
  final Box<RoundEntity> roundBox;

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
    print('updateGame: ${box.get(game.id)?.id}');
    return box.put(game, mode: PutMode.update);
  }

  int addRound(RoundEntity round) {
    return roundBox.put(round);
  }

  void removeGame(int id) {
    box.remove(id);
  }

  void clearGames() {
    box.removeAll();
    roundBox.removeAll();
  }
}
