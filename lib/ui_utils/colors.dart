import 'package:flutter/material.dart';

class BColors {
  static const Color white = Colors.white;
  static const Color transparent = Colors.transparent;
  static const Color blue = Color(0xff2785FC);
  static Color backgroundBlue = Color(0xffD3D3D3).withOpacity(0.12);
      //Color(0xff2785FC).withOpacity(0.06);
  static Color cardBackground = Color(0xfff9f9f9);
  static const Color blueAccent = Colors.blueAccent;
  static const Color lightBlue = Colors.lightBlue;
  //static Color dropDownBlue = Color.fromRGBO(39, 133, 252, 0.85);
  static Color dropDownBlue = Colors.lightBlue.withOpacity(0.85);
  static Color activeCardColor = Colors.lightBlue.withOpacity(0.15);
  static const Color red = Colors.red;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color green = Colors.green;
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
