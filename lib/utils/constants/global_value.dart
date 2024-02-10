import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:iconsax/iconsax.dart';

class GlobalValue {
  GlobalValue._();

  static const defautQueryLimit = 15;
  static const scrollingQueryLimit = 10;
  static const homeScreenQueryLimit = 4;

  static Map<String, IconData> orderStateIconsMap = {
    '-1': Iconsax.close_circle,
    '0': Iconsax.clock,
    '1': Iconsax.note,
    '2': Iconsax.truck_time,
    '3': Iconsax.tick_circle,
  };
  static Map<String, Color> orderStateColorsMap = {
    '-1': Colors.red,
    '0': Colors.orange,
    '1': Colors.blue,
    '2': Colors.green,
    '3': Colors.green,
  };
  static Map<String, String> orderStateTextMap = {
    '-1': TextValue.canceled,
    '0': TextValue.pending,
    '1': TextValue.processing,
    '2': TextValue.delivering,
    '3': TextValue.delivered,
  };
}
