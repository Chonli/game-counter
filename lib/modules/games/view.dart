import 'package:flutter/material.dart';
import 'package:game_counter/core/router.dart';
import 'package:game_counter/model/game.dart';
import 'package:game_counter/modules/games/notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GameView extends StatelessWidget {
  const GameView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final games = context.select<GameNotifier, Iterable<Game>>((n) => n.games);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Games'),
      ),
      body: Center(
        child: Expanded(
          child: ListView.builder(
            itemCount: games.length,
            itemBuilder: (BuildContext context, int index) {
              final game = games.elementAt(index);
              final dateFormat = DateFormat.yMMMMd();
              return ListTile(
                title: Text(game.name),
                subtitle: Text(dateFormat.format(game.date)),
                // trailing: Row(
                //   children: [
                //     const Icon(
                //       Icons.person,
                //       size: 20,
                //     ),
                //     Text('${game.numberPalyer}'),
                //   ],
                // ),
                onTap: () {},
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed(AppRoutes.createGame.name),
        tooltip: 'Add Game',
        child: const Icon(Icons.add),
      ),
    );
  }
}
