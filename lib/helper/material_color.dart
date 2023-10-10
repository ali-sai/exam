
import 'package:flutter/material.dart';

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {
    50: color.withOpacity(strengths[0]),
    100: color.withOpacity(strengths[0]),
    200: color.withOpacity(strengths[0]),
    300: color.withOpacity(strengths[0]),
    400: color.withOpacity(strengths[0]),
    500: color.withOpacity(strengths[0]),
    600: color.withOpacity(strengths[0]),
    700: color.withOpacity(strengths[0]),
    800: color.withOpacity(strengths[0]),
    900: color.withOpacity(strengths[0]),
  };
  return MaterialColor(color.value, swatch);
}
