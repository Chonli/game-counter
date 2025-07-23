import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:score_counter/core/theme/app_spacing.dart';
import 'package:score_counter/core/widgets/app_gap.dart';
import 'package:score_counter/core/widgets/error_view.dart';
import 'package:score_counter/core/widgets/load_view.dart';
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
  AddGamePage({super.key, this.gameId});

  final int? gameId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final games = ref.watch(gamesProvider);

    final l10n = context.l10n;

    return switch (games) {
      AsyncData(:final value) => _View(
        initialGame: value.firstWhereOrNull((game) => game.id == gameId),
      ),
      AsyncError() => ErrorView(error: l10n.add_round_error_load_game),
      _ => LoadView(),
    };
  }
}

class _View extends HookConsumerWidget {
  _View({this.initialGame});

  late final _key = GlobalKey<FormState>();
  final Game? initialGame;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    // init game fields
    final nameController = useTextEditingController(text: initialGame?.name);
    final maxScoreByRoundController = useTextEditingController(
      text: initialGame?.gameOptions.maxScoreByRound.toString() ?? '',
    );
    final maxScoreController = useTextEditingController(
      text: initialGame?.gameOptions.maxScore.toString() ?? '',
    );
    final maxRoundsController = useTextEditingController(
      text: initialGame?.gameOptions.maxRounds.toString() ?? '',
    );
    final nameFocusNode = useFocusNode();
    final maxScoreByRoundFocusNode = useFocusNode();
    final maxScoreFocusNode = useFocusNode();
    final maxRoundsFocusNode = useFocusNode();
    final validateFocusNode = useFocusNode();

    // init players fields
    final indexPlayer = useState<int>(initialGame?.players.length ?? 0);
    final playerControllers = useState<List<TextEditingController>>([
      if (initialGame case final Game initialGame)
        ...initialGame.players.map(
          (player) => TextEditingController(text: player.name),
        )
      else
        TextEditingController(),
    ]);
    final playerFocusNodes = useState<List<FocusNode>>([
      if (initialGame case final Game initialGame)
        ...initialGame.players.map((player) => FocusNode())
      else
        FocusNode(),
    ]);
    final playerColors = useState<List<Color>>([
      if (initialGame case final Game initialGame)
        ...initialGame.players.map((player) => player.color)
      else
        _availableColors.first,
    ]);

    void addPlayerField({bool forceFocus = true}) {
      final newController = TextEditingController();
      final newFocusNode = FocusNode();
      playerControllers.value = [...playerControllers.value, newController];
      playerFocusNodes.value = [...playerFocusNodes.value, newFocusNode];
      playerColors.value = [
        ...playerColors.value,
        _availableColors[(indexPlayer.value + 1) % _availableColors.length],
      ];
      if (forceFocus) {
        newFocusNode.requestFocus();
      }
      indexPlayer.value++;
    }

    void deletePlayerField() {
      if (playerControllers.value.length > 1) {
        playerControllers.value.removeLast();
        playerFocusNodes.value.removeLast();
        playerColors.value.removeLast();
        playerFocusNodes.value.last.requestFocus();
        indexPlayer.value--;
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.add_game_title)),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Form(
          key: _key,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                focusNode: nameFocusNode,
                textCapitalization: TextCapitalization.sentences,
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
                  padding: EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          textCapitalization: TextCapitalization.words,
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
                      id: initialGame?.id ?? 0,
                      name: name,
                      createDate: initialGame?.createDate ?? DateTime.now(),
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
                    ref
                        .read(gamesProvider.notifier)
                        .createOrUpdateGame(newGame);

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
