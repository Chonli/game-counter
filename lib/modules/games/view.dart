import 'package:flutter/material.dart';
import 'package:game_counter/model/game.dart';
import 'package:game_counter/modules/games/notifier.dart';
import 'package:provider/provider.dart';

class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameNotifier(),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View({
    Key? key,
  }) : super(key: key);

  Future<void> _addGame(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return const _AddGameView();
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Games'),
      ),
      body: ListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addGame(context),
        tooltip: 'Add Game',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _AddGameView extends StatefulWidget {
  const _AddGameView({
    Key? key,
  }) : super(key: key);

  @override
  State<_AddGameView> createState() => _AddGameViewState();
}

class _AddGameViewState extends State<_AddGameView> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Ajouter un jeu'),
      children: <Widget>[
        ElevatedButton(
          onPressed: () => context.read<GameNotifier>().addGame(Game(
                name: 'test',
                numberPalyer: 4,
              )),
          child: const Text('Creer'),
        )
      ],
    );
  }
}
