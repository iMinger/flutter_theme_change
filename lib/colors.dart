
import 'package:flutter/material.dart';
import 'package:flutter_theme_change/theme_change_manager.dart';

class NameColors {
  static Color get backgroundColor {
    print('当前主题的背景颜色： ${ThemeChangeManager().currentThemeDataObject.themeData.backgroundColor}');
    return ThemeChangeManager().currentThemeDataObject.themeData.backgroundColor;
  }
}