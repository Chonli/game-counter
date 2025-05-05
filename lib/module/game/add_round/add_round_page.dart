import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:score_counter/core/widgets/app_scaffold.dart';
import 'package:score_counter/l10n/l10n.dart';
import 'package:score_counter/model/game.dart';
import 'package:score_counter/model/round.dart';
import 'package:score_counter/module/game/notifier.dart';

class AddRoundPage extends HookConsumerWidget {
  const AddRoundPage({super.key, required this.gameId, required this.roundId});

  final int gameId;
  final int roundId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(currentGameProvider(gameId));
    final gameValue = game.valueOrNull;
    final l10n = context.l10n;

    return AppScaffold(
      title: l10n.add_round_title,
      body: switch (game) {
        AsyncData(:final value) =>
          value == null
              ? _ErrorView(error: l10n.add_round_error_game_not_found)
              : _AddRoundBody(game: value),
        AsyncError() => _ErrorView(error: l10n.add_round_error_load_game),
        _ => Center(child: CircularProgressIndicator()),
      },
      floatingActionButton: FloatingActionButton(
        onPressed:
            gameValue != null
                ? () {
                  // ref
                  //     .read(currentGameProvider(gameValue.id).notifier)
                  //     .addOrUpdateRound(round.value);
                  context.pop();
                }
                : null,
        child: Text(l10n.add_round_button),
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

class _AddRoundBody extends HookConsumerWidget {
  const _AddRoundBody({required this.game});

  final Game game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final players = game.players;
    final round = useState(
      Round(
        id: 0,
        index: game.rounds.length,
        playerByScores: Map.fromEntries(players.map((p) => MapEntry(p.id, 0))),
      ),
    );
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          ...players.map(
            (p) => Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(p.name),
                    Text(
                      '${l10n.add_round_score} ${round.value.playerByScores[p.id]}',
                    ),
                  ],
                ),
                isThreeLine: true,
                subtitle: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          child: Text(l10n.add_round_add_1),
                          onPressed: () {
                            round.value.addScore(p.id, 1);
                          },
                        ),
                        ElevatedButton(
                          child: Text(l10n.add_round_add_5),
                          onPressed: () {
                            round.value.addScore(p.id, 5);
                          },
                        ),
                        ElevatedButton(
                          child: Text(l10n.add_round_add_10),
                          onPressed: () {
                            round.value.addScore(p.id, 10);
                          },
                        ),
                        ElevatedButton(
                          child: Text(l10n.add_round_add_50),
                          onPressed: () {
                            round.value.addScore(p.id, 50);
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          child: Text(l10n.add_round_subtract_1),
                          onPressed: () {
                            round.value.addScore(p.id, -1);
                          },
                        ),
                        ElevatedButton(
                          child: Text(l10n.add_round_subtract_5),
                          onPressed: () {
                            round.value.addScore(p.id, -5);
                          },
                        ),
                        ElevatedButton(
                          child: Text(l10n.add_round_subtract_10),
                          onPressed: () {
                            round.value.addScore(p.id, -10);
                          },
                        ),
                        ElevatedButton(
                          child: Text(l10n.add_round_subtract_50),
                          onPressed: () {
                            round.value.addScore(p.id, -50);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
