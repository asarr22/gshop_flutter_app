import 'package:flutter/material.dart';

class TAppBarTheme {
  TAppBarTheme._();

  static const lightAppbarTheme = AppBarTheme(
    color: Color(0xFFFFFBFF),
    centerTitle: false,
    scrolledUnderElevation: 0,
    toolbarHeight: 80,
    iconTheme: IconThemeData(
      size: 24,
      color: Colors.black,
    ),
    actionsIconTheme: IconThemeData(
      size: 24,
      color: Color(0xFFFFFFFF),
    ),
    titleTextStyle: TextStyle(
      fontFamily: 'Freight',
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Color(0xFFEBE1D9),
    ),
  );

  static const darkAppbarTheme = AppBarTheme(
    color: Color(0xFF1F1B16),
    centerTitle: false,
    scrolledUnderElevation: 0,
    toolbarHeight: 80,
    iconTheme: IconThemeData(
      size: 24,
      color: Colors.white,
    ),
    actionsIconTheme: IconThemeData(
      size: 24,
      color: Color(0xFF492900),
    ),
    titleTextStyle: TextStyle(
      fontFamily: 'Freight',
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Color(0xFF1F1B16),
    ),
  );
}
