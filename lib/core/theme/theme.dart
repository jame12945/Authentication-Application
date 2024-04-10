import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.circular(10));
  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      appBarTheme: AppBarTheme(backgroundColor: AppPallete.blueColor),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(10),
        enabledBorder: _border(),
        focusedBorder: _border(AppPallete.focusColor),
      ));
}
