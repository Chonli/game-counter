import 'package:flutter/foundation.dart';
import 'package:game_counter/model/game.dart';

class GameNotifier extends ChangeNotifier {
  List<Game> get games => _games;
  List<Game> _games = [];
  set games(List<Game> value) {
    if (value != _games) {
      _games = value;
      notifyListeners();
    }
  }

  void addGame(Game game) {
    if (!_games.contains(game)) {
      _games.add(game);
      notifyListeners();
    }
  }
}
