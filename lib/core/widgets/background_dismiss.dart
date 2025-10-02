import 'package:flutter/material.dart';
import 'package:score_counter/core/theme/app_spacing.dart';

enum DismissType { delete, update }

class BackgroundDismiss extends StatelessWidget {
  const BackgroundDismiss({
    required this.alignement,
    super.key,
    this.type = DismissType.delete,
  });

  final AlignmentGeometry alignement;
  final DismissType type;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: type == DismissType.delete ? Colors.red : Colors.green,
      child: Align(
        alignment: alignement,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Icon(
            size: 24,
            color: Colors.white,
            type == DismissType.delete ? Icons.delete : Icons.edit,
          ),
        ),
      ),
    );
  }
}
