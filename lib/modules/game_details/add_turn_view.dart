import 'package:flutter/material.dart';
import 'package:game_counter/model/game.dart';
import 'package:game_counter/model/player.dart';

class AddTurnView extends StatelessWidget {
  const AddTurnView({Key? key, required this.game}) : super(key: key);

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajout point du tour'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ...game.players.map((player) => _AddPointView(player: player)),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Valider'),
          ),
        ]),
      ),
    );
  }
}

class _AddPointView extends StatelessWidget {
  const _AddPointView({Key? key, required this.player}) : super(key: key);

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${player.name}:'),
        TextFormField(),
      ],
    );
  }
}
