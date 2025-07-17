import 'package:flutter/material.dart';
import 'package:score_counter/core/widgets/app_scaffold.dart';

class LoadView extends StatelessWidget {
  const LoadView();

  @override
  Widget build(BuildContext context) =>
      Center(child: CircularProgressIndicator());
}

class LoadPage extends StatelessWidget {
  const LoadPage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(title: title, body: const LoadView());
  }
}
