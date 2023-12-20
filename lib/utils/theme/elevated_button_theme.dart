import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final lightelevButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ColorPalette.primaryLight,
      elevation: 3,
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizesValue.buttonCornerRadius),
      ),
      foregroundColor: Colors.white,
      textStyle: const TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
        color: Colors.white,
      ),
    ),
  );

  static final darkelevButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: ColorPalette.primaryDark,
        elevation: 3,
        disabledBackgroundColor: Colors.grey,
        disabledForegroundColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizesValue.buttonCornerRadius),
        ),
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 225, 225, 225))),
  );
}
