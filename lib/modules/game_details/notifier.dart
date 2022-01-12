import 'package:flutter/material.dart';
import 'package:game_counter/data/sources/bdd.dart';
import 'package:game_counter/model/player.dart';
import 'package:provider/provider.dart';

class GameNotifier extends ChangeNotifier {
  GameNotifier(this._read);

  final Locator _read;
  HiveBdd get _repository => _read<HiveBdd>();

  void addTurn(List<Player> players) {}
}
