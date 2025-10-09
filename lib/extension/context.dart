import 'package:flutter/material.dart';
import 'package:score_counter/l10n/l10n.dart';

extension ContextExtension on BuildContext {
  Future<T?> showPopup<T>({
    required String title,
    required String message,
    List<Widget>? actions,
  }) => showDialog(
    context: this,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions:
            actions ??
            <Widget>[
              TextButton(
                child: Text(context.l10n.common_ok),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
      );
    },
  );
}
