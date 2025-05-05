import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:score_counter/l10n/l10n.dart';
import 'package:score_counter/model/game.dart';
import 'package:score_counter/model/player.dart';
import 'package:score_counter/notifier/games.dart';

class AddGamePage extends HookConsumerWidget {
  AddGamePage({super.key});

  late final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final nameController = useTextEditingController();
    final playerNameController = useTextEditingController();
    final players = useState<List<String>>([]);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.add_game_title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: l10n.add_game_name_field,
                ),
              ),
              const SizedBox(height: 20),
              Text("${l10n.add_players}:", style: TextStyle(fontSize: 24)),
              ...players.value.map(
                (player) => Text(player, style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: playerNameController,
                      decoration: InputDecoration(
                        labelText: "${l10n.player} ${players.value.length + 1}",
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  IconButton(
                    onPressed: () {
                      final playerName = playerNameController.text;
                      if (playerName.isNotEmpty) {
                        players.value = [...players.value, playerName];
                        playerNameController.clear();
                      }
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate() &&
                      players.value.isNotEmpty) {
                    final name = nameController.text;

                    final newGame = Game(
                      id: 0,
                      name: name,
                      createDate: DateTime.now(),
                      players:
                          players.value
                              .map(
                                (player) => Player(
                                  id: 0,
                                  name: player,
                                  color: Colors.blue,
                                ),
                              )
                              .toList(),
                    );
                    ref.read(gamesProvider.notifier).createGame(newGame);

                    context.pop();
                  }
                },
                child: Text(l10n.add_game),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
