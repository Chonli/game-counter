import 'package:flutter/material.dart';
import 'package:game_counter/core/utils/app_gap.dart';

class AppSettingEntry extends StatelessWidget {
  const AppSettingEntry({
    Key? key,
    required this.label,
    this.child,
  }) : super(key: key);

  final String label;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        AppGap.s,
        if (child != null) child!,
      ],
    );
  }
}
