import 'package:flutter/material.dart';

Color hsl(double h, double sPercent, double lPercent, {double a = 1}) {
  return HSLColor.fromAHSL(a, h, sPercent / 100, lPercent / 100).toColor();
}