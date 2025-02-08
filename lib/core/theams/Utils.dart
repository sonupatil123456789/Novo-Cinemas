import 'package:flutter/material.dart';
import '../localization/SetLocal.dart';
import 'ColorPallet.dart';
import 'TextTheamStyle.dart';

extension ContextExtensions on BuildContext {
  // Get the current theme
  ThemeData get theme => Theme.of(this);

  // Get whether the current theme is dark
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  // Custom color pallets
  ColorPalette get colorPalette => ColorPalette(isDarkMode);

  // Custom Text Style
  TextThemeDecoration get textThemeDecoration =>
      TextThemeDecoration(isDarkMode);

  // Get screen width as percentage
  double getScreenWidth(double percentage) {
    final screenWidth = MediaQuery.of(this).size.width;
    return screenWidth * (percentage / 100);
  }

  // Get screen height as percentage
  double getScreenHeight(double percentage) {
    final screenHeight = MediaQuery.of(this).size.height;
    return screenHeight * (percentage / 100);
  }

  // Get screen orientation
  Orientation get orientation => MediaQuery.of(this).orientation;

  // Get screen orientation
  AppLocalizations get language => AppLocalizations.of(this);

  // Check if the device is in landscape mode
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  // Check if the device is in portrait mode
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  // Get the platform (iOS, Android, Web, etc.)
  TargetPlatform get platform => Theme.of(this).platform;

  // Check if the platform is iOS
  bool get isIOS => Theme.of(this).platform == TargetPlatform.iOS;

  // Check if the platform is Android
  bool get isAndroid => Theme.of(this).platform == TargetPlatform.android;

  // Check if the platform is Web
  bool get isWeb =>
      Theme.of(this).platform ==
      TargetPlatform.fuchsia; // Web uses Fuchsia platform

  // Check if the platform is macOS
  bool get isMacOS => Theme.of(this).platform == TargetPlatform.macOS;

  // Check if the platform is Windows
  bool get isWindows => Theme.of(this).platform == TargetPlatform.windows;
}
