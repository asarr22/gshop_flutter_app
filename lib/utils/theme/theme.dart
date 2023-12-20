import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/theme/app_bar_theme.dart';
import 'package:gshopp_flutter/utils/theme/checkbox_theme.dart';
import 'package:gshopp_flutter/utils/theme/elevated_button_theme.dart';
import 'package:gshopp_flutter/utils/theme/outlined_button_theme.dart';
import 'package:gshopp_flutter/utils/theme/text_field_theme.dart';
import 'package:gshopp_flutter/utils/theme/text_theme.dart';

class TAppTheme {
  TAppTheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    brightness: Brightness.light,
    primaryColor: ColorPalette.primaryLight,
    scaffoldBackgroundColor: const Color(0xFFFFFBFF),
    textTheme: TTextTheme.lightTextTheme,
    appBarTheme: TAppBarTheme.lightAppbarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightelevButtonTheme,
    inputDecorationTheme: TextFieldTheme.lightInputDecoratonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.outlinedButtonThemeLight,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    brightness: Brightness.dark,
    primaryColor: ColorPalette.primaryDark,
    scaffoldBackgroundColor: const Color(0xFF1F1B16),
    textTheme: TTextTheme.darkTextTheme,
    appBarTheme: TAppBarTheme.darkAppbarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkelevButtonTheme,
    inputDecorationTheme: TextFieldTheme.darkInputDecoratonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.outlinedButtonThemeDark,
  );
}
