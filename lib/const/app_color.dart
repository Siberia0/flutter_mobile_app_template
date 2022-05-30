import 'package:flutter/cupertino.dart';

class AppColor {
  static bool get isDarkTheme =>
      WidgetsBinding.instance.window.platformBrightness == Brightness.dark;

  static const Color primary = Color(0xFF2196F3);
  static const Color accent = Color(0xFF0D47A1);
  static const Color base = Color(0xFFFFFFFF);
  static const Color grayScale = Color(0xFF707070);
  static const Color alert = Color(0xFFD50000);

  static const Color text = Color(0xFF333333);
}
