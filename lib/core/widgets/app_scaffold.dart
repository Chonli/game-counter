import 'package:flutter/material.dart';
import 'package:score_counter/core/theme/styles.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    this.actions,
    required this.body,
    this.floatingActionButton,
  });
  final String title;
  final List<Widget>? actions;
  final Widget body;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: AppStyles.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: actions,
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
