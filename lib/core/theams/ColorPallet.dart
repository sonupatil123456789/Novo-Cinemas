// Extension on ColorScheme to provide custom color names
import 'package:flutter/material.dart';

// Color get accentColor => const Color(0xffFFEF00);
class ColorPalette {
  final bool isDarkMode;

  ColorPalette(this.isDarkMode);

  Color get accentColor => const Color(0xffFFEF00);
  // Color get disabledShowTimeClor => const Color(0xffFFEF001A);
  // Color get accentColor => isDarkMode ? const Color(0xffFFEF00) :const Color(0xff000000);
  Color get backGroundColor => isDarkMode
      ? const Color(0xff000000)
      : const Color(0xffFFFFFF).withBlue(500);
  Color get reverseBackGroundColor => isDarkMode
      ? const Color(0xffFFFFFF).withBlue(500)
      : const Color(0xff000000);
  Color get successColor => Colors.greenAccent;
  Color get errorColor => Colors.redAccent;
  // Color get textColor => isDarkMode ? const Color(0xff000000): const Color(0xffFFFFFF);
  Color get textColor =>
      isDarkMode ? const Color(0xffFFFFFF) : const Color(0xff000000);
  Color get onAccentTextColor => const Color(0xff000000);
  Color get disabledColor => Colors.grey.withOpacity(0.3);
  Color get blackColor => const Color(0xff000000);
  Color get whiteColor => const Color(0xffFFFFFF);
  Color get darkGreyColor => const Color(0xff464646);
  Color get lightGreyColor => const Color(0xffc0bfb8);
  Color get darkBlue => const Color(0xff1B2A33);
  Color get cardBackgroundColor =>
      isDarkMode ? const Color(0xff343434) : const Color(0xffe3e3e3);
  Color get transparentColor => Colors.transparent;

  Color get shimmerBaseColor =>
      isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
  Color get shimmerHighLightColor =>
      isDarkMode ? Colors.grey[600]! : Colors.grey[100]!;

  Color get disabledButtonColor => const Color(0xfffff6c0);
  Color get disabledErrorButtonColor => Colors.redAccent.withOpacity(0.6);
  Color get error => Colors.red;
  Color get yellowBackground => Color(0xff343100);

  List<Color> giftCard = [
    const Color(0xffFFEF00).withOpacity(0.0),
    const Color(0xffccbf00).withOpacity(0.8),
    const Color(0xff998F00).withOpacity(0.0),
  ];
}
