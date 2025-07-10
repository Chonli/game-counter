import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:score_counter/core/widgets/app_scaffold.dart';
import 'package:score_counter/l10n/l10n.dart';
import 'package:score_counter/model/game.dart';
import 'package:score_counter/model/round.dart';
import 'package:score_counter/module/game/notifier.dart';

part 'add_round_page.g.dart';

@riverpod
class _CurrentRound extends _$CurrentRound {
  @override
  Round build(Round round) {
    return round;
  }

  void addScore(int playerId, int score) {
    final playerByScores = {...state.playerByScores};
    playerByScores[playerId] = score + (playerByScores[playerId] ?? 0);

    state = state.copyWith(playerByScores: playerByScores);
  }
}

class AddRoundPage extends HookConsumerWidget {
  const AddRoundPage({super.key, required this.gameId, required this.roundId});

  final int gameId;
  final int? roundId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(currentGameProvider(gameId));

    final l10n = context.l10n;

    return switch (game) {
      AsyncData(:final value) =>
        value == null
            ? _ErrorView(error: l10n.add_round_error_game_not_found)
            : _AddRoundBody(
              game: value,
              initRound:
                  value.rounds.firstWhereOrNull((r) => r.id == roundId) ??
                  Round(
                    id: 0,
                    index: value.rounds.length,
                    playerByScores: Map.fromEntries(
                      value.players.map((p) => MapEntry(p.id, 0)),
                    ),
                  ),
            ),
      AsyncError() => _ErrorView(error: l10n.add_round_error_load_game),
      _ => _LoadView(),
    };
  }
}

class _AddRoundBody extends HookConsumerWidget {
  const _AddRoundBody({required this.game, required this.initRound});

  final Game game;
  final Round initRound;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    final round = ref.watch(_currentRoundProvider(initRound));

    return AppScaffold(
      title: l10n.add_round_title,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ...game.players.map(
              (p) => Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        p.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: p.color,
                        ),
                      ),
                      Text(
                        '${l10n.add_round_score} ${round.playerByScores[p.id]}',
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
                              ref
                                  .read(
                                    _currentRoundProvider(initRound).notifier,
                                  )
                                  .addScore(p.id, 1);
                            },
                          ),
                          ElevatedButton(
                            child: Text(l10n.add_round_add_5),
                            onPressed: () {
                              ref
                                  .read(
                                    _currentRoundProvider(initRound).notifier,
                                  )
                                  .addScore(p.id, 5);
                            },
                          ),
                          ElevatedButton(
                            child: Text(l10n.add_round_add_10),
                            onPressed: () {
                              ref
                                  .read(
                                    _currentRoundProvider(initRound).notifier,
                                  )
                                  .addScore(p.id, 10);
                            },
                          ),
                          ElevatedButton(
                            child: Text(l10n.add_round_add_50),
                            onPressed: () {
                              ref
                                  .read(
                                    _currentRoundProvider(initRound).notifier,
                                  )
                                  .addScore(p.id, 50);
                            },
                          ),
                          if (game.hasMaxScoreByRound)
                            ElevatedButton(
                              child: Text(l10n.add_round_add_rest),
                              onPressed: () {
                                final rest = initRound.restScoreForThisRounds(
                                  game.maxScoreByRound ?? 0,
                                );

                                ref
                                    .read(
                                      _currentRoundProvider(initRound).notifier,
                                    )
                                    .addScore(p.id, rest);
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
                              ref
                                  .read(
                                    _currentRoundProvider(initRound).notifier,
                                  )
                                  .addScore(p.id, -1);
                            },
                          ),
                          ElevatedButton(
                            child: Text(l10n.add_round_subtract_5),
                            onPressed: () {
                              ref
                                  .read(
                                    _currentRoundProvider(initRound).notifier,
                                  )
                                  .addScore(p.id, -5);
                            },
                          ),
                          ElevatedButton(
                            child: Text(l10n.add_round_subtract_10),
                            onPressed: () {
                              ref
                                  .read(
                                    _currentRoundProvider(initRound).notifier,
                                  )
                                  .addScore(p.id, -10);
                            },
                          ),
                          ElevatedButton(
                            child: Text(l10n.add_round_subtract_50),
                            onPressed: () {
                              ref
                                  .read(
                                    _currentRoundProvider(initRound).notifier,
                                  )
                                  .addScore(p.id, -50);
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref
              .read(currentGameProvider(game.id).notifier)
              .addOrUpdateRound(round);
          context.pop();
        },

        child: Icon(Icons.check),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppScaffold(
      title: l10n.add_round_title,
      body: Center(child: Text(error)),
    );
  }
}

class _LoadView extends StatelessWidget {
  const _LoadView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppScaffold(
      title: l10n.add_round_title,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
