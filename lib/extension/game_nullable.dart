import 'package:flutter/widgets.dart';
import 'package:score_counter/model/game.dart';
import 'package:score_counter/model/game_options.dart';
import 'package:score_counter/model/player.dart';
import 'package:score_counter/model/round.dart';
import 'package:score_counter/services/generator_utilities.dart';

extension GameNullableExt on Game? {
  Game initializeOrUpdate({
    required String name,
    required GeneratorUtility generator,
    required List<String> validPlayers,
    required List<Color> playerColors,
    required GameOptions gameOptions,
  }) {
    ;
    int i = 0;

    final previousPlayers = (this?.players ?? <Player>[]).asMap();

    bool needUpdateRound = previousPlayers.length > validPlayers.length;

    final newPlayers = validPlayers.map((playerCtrl) {
      final color = playerColors[i];
      final existingPlayer = previousPlayers[i++];
      if (existingPlayer != null) {
        // Playeur existant
        return existingPlayer.copyWith(name: playerCtrl, color: color);
      }
      // New Playeur
      needUpdateRound = true;

      return Player(
        id: generator.newId(),
        name: playerCtrl,
        color: color,
        totalScore: 0,
      );
    }).toList();

    late List<Round> newsRound;

    if (needUpdateRound) {
      newsRound = (this?.rounds ?? []).map((round) {
        final updatedScores = <String, int>{};
        for (final player in newPlayers) {
          // if player exist keep score or add in round with score = 0
          updatedScores[player.id] = round.playerByScores[player.id] ?? 0;
        }
        return round.copyWith(playerByScores: updatedScores);
      }).toList();
    } else {
      newsRound = this?.rounds ?? [];
    }

    return Game(
      id: this?.id ?? generator.newId(),
      name: name,
      createDate: this?.createDate ?? DateTime.now(),
      gameOptions: gameOptions,
      players: newPlayers,
      rounds: newsRound,
    );
  }
}
