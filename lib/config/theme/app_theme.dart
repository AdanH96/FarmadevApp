import 'package:flutter/material.dart';

class AppTheme {
  int defaultColor = 6;
  int? colorSeleccionado;
  final List colorTheme = [
    Colors.amber,
    Colors.blue,
    Colors.blueGrey,
    Colors.brown,
    Colors.cyan,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.green,
    Colors.grey,
    Colors.indigo,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.lime,
  ];
  void incrementarColor() {
    if (colorSeleccionado != null) {
      colorSeleccionado = colorSeleccionado! + 1;
    }
  }

  void disminuirColor() {
    if (colorSeleccionado != null) {
      colorSeleccionado = colorSeleccionado! - 1;
    }
  }

  ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: colorTheme[colorSeleccionado ?? defaultColor],
    );
  }
}
