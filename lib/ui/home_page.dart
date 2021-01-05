import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  void _addGame() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Games'),
      ),
      body: ListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addGame,
        tooltip: 'Add Game',
        child: Icon(Icons.add),
      ),
    );
  }
}
