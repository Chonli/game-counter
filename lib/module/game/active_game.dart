import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:score_counter/core/widgets/app_scaffold.dart';
import 'package:score_counter/model/game.dart';
import 'package:score_counter/module/game/notifier.dart';
import 'package:score_counter/router/app_route.dart';

class ActiveGamePage extends HookConsumerWidget {
  const ActiveGamePage({super.key, required this.gameId});

  final int gameId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentGame = ref.watch(currentGameProvider(gameId));

    return AppScaffold(
      title: 'Active Game',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: switch (currentGame) {
          AsyncData(:final value) =>
            value == null
                ? const _ErrorView(error: 'Game not found')
                : _GameResultTable(game: value),
          AsyncError() => const _ErrorView(error: 'Load Game error'),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AppRoute.addRound.name);
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

    return DataTable(
      columns:
          game.players
              .map((player) => DataColumn(label: Text(player.name)))
              .toList(),

      rows: [
        ...game.rounds.map(
          (round) => DataRow(
            cells: [
              ...indexedPlayers.map((player) {
                final score = round.playerByScores[player.$2.id] ?? 0;
                totalScore[player.$1] += score;
                return DataCell(Text(score.toString()));
              }),
            ],
          ),
        ),
        // total row
        DataRow(
          cells: [
            ...indexedPlayers.map(
              (player) => DataCell(Text(totalScore[player.$1].toString())),
            ),
          ],
        ),
      ],
    );
  }
}
