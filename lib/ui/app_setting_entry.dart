import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
        const Gap(8),
        if (child != null) child!,
      ],
    );
  }
}
