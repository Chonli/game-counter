import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:score_counter/data/entities/game.dart';
import 'package:score_counter/data/sources/games_dao.dart';
import 'package:score_counter/model/game.dart';

part 'games.g.dart';

@riverpod
GamesRepository gamesRepository(Ref ref) {
  final dao = ref.watch(gamesDaoProvider);

  return GamesRepository(dao);
}

class GamesRepository {
  const GamesRepository(this.dao);

  final GamesDao dao;

  List<Game> getGames() => dao.getGames().map((e) => e.toModel()).toList();

  Future<Game> addOrUpdateGame(Game game) async {
    final gameEntity = game.toEntity();

    dao.updatePlayersOfGame(gameEntity);
    dao.updateRoundsOfGame(gameEntity);
    final result = await dao.addOrUpdateGame(gameEntity);

    return result.toModel();
  }

  void removeGame(int id) => dao.removeGame(id);

  Game? getGame(int id) => dao.getGame(id)?.toModel();
}
