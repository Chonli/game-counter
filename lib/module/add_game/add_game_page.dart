import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:score_counter/l10n/l10n.dart';
import 'package:score_counter/model/game.dart';
import 'package:score_counter/notifier/games.dart';

class AddGamePage extends ConsumerStatefulWidget {
  const AddGamePage({super.key});

  @override
  ConsumerState<AddGamePage> createState() => _AddGamePageState();
}

class _AddGamePageState extends ConsumerState<AddGamePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _scoreController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _scoreController.dispose();
    super.dispose();
  }

  void _addGame() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final score = int.tryParse(_scoreController.text) ?? 0;

      final newGame = Game(id: 0, name: name, createDate: DateTime.now());
      ref.read(gamesProvider.notifier).addGame(newGame);

      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.add_game_title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: l10n.add_game_name_field,
                ),
              ),

              const SizedBox(height: 20),
              ElevatedButton(onPressed: _addGame, child: Text(l10n.add_game)),
            ],
          ),
        ),
      ),
    );
  }
}
