import 'package:flutter/material.dart';

class AppColor {
  static Color blackRoot = const Color(0xFF667085);
  static Color infoRoot = const Color(0xFFD1E9FF);
  static Color whiteRoot = const Color(0xFFDADCE9);
  static Color blackFair = const Color(0xFF344054);
  static Color whiteFair = const Color(0xFFEFEFF7);
  static Color errorFair = const Color(0xFFF04438);
  static Color brPrimaryStrong = const Color(0xFF164994);
  static Color bannerDev = const Color.fromARGB(255, 255, 0, 0);
  static Color bannerUat = const Color.fromARGB(255, 255, 174, 0);
  static Color whiteSoft = const Color(0xFFE7E8F3);
  static Color blackMassive = const Color(0xFF101828);
  static Color whiteMassive = const Color(0xFFFFFFFF);
  static Color blackHeavy = const Color(0xFF1D2939);
  static Color whiteHeavy = const Color(0xFFF8F8FC);
  static Color errorHeavy = const Color(0xFFB42318);
  static Color greyTextField = const Color(0xFF667085);
  static Color greyTextFieldPrefix = colorFromHex('#DADCE9');
  static Color redCancelTransaction = colorFromHex('#F04438');
  static Color infoHeavy = const Color(0xFF175CD3);
  static Color dottedBorder = colorFromHex('#101828');
  static Color blackIcon = colorFromHex('#19202D');
  static Color blackSoft = colorFromHex('#475467');
  static Color orangeFontServiceOffline = colorFromHex('#B54708');
  static Color orangeInfoBoxServiceOffline = colorFromHex('#FEF0C7');
  static Color orangeInfoBoxAccent = colorFromHex('#F79009');

  static Color colorFromHex(String? hexColor) {
    if (hexColor == null) return Colors.black;

    try {
      hexColor = hexColor.toUpperCase().replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF$hexColor";
      }
      return Color(int.parse(hexColor, radix: 16));
    } catch (e) {
      return Colors.black;
    }
  }
}
