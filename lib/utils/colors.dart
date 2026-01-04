import 'package:flutter/material.dart';

Color hsl(double h, double sPercent, double lPercent, {double a = 1}) {
  return HSLColor.fromAHSL(a, h, sPercent / 100, lPercent / 100).toColor();
}

ColorScheme getColors(BuildContext context) {
  return Theme.of(context).colorScheme;
}

Color colorFromHex(String input) {
  var hex = input.trim().replaceFirst('#', '').toUpperCase();

  if (hex.length == 3) {
    hex = '${hex[0]}${hex[0]}${hex[1]}${hex[1]}${hex[2]}${hex[2]}';
  }

  if (hex.length == 6) {
    hex = 'FF$hex';
  }

  if (hex.length != 8) {
    throw FormatException('Invalid hex color: $input');
  }

  return Color(int.parse(hex, radix: 16));
}
