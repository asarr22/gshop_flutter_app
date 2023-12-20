import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: const TextStyle().copyWith(
      fontFamily: 'Freight',
      fontSize: 24,
      fontWeight: FontWeight.w900,
      color: ColorPalette.onPrimaryLight,
    ),
    displayMedium: const TextStyle().copyWith(
      fontFamily: 'Freight',
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: ColorPalette.onPrimaryLight,
    ),
    displaySmall: const TextStyle().copyWith(
      fontFamily: 'Freight',
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: ColorPalette.onPrimaryLight,
    ),
    bodyLarge: const TextStyle().copyWith(
      fontFamily: 'Roboto',
      fontSize: 16,
      color: ColorPalette.onPrimaryLight,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontFamily: 'Roboto',
      fontSize: 14,
      color: ColorPalette.onPrimaryLight,
    ),
    bodySmall: const TextStyle().copyWith(
      fontFamily: 'Roboto',
      fontSize: 14,
      color: ColorPalette.onPrimaryLight,
    ),
    labelLarge: const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: ColorPalette.onPrimaryLight,
    ),
    labelMedium: const TextStyle().copyWith(
      fontFamily: 'Roboto',
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: ColorPalette.onPrimaryLight,
    ),
    labelSmall: const TextStyle().copyWith(
      fontFamily: 'Roboto',
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: ColorPalette.onPrimaryLight,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: const TextStyle().copyWith(
      fontFamily: 'Freight',
      fontSize: 24,
      fontWeight: FontWeight.w900,
      color: ColorPalette.onPrimaryDark,
    ),
    displayMedium: const TextStyle().copyWith(
      fontFamily: 'Freight',
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: ColorPalette.onPrimaryDark,
    ),
    displaySmall: const TextStyle().copyWith(
      fontFamily: 'Freight',
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: ColorPalette.onPrimaryDark,
    ),
    bodyLarge: const TextStyle().copyWith(
      fontFamily: 'Roboto',
      fontSize: 16,
      color: ColorPalette.onPrimaryDark,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontFamily: 'Roboto',
      fontSize: 14,
      color: ColorPalette.onPrimaryDark,
    ),
    bodySmall: const TextStyle().copyWith(
      fontFamily: 'Roboto',
      fontSize: 14,
      color: ColorPalette.onPrimaryDark,
    ),
    labelLarge: const TextStyle().copyWith(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: ColorPalette.onPrimaryDark),
    labelMedium: const TextStyle().copyWith(
        fontFamily: 'Roboto',
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: ColorPalette.onPrimaryDark),
    labelSmall: const TextStyle().copyWith(
        fontFamily: 'Roboto',
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: ColorPalette.onPrimaryDark),
  );
}
