import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score_counter/l10n/l10n.dart';
import 'package:score_counter/notifier/games.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final gamesAsyncValue = ref.watch(gamesProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(l10n.home_title),
      ),
      body: gamesAsyncValue.when(
        data: (games) {
          if (games.isEmpty) {
            return Center(child: Text(l10n.no_games));
          }
          return ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              final game = games[index];
              return ListTile(
                title: Text(game.name),
                subtitle: Text(game.createDate.toString()),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(l10n.error_loading_games)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: l10n.add_game,
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
