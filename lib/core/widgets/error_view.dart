import 'package:flutter/widgets.dart';
import 'package:score_counter/core/widgets/app_scaffold.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(error));
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({required this.error, required this.title});

  final String error;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(title: title, body: ErrorView(error: error));
  }
}
