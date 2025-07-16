import 'package:flutter/widgets.dart';

class AppStyles {
  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}

extension TextStyleExtension on TextStyle {
  TextStyle get normal => copyWith(fontWeight: FontWeight.normal);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w500);
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle withOpacity(double opacity) =>
      copyWith(color: color?.withAlpha((opacity * 255).toInt()));
}
