import 'package:flutter/material.dart';
import 'package:game_counter/model/game.dart';

class GameDetails extends StatelessWidget {
  const GameDetails({
    Key? key,
    required this.game,
  }) : super(key: key);

  final Game game;

  @override
  Widget build(BuildContext context) {
    final players = game.players;
    return Scaffold(
      appBar: AppBar(),
      body: DataTable(
        columns: <DataColumn>[
          ...players.map(
            (player) => DataColumn(
              label: Text(
                player.name,
              ),
            ),
          ),
        ],
        rows: <DataRow>[
          for (int i = 0; i < game.numberTurn; i++) ...[
            DataRow(
              cells: <DataCell>[
                ...players.map(
                  (p) {
                    final val = p.score.turns[i];
                    return DataCell(Text('$val'));
                  },
                ),
              ],
            ),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {}, //context.goNamed(AppRoutes.addTurns.name),
        tooltip: 'Ajout tour',
        child: const Icon(Icons.add),
      ),
    );
  }
}
