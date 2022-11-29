import 'package:flutter/material.dart';

class AppColors {
  static Color black = Colors.black;
  static Color grey = Colors.grey;
  static Color primary = const Color(0xFF3B7DED);

  static Color hintColor = fromHex('#8B8B8B');
  static Color darkGreyColor = fromHex('#A1A1A1');
  static Color dullGrey = fromHex('#D9D9D9');
  static Color darkerGreyColor = fromHex('#8B8B8B');
  static Color borderGreyColor = fromHex('#D9D9D9');
  static Color borderBlueColor = fromHex('#3B7DED80');
  static Color greyColor = fromHex('#FAFAFA');
  static Color greyDarkColor = fromHex('#E6E6E6');
  static Color white = Colors.white;
  static Color red = Colors.red;
  static Color redBorder = fromHex('#FF0000');
  static Color redBackGround = fromHex('#faeded');
  static Color primaryColor = fromHex('#3B7DED');
  static Color lightBlueColor = fromHex('#F0F6FF');
  static Color drawerDividerColor = fromHex('#F0F1F5');
  static Color geryTextColor = fromHex('#666666');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
