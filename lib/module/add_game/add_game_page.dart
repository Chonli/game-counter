import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:score_counter/core/widgets/app_gap.dart';
import 'package:score_counter/l10n/l10n.dart';
import 'package:score_counter/model/game.dart';
import 'package:score_counter/model/game_options.dart';
import 'package:score_counter/model/player.dart';
import 'package:score_counter/notifier/games.dart';

const List<Color> _availableColors = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
  Colors.black,
];

class AddGamePage extends HookConsumerWidget {
  AddGamePage({super.key});

  late final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final nameController = useTextEditingController();
    final maxScoreByRoundController = useTextEditingController();
    final maxScoreController = useTextEditingController();
    final maxRoundsController = useTextEditingController();

    final playerControllers = useState<List<TextEditingController>>([]);
    final playerFocusNodes = useState<List<FocusNode>>([]);
    final playerColors = useState<List<Color>>([]);
    final nameFocusNode = useFocusNode();
    final maxScoreByRoundFocusNode = useFocusNode();
    final maxScoreFocusNode = useFocusNode();
    final maxRoundsFocusNode = useFocusNode();
    final validateFocusNode = useFocusNode();

    void addPlayerField({bool forceFocus = true}) {
      final newController = TextEditingController();
      final newFocusNode = FocusNode();
      playerControllers.value = [...playerControllers.value, newController];
      playerFocusNodes.value = [...playerFocusNodes.value, newFocusNode];
      playerColors.value = [...playerColors.value, _availableColors.first];
      if (forceFocus) {
        newFocusNode.requestFocus();
      }
    }

    void deletePlayerField() {
      if (playerControllers.value.length > 1) {
        playerControllers.value.removeLast();
        playerFocusNodes.value.removeLast();
        playerColors.value.removeLast();
        playerFocusNodes.value.last.requestFocus();
      }
    }

    useEffect(() {
      addPlayerField(forceFocus: false);
      nameFocusNode.requestFocus();
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
                  maxScoreByRoundFocusNode.requestFocus();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.empty_field_error;
                  }
                  return null;
                },
              ),

              AppGap.md,
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
                  IconButton(
                    onPressed: () => deletePlayerField(),
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
              ...playerControllers.value.indexed.map((entry) {
                final (index, controller) = entry;
                final focusNode = playerFocusNodes.value[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            labelText: "${l10n.player} ${index + 1}",
                          ),
                          onFieldSubmitted: (_) {
                            if (index < playerControllers.value.length - 1) {
                              playerFocusNodes.value[index + 1].requestFocus();
                            } else {
                              addPlayerField();
                              playerFocusNodes.value.last.requestFocus();
                            }
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.color_lens,
                          color: playerColors.value[index],
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(l10n.add_game_players_color),
                                content: SingleChildScrollView(
                                  child: BlockPicker(
                                    pickerColor: playerColors.value[index],
                                    availableColors: _availableColors,
                                    onColorChanged: (Color color) {
                                      playerColors.value = [
                                        ...playerColors.value.sublist(0, index),
                                        color,
                                        ...playerColors.value.sublist(
                                          index + 1,
                                        ),
                                      ];
                                    },
                                  ),
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: Text(l10n.common_ok),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
              AppGap.md,
              ExpansionTile(
                title: Text(l10n.add_game_options),
                children: [
                  TextFormField(
                    controller: maxScoreByRoundController,
                    focusNode: maxScoreByRoundFocusNode,
                    decoration: InputDecoration(
                      labelText: l10n.add_game_max_score_by_round_field,
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.numberWithOptions(),
                    onFieldSubmitted: (_) {
                      if (playerFocusNodes.value.isNotEmpty) {
                        maxScoreFocusNode.requestFocus();
                      }
                    },
                  ),
                  AppGap.md,
                  TextFormField(
                    controller: maxScoreController,
                    focusNode: maxScoreFocusNode,
                    decoration: InputDecoration(
                      labelText: l10n.add_game_max_score_field,
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.numberWithOptions(),
                    onFieldSubmitted: (_) {
                      if (playerFocusNodes.value.isNotEmpty) {
                        maxRoundsFocusNode.requestFocus();
                      }
                    },
                  ),
                  AppGap.md,
                  TextFormField(
                    controller: maxRoundsController,
                    focusNode: maxRoundsFocusNode,
                    decoration: InputDecoration(
                      labelText: l10n.add_game_max_rounds_field,
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.numberWithOptions(),
                    onFieldSubmitted: (_) {
                      playerFocusNodes.value.first.requestFocus();
                    },
                  ),
                ],
              ),
              AppGap.md,
              ElevatedButton(
                focusNode: validateFocusNode,
                onPressed: () {
                  final validPlayers = playerControllers.value.where(
                    (player) => player.text.isNotEmpty,
                  );
                  if (_key.currentState!.validate() &&
                      validPlayers.isNotEmpty) {
                    final name = nameController.text;
                    int i = 0;

                    final newGame = Game(
                      id: 0,
                      name: name,
                      createDate: DateTime.now(),
                      gameOptions: GameOptions(
                        maxScoreByRound: int.tryParse(
                          maxScoreByRoundController.text,
                        ),
                        maxScore: int.tryParse(maxScoreController.text),
                        maxRounds: int.tryParse(maxRoundsController.text),
                      ),
                      players:
                          validPlayers
                              .map(
                                (player) => Player(
                                  id: 0,
                                  name: player.text,
                                  color: playerColors.value[i++],
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
