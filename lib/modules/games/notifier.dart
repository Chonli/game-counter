import 'package:flutter/foundation.dart';
import 'package:game_counter/data/sources/bdd.dart';
import 'package:game_counter/model/game.dart';
import 'package:provider/provider.dart';

class GameNotifier extends ChangeNotifier {
  GameNotifier(this._read) {
    games = _repository.getGames();
  }

  final Locator _read;
  HiveBdd get _repository => _read<HiveBdd>();

  Iterable<Game> get games => _games;
  Iterable<Game> _games = [];
  set games(Iterable<Game> value) {
    if (value != _games) {
      _games = value;
      notifyListeners();
    }
  }

  void addGame(Game game) {
    if (!_games.contains(game)) {
      _repository.createOrUpdateGame(game);
      games = _repository.getGames();
    }
  }
}
