import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:game_counter/model/game.dart';
import 'package:game_counter/modules/games/notifier.dart';
import 'package:game_counter/ui/app_setting_entry.dart';
import 'package:provider/provider.dart';

final _numeric = RegExp(r'^([0-9]*)$');

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
  final numberFocusNode = FocusNode();
  final nameTextEditingController = TextEditingController();
  final numberTextEditingController = TextEditingController();

  @override
  void dispose() {
    nameFocusNode.dispose();
    numberFocusNode.dispose();
    nameTextEditingController.dispose();
    numberTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSettingEntry(
            label: 'Nom',
            child: TextFormField(
              controller: nameTextEditingController,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  return null;
                }
                return 'Entrer un nom';
              },
              focusNode: nameFocusNode,
            ),
          ),
          AppSettingEntry(
            label: 'Nombres de joeurs',
            child: TextFormField(
              controller: nameTextEditingController,
              validator: (value) {
                if (value != null && _numeric.hasMatch(value)) {
                  final numValue = int.tryParse(value);
                  if (numValue != null && numValue >= 1 && numValue <= 10) {
                    return null;
                  }
                }
                return 'Entrer un nombre entre 1 et 10';
              },
              keyboardType: TextInputType.number,
              focusNode: nameFocusNode,
            ),
          ),
          ElevatedButton(
            onPressed: (_formKey.currentState?.validate() ?? false)
                ? () {
                    context.read<GameNotifier>().addGame(
                          Game(
                            name: nameTextEditingController.value.text,
                            numberPalyer: int.parse(
                                numberTextEditingController.value.text),
                          ),
                        );
                  }
                : null,
            child: const Text('Creer'),
          )
        ],
      ),
    );
  }
}
