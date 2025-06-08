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
    final playerControllers = useState<List<TextEditingController>>([]);
    final playerFocusNodes = useState<List<FocusNode>>([]);
    final nameFocusNode = useFocusNode();

    // Function to add a new player field
    void addPlayerField() {
      final newController = TextEditingController();
      final newFocusNode = FocusNode();
      playerControllers.value = [...playerControllers.value, newController];
      playerFocusNodes.value = [...playerFocusNodes.value, newFocusNode];
    }

    // Call addPlayerField once at the first build
    useEffect(() {
      addPlayerField();
      return null;
    }, const []);

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
                focusNode: nameFocusNode,
                decoration: InputDecoration(
                  labelText: l10n.add_game_name_field,
                ),
                onFieldSubmitted: (_) {
                  // Move focus to the first player field when the name field is submitted
                  if (playerFocusNodes.value.isNotEmpty) {
                    playerFocusNodes.value.first.requestFocus();
                  }
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      "${l10n.add_players}:",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  IconButton(
                    onPressed: () => addPlayerField(),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              ...playerControllers.value.indexed.map((entry) {
                final (index, controller) = entry;
                final focusNode = playerFocusNodes.value[index];
                return Padding(
                  padding: EdgeInsetsGeometry.only(bottom: 10),
                  child: TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      labelText: "${l10n.player} ${index + 1}",
                    ),
                    onFieldSubmitted: (_) {
                      // Move focus to the next player field or add a new one if it's the last field
                      if (index < playerControllers.value.length - 1) {
                        playerFocusNodes.value[index + 1].requestFocus();
                      } else {
                        addPlayerField();
                        playerFocusNodes.value.last.requestFocus();
                      }
                    },
                  ),
                );
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate() &&
                      playerControllers.value.isNotEmpty) {
                    final name = nameController.text;

                    final newGame = Game(
                      id: 0,
                      name: name,
                      createDate: DateTime.now(),
                      players:
                          playerControllers.value
                              .map(
                                (controller) => Player(
                                  id: 0,
                                  name: controller.text,
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
