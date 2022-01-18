import 'package:flutter/material.dart';
import 'package:game_counter/data/sources/bdd.dart';
import 'package:game_counter/model/game.dart';
import 'package:provider/provider.dart';

class GameDetailNotifier extends ChangeNotifier {
  GameDetailNotifier(
    this._read,
    this._game,
  );

  final Locator _read;
  HiveBdd get _repository => _read<HiveBdd>();

  Game get game => _game;
  Game _game;
  set game(Game value) {
    if (value != _game) {
      _game = value;
      _repository.createOrUpdateGame(_game);
      notifyListeners();
    }
  }
}
