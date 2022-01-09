import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Games'),
      ),
      body: ListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Add Game',
        child: const Icon(Icons.add),
      ),
    );
  }
}
