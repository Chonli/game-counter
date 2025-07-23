import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:score_counter/core/theme/app_spacing.dart';
import 'package:score_counter/core/widgets/app_scaffold.dart';
import 'package:score_counter/core/widgets/background_dismiss.dart';
import 'package:score_counter/core/widgets/error_view.dart';
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
      actions: [
        IconButton(
          icon: Icon(Icons.bar_chart),
          onPressed: () {
            context.pushNamed(
              AppRoute.chart.name,
              pathParameters: {'gameId': gameId.toString()},
            );
          },
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: switch (currentGame) {
          AsyncData(:final value) =>
            value == null
                ? ErrorView(error: l10n.game_not_found)
                : _GameResultTable(game: value),
          AsyncError() => ErrorView(error: l10n.load_game_error),
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

class _GameResultTable extends HookConsumerWidget {
  const _GameResultTable({required this.game});

  final Game game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: game.rounds.length + 2, // +1 for header, +1 for total
            (context, index) {
              if (index == 0) {
                // Header row
                return DecoratedBox(
                  decoration: BoxDecoration(
                    border: BoxBorder.fromLTRB(
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xs),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                          game.players.map((player) {
                            return Text(
                              player.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: player.color,
                              ),
                              textAlign: TextAlign.center,
                            );
                          }).toList(),
                    ),
                  ),
                );
              } else if (index == game.rounds.length + 1) {
                // Total row
                return Padding(
                  padding: const EdgeInsets.all(AppSpacing.xs),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:
                        game.players.map((player) {
                          return Text(
                            player.totalScore.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          );
                        }).toList(),
                  ),
                );
              } else {
                // Data rows
                final roundIndex = index - 1;
                final round = game.rounds[roundIndex];

                return DecoratedBox(
                  decoration: BoxDecoration(
                    border: BoxBorder.fromLTRB(
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: Dismissible(
                    key: Key('${round.id}'),
                    background: BackgroundDismiss(
                      alignement: AlignmentDirectional.centerStart,
                    ),
                    secondaryBackground: BackgroundDismiss(
                      alignement: AlignmentDirectional.centerEnd,
                      type: DismissType.update,
                    ),
                    confirmDismiss:
                        (direction) =>
                            direction == DismissDirection.endToStart
                                ? context.pushNamed(
                                  AppRoute.addRound.name,
                                  pathParameters: {
                                    'gameId': game.id.toString(),
                                    'roundId': round.id.toString(),
                                  },
                                )
                                : showDialog(
                                  context: context,
                                  builder:
                                      (context) => AlertDialog(
                                        title: Text(l10n.delete_game),
                                        content: Text(
                                          l10n.delete_game_confirmation,
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => context.pop(),
                                            child: Text(l10n.common_cancel),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              ref
                                                  .read(
                                                    currentGameProvider(
                                                      game.id,
                                                    ).notifier,
                                                  )
                                                  .removeRound(round);

                                              context.pop();
                                            },
                                            child: Text(l10n.common_delete),
                                          ),
                                        ],
                                      ),
                                ),

                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xs),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:
                            game.players.map((player) {
                              final score =
                                  round.playerByScores[player.id] ?? 0;
                              return Text(
                                score.toString(),
                                textAlign: TextAlign.center,
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
