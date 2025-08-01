import 'package:flutter/material.dart';
import 'package:score_counter/core/theme/app_spacing.dart';

class BackgroundDismiss extends StatelessWidget {
  const BackgroundDismiss({required this.alignement, super.key});

  final AlignmentGeometry alignement;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.red,
      child: Align(
        alignment: alignement,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Icon(size: 24, color: Colors.white, Icons.delete),
        ),
      ),
    );
  }
}
