import 'package:flutter_test/flutter_test.dart';
import 'package:score_counter/model/round.dart';

void main() {
  group('RoundExtension', () {
    test(
      'restScoreForThisRounds should return the correct remaining score',
      () {
        final round = Round(
          id: 1,
          index: 1,
          playerByScores: {1: 10, 2: 15, 3: 20},
        );

        final maxScoreByRound = 100;
        final expectedRestScore = 55;

        final actualRestScore = round.restScoreForThisRounds(maxScoreByRound);

        expect(actualRestScore, expectedRestScore);
      },
    );

    test(
      'restScoreForThisRounds should return 0 when all scores sum up to maxScoreByRound',
      () {
        final round = Round(id: 1, index: 1, playerByScores: {1: 50, 2: 50});

        final maxScoreByRound = 100;
        final expectedRestScore = 0;

        final actualRestScore = round.restScoreForThisRounds(maxScoreByRound);

        expect(actualRestScore, expectedRestScore);
      },
    );

    test(
      'restScoreForThisRounds should return negative value when scores exceed maxScoreByRound',
      () {
        final round = Round(id: 1, index: 1, playerByScores: {1: 60, 2: 50});

        final maxScoreByRound = 100;
        final expectedRestScore = -10;

        final actualRestScore = round.restScoreForThisRounds(maxScoreByRound);

        expect(actualRestScore, expectedRestScore);
      },
    );
  });
}
