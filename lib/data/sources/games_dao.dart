import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:objectbox/objectbox.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:score_counter/core/database.dart';
import 'package:score_counter/data/entities/game.dart';
import 'package:score_counter/data/entities/player.dart';
import 'package:score_counter/data/entities/round.dart';

part 'games_dao.g.dart';

@Riverpod(keepAlive: true)
GamesDao gamesDao(Ref ref) {
  final db = ref.watch(databaseProvider);

  ref.onDispose(() {
    db.close();
  });

  return GamesDao(db);
}

class GamesDao {
  GamesDao(this.db)
    : _gameBox = db.box<GameEntity>(),
      _roundBox = db.box<RoundEntity>(),
      _playerBox = db.box<PlayerEntity>();

  final Store db;

  final Box<GameEntity> _gameBox;

  final Box<RoundEntity> _roundBox;

  final Box<PlayerEntity> _playerBox;

  // Games methods
  GameEntity? getGame(int id) {
    // To prevent the error: "ObjectBoxException: Illegal ID value 0"
    if (id < 1) {
      return null;
    }

    return _gameBox.get(id);
  }

  List<GameEntity> getGames() {
    return _gameBox.getAll();
  }

  Future<GameEntity> addOrUpdateGame(GameEntity game) {
    return _gameBox.putAndGetAsync(game);
  }

  void removeGame(int id) {
    _gameBox.remove(id);
  }

  void clearGames() {
    _gameBox.removeAll();
    _playerBox.removeAll();
    _roundBox.removeAll();
  }

  // Players methods
  void updatePlayersOfGame(GameEntity game) {
    final oldGame = getGame(game.id);
    if (oldGame == null || oldGame.players.isEmpty) {
      return;
    }

    final newPlayersIds = game.players.map((r) => r.id).toList();
    final oldPlayersIds = oldGame.players.map((r) => r.id).toList();
    final playersToRemove = <int>[];
    final playersToUpdate = <int>[];

    for (final oldPlayerId in oldPlayersIds) {
      if (!newPlayersIds.contains(oldPlayerId)) {
        playersToRemove.add(oldPlayerId);
      } else {
        playersToUpdate.add(oldPlayerId);
      }
    }

    _playerBox.removeMany(playersToRemove);
    _playerBox.putMany(
      game.players.where((r) => playersToUpdate.contains(r.id)).toList(),
    );
  }

  // Rounds methods
  void updateRoundsOfGame(GameEntity game) {
    final oldGame = getGame(game.id);
    if (oldGame == null || oldGame.rounds.isEmpty) {
      return;
    }

    final newRoundsIds = game.rounds.map((r) => r.id).toList();
    final oldRoundsIds = oldGame.rounds.map((r) => r.id).toList();
    final roundsToRemove = <int>[];
    final roundsToUpdate = <int>[];

    for (final oldPlayerId in oldRoundsIds) {
      if (!newRoundsIds.contains(oldPlayerId)) {
        roundsToRemove.add(oldPlayerId);
      } else {
        roundsToUpdate.add(oldPlayerId);
      }
    }

    _roundBox.removeMany(roundsToRemove);
    _roundBox.putMany(
      game.rounds.where((r) => roundsToUpdate.contains(r.id)).toList(),
    );
  }

  void clearRoundsOfGame(int gameId) {
    final game = getGame(gameId);
    if (game == null) {
      return;
    }
    _roundBox.removeMany(game.rounds.map((r) => r.id).toList());
  }

  Future<RoundEntity> addOrUpdateRound(RoundEntity round) {
    return _roundBox.putAndGetAsync(round);
  }

  void removeRound(int id) {
    _roundBox.remove(id);
  }
}
