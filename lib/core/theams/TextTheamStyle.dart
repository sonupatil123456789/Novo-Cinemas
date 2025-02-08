import 'dart:ui';
import 'package:flutter/material.dart';

class TextThemeDecoration {
  final bool isDarkMode;

  TextThemeDecoration(this.isDarkMode);

  static String HamburgerFont = 'HamburgHand';
  static String Din = 'DIN';

  TextStyle get titleLarge => TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: HamburgerFont,
        color: isDarkMode ? const Color(0xffFFFFFF) : const Color(0xff000000),
        fontSize: 20,
      );

  TextStyle get titleMedium => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: HamburgerFont,
        color: isDarkMode ? const Color(0xffFFFFFF) : const Color(0xff000000),
        fontSize: 18,
      );

  TextStyle titleSmallWithFontWeight({FontWeight? fontWeight}) {
    return titleSmall.copyWith(
      fontWeight: fontWeight ?? titleSmall.fontWeight,
    );
  }

  TextStyle get titleSmall => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: HamburgerFont,
        color: isDarkMode ? const Color(0xffFFFFFF) : const Color(0xff000000),
        fontSize: 16,
      );

  TextStyle get subTitleLarge => TextStyle(
        fontWeight: FontWeight.w700,
        fontFamily: Din,
        color: isDarkMode ? const Color(0xffFFFFFF) : const Color(0xff000000),
        fontSize: 15,
      );

  TextStyle get subTitleMedium => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: Din,
        color: isDarkMode ? const Color(0xffFFFFFF) : const Color(0xff000000),
        fontSize: 14,
      );

  TextStyle get subTitleSmall => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: Din,
        color: isDarkMode ? const Color(0xffFFFFFF) : const Color(0xff000000),
        fontSize: 13,
      );

  TextStyle get paragraphLarge => TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: Din,
        color: isDarkMode ? const Color(0xffFFFFFF) : const Color(0xff000000),
        fontSize: 12,
      );

  TextStyle get paragraphMedium => TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: Din,
        color: isDarkMode ? const Color(0xffFFFFFF) : const Color(0xff000000),
        fontSize: 11,
      );

  TextStyle get paragraphSmall => TextStyle(
        fontWeight: FontWeight.w300,
        fontFamily: Din,
        color: isDarkMode ? const Color(0xffFFFFFF) : const Color(0xff000000),
        fontSize: 10,
      );
}
