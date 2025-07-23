import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:score_counter/core/widgets/app_scaffold.dart';
import 'package:score_counter/core/widgets/background_dismiss.dart';
import 'package:score_counter/l10n/l10n.dart';
import 'package:score_counter/model/game.dart';
import 'package:score_counter/notifier/games.dart';
import 'package:score_counter/router/app_route.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppScaffold(
      title: l10n.home_title,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            context.pushNamed(AppRoute.preferences.name);
          },
        ),
      ],
      body: Consumer(
        builder: (context, ref, _) {
          final games = ref.watch(gamesProvider);
          if (games.isEmpty) {
            return Center(child: Text(l10n.no_games));
          }

          return ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) => _ListGameTile(games[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AppRoute.addGame.name);
        },
        tooltip: l10n.add_game,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ListGameTile extends ConsumerWidget {
  const _ListGameTile(this.game);

  final Game game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return Dismissible(
      key: Key(game.id.toString()),
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
                    AppRoute.updateGame.name,
                    pathParameters: {'gameId': game.id.toString()},
                  )
                  : showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: Text(l10n.delete_game),
                          content: Text(l10n.delete_game_confirmation),
                          actions: [
                            TextButton(
                              onPressed: () => context.pop(),
                              child: Text(l10n.common_cancel),
                            ),
                            TextButton(
                              onPressed: () {
                                ref
                                    .read(gamesProvider.notifier)
                                    .removeGame(game.id);
                                context.pop();
                              },
                              child: Text(l10n.common_delete),
                            ),
                          ],
                        ),
                  ),
      child: ListTile(
        title: Text(game.name),
        subtitle: Text(game.createDate.toString()),
        onTap: () {
          context.pushNamed(
            AppRoute.activeGame.name,
            pathParameters: {'gameId': game.id.toString()},
          );
        },
      ),
    );
  }
}
