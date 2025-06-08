import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:score_counter/model/game.dart';
import 'package:score_counter/module/game/notifier.dart';

class ChartPage extends HookConsumerWidget {
  const ChartPage({super.key, required this.gameId});

  final int gameId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentGame = ref.watch(currentGameProvider(gameId));

    return Scaffold(
      appBar: AppBar(title: Text('Chart')),
      body: currentGame.when(
        data:
            (game) =>
                game == null
                    ? Center(child: Text('Game not found'))
                    : _ChartView(game: game),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error loading game')),
      ),
    );
  }
}

class _ChartView extends StatelessWidget {
  const _ChartView({required this.game});

  final Game game;

  @override
  Widget build(BuildContext context) {
    final indexedPlayers = game.players.indexed;

    if (indexedPlayers.isEmpty) {
      return SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData:
              indexedPlayers.map((player) {
                int totalScore = 0;
                final playerScores = List.generate(game.rounds.length, (index) {
                  totalScore +=
                      game.rounds[index].playerByScores[player.$2.id] ?? 0;

                  return totalScore;
                });

                return LineChartBarData(
                  spots:
                      playerScores.asMap().entries.map((entry) {
                        return FlSpot(
                          entry.key.toDouble(),
                          entry.value.toDouble(),
                        );
                      }).toList(),
                  // TODO: use player color
                  color: Colors.primaries[player.$1 % Colors.primaries.length],
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: true),
                  belowBarData: BarAreaData(show: false),
                );
              }).toList(),
        ),
      ),
    );
  }
}
