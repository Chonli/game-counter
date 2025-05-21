import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:score_counter/core/widgets/app_scaffold.dart';
import 'package:score_counter/l10n/l10n.dart';
import 'package:score_counter/model/game.dart';
import 'package:score_counter/module/game/notifier.dart';
import 'package:score_counter/router/app_route.dart';

class ActiveGamePage extends HookConsumerWidget {
  const ActiveGamePage({super.key, required this.gameId});

  final int gameId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentGame = ref.watch(currentGameProvider(gameId));
    final l10n = context.l10n;

    return AppScaffold(
      title: l10n.active_game_title,

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: switch (currentGame) {
          AsyncData(:final value) =>
            value == null
                ? _ErrorView(error: l10n.game_not_found)
                : _GameResultTable(game: value),
          AsyncError() => _ErrorView(error: l10n.load_game_error),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(
            AppRoute.addRound.name,
            pathParameters: {'gameId': gameId.toString(), 'roundId': '-1'},
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(error));
  }
}

class _GameResultTable extends StatelessWidget {
  const _GameResultTable({required this.game});

  final Game game;

  @override
  Widget build(BuildContext context) {
    final totalScore = List.filled(game.players.length, 0);
    final indexedPlayers = game.players.indexed;

    return Table(
      border: TableBorder(
        horizontalInside: BorderSide(width: 1, color: Colors.grey),
      ),
      children: [
        TableRow(
          children: <Widget>[
            ...game.players.map(
              (player) => Text(
                player.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        ...game.rounds.map(
          (round) => TableRow(
            children: <Widget>[
              ...indexedPlayers.map((player) {
                final score = round.playerByScores[player.$2.id] ?? 0;
                totalScore[player.$1] += score;
                return Text(score.toString());
              }),
            ],
          ),
        ),
        // total row
        TableRow(
          children: <Widget>[
            ...indexedPlayers.map(
              (player) => Text(
                totalScore[player.$1].toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );

    //   rows: [
    //     ...game.rounds.map(
    //       (round) => DataRow(
    //         cells: [
    //           ...indexedPlayers.map((player) {
    //             final score = round.playerByScores[player.$2.id] ?? 0;
    //             totalScore[player.$1] += score;
    //             return DataCell(Text(score.toString()));
    //           }),
    //         ],
    //       ),
    //     ),
    //     // total row
    //     DataRow(
    //       cells: [
    //         ...indexedPlayers.map(
    //           (player) => DataCell(
    //             Text(
    //               totalScore[player.$1].toString(),
    //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ],
    // );
  }
}
