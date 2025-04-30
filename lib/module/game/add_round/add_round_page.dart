import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:score_counter/core/widgets/app_scaffold.dart';
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

    return AppScaffold(
      title: 'Ajouter un tour',
      body: switch (game) {
        AsyncData(:final value) =>
          value == null
              ? _ErrorView(error: 'Game not found')
              : _AddRoundBody(game: value),
        AsyncError() => _ErrorView(error: 'Load Game error'),
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
        child: Text('Add Round'),
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
                    Text('Score: ${round.value.playerByScores[p.id]}'),
                  ],
                ),
                isThreeLine: true,
                subtitle: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          child: Text('+1'),
                          onPressed: () {
                            round.value.addScore(p.id, 1);
                          },
                        ),
                        ElevatedButton(
                          child: Text('+5'),
                          onPressed: () {
                            round.value.addScore(p.id, 5);
                          },
                        ),
                        ElevatedButton(
                          child: Text('+10'),
                          onPressed: () {
                            round.value.addScore(p.id, 10);
                          },
                        ),
                        ElevatedButton(
                          child: Text('+50'),
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
                          child: Text('-1'),
                          onPressed: () {
                            round.value.addScore(p.id, -1);
                          },
                        ),
                        ElevatedButton(
                          child: Text('-5'),
                          onPressed: () {
                            round.value.addScore(p.id, -5);
                          },
                        ),
                        ElevatedButton(
                          child: Text('-10'),
                          onPressed: () {
                            round.value.addScore(p.id, -10);
                          },
                        ),
                        ElevatedButton(
                          child: Text('-50'),
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
