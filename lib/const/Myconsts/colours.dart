import 'package:flutter/material.dart';

class Mycolours {
  final lb = Colors.blue.withOpacity(0.5);
  final lightblack = Colors.black.withOpacity(0.3);
  final darkblue = const Color.fromARGB(255, 45, 119, 247).withOpacity(0.7);
  final darkorage = const Color.fromARGB(255, 244, 133, 157).withOpacity(0.5);
  final lightgrey = Colors.grey.withOpacity(1);
  final lg = Colors.grey.withOpacity(0.25);
  final ligthgreen = HexColor("#25D366").withOpacity(0.7);
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
