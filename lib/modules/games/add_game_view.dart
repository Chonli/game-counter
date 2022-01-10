import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_counter/core/ui/app_setting_entry.dart';
import 'package:game_counter/model/game.dart';
import 'package:game_counter/modules/games/notifier.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creation jeu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSettingEntry(
                label: 'Nom',
                child: TextFormField(
                  controller: nameTextEditingController,
                  onChanged: (value) => setState(() {}),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      return null;
                    }
                    return 'Entrer un nom';
                  },
                  focusNode: nameFocusNode,
                ),
              ),
              const Gap(12),
              AppSettingEntry(
                label: 'Nombres de joeurs',
                child: TextFormField(
                  controller: numberTextEditingController,
                  onChanged: (value) => setState(() {}),
                  validator: (value) {
                    if (value != null && _numeric.hasMatch(value)) {
                      final numValue = int.tryParse(value);
                      if (numValue != null && numValue >= 1 && numValue <= 10) {
                        return null;
                      }
                    }
                    return 'Entrer un nombre entre 1 et 10';
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  focusNode: numberFocusNode,
                ),
              ),
              const Gap(12),
              ElevatedButton(
                onPressed: (_formKey.currentState?.validate() ?? false)
                    ? () {
                        context.read<GameNotifier>().addGame(
                              Game(
                                name: nameTextEditingController.value.text,
                                numberPalyer: int.parse(
                                  numberTextEditingController.value.text,
                                ),
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
