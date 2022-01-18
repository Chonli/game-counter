import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:game_counter/model/game.dart';
import 'package:game_counter/modules/game_details/notifier.dart';
import 'package:provider/provider.dart';

class GameDetailsView extends StatelessWidget {
  const GameDetailsView({
    Key? key,
    required this.game,
  }) : super(key: key);

  final Game game;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameDetailNotifier(
        context.read,
        game,
      ),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final game = context.select<GameDetailNotifier, Game>((n) => n.game);
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
        onPressed: () {
          final faker = Faker();
          for (int i = 0; i < players.length; i++) {
            game.players.elementAt(i).score.turns.add(
                  faker.randomGenerator.integer(50),
                );
          }
          context.read<GameDetailNotifier>().game = game;
        }, //context.goNamed(AppRoutes.addTurns.name),
        tooltip: 'Ajout tour',
        child: const Icon(Icons.add),
      ),
    );
  }
}
