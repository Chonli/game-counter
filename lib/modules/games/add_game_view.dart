import 'package:flutter/material.dart';
import 'package:game_counter/core/ui/app_setting_entry.dart';
import 'package:game_counter/core/ui/app_text_field.dart';
import 'package:game_counter/core/utils/app_gap.dart';
import 'package:game_counter/core/utils/app_spacing.dart';
import 'package:game_counter/model/game.dart';
import 'package:game_counter/model/player.dart';
import 'package:game_counter/model/score.dart';
import 'package:game_counter/modules/games/notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

//final _numeric = RegExp(r'^([0-9]*)$');

class AddGameView extends StatefulWidget {
  const AddGameView({
    Key? key,
  }) : super(key: key);

  @override
  State<AddGameView> createState() => AddGameViewState();
}

class AddGameViewState extends State<AddGameView> {
  final _formKey = GlobalKey<FormState>();

  final nameFocusNode = FocusNode();
  final nameTextEditingController = TextEditingController();
  final _playerFields = <TextEditingController, AppTextField>{};

  void _addField() {
    if (_playerFields.length < 10) {
      final controller = TextEditingController();
      final field = AppTextField(
        controller: controller,
      );
      setState(() {
        _playerFields[controller] = field;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _addField();
    _addField();
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    nameTextEditingController.dispose();
    for (final c in _playerFields.keys) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creation jeu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.m),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSettingEntry(
                label: 'Nom',
                child: AppTextField(
                  controller: nameTextEditingController,
                  onChanged: (value) => setState(() {}),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      return null;
                    }
                    return 'Entrer un nom';
                  },
                ),
              ),
              AppGap.m,
              AppSettingEntry(
                  label: 'Liste des joueurs',
                  child: Column(
                    children: [
                      ..._playerFields.values,
                    ],
                  )),
              InkWell(
                onTap: () => _addField(),
                child: const Text(
                  'Ajouter un joueur',
                ),
              ),
              AppGap.m,
              ElevatedButton(
                onPressed: (_formKey.currentState?.validate() ?? false)
                    ? () {
                        const uuid = Uuid();
                        context.read<GameNotifier>().addGame(
                              Game(
                                id: uuid.v4(),
                                name: nameTextEditingController.value.text,
                                players: _playerFields.entries
                                    .where((e) => e.key.text.isNotEmpty)
                                    .map<Player>((e) => Player(
                                          id: uuid.v4(),
                                          name: e.key.text,
                                          score: Score(),
                                        ))
                                    .toList(),
                                date: DateTime.now(),
                              ),
                            );
                        context.pop();
                      }
                    : null,
                child: const Text('Creer'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
