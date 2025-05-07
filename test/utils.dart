import 'package:score_counter/data/entities/game.dart';

extension GameEntityExtension on GameEntity {
  GameEntity updateId(int newId) {
    final game = GameEntity(id: newId, name: name, createDate: createDate);

    game.players.addAll(players);
    game.rounds.addAll(rounds);

    return game;
  }
}
