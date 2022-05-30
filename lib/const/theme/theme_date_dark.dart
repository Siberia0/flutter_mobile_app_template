import 'package:flutter/material.dart';

import '../app_color.dart';

/// Define dark theme settings
final ThemeData themeDataDark = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColor.primary,
    secondary: AppColor.accent,
    tertiary: AppColor.text,
    error: AppColor.alert,
    onPrimary: AppColor.accent,
    surface: AppColor.primary,
    onSurface: AppColor.text,
    background: AppColor.base,
    onSecondary: AppColor.primary,
    onError: AppColor.alert,
    onBackground: AppColor.accent,
  ),
  appBarTheme: const AppBarTheme(
    foregroundColor: AppColor.base,
    backgroundColor: AppColor.accent,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 96.0,
      fontWeight: FontWeight.normal,
      letterSpacing: -1.5,
    ),
    headline2: TextStyle(
      fontSize: 60.0,
      fontWeight: FontWeight.normal,
      letterSpacing: -0.5,
    ),
    headline3: TextStyle(
      fontSize: 48.0,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.0,
    ),
    headline4: TextStyle(
      fontSize: 34.0,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.25,
    ),
    headline5: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.0,
    ),

    /// AppBar and AlertDialog title
    headline6: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.15,
    ),

    /// DrawerHeader child and ListTile title in Drawer, and etc.
    bodyText1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.5,
    ),

    /// Normal text
    bodyText2: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.25,
    ),

    /// ListTile title
    subtitle1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.15,
    ),
    subtitle2: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.1,
    ),

    /// Text on buttons
    button: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.25,
    ),
    caption: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.4,
    ),
    overline: TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.normal,
      letterSpacing: 1.5,
    ),
  ),
);
