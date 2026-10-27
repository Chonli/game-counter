import 'package:flutter/material.dart'; // For Material widgets
import 'package:score_counter/core/widgets/app_scaffold.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error, style: TextStyle(fontSize: 20, color: Colors.blue)),
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.error, required this.title});

  final String error;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: title,
      body: ErrorView(error: error),
    );
  }
}
