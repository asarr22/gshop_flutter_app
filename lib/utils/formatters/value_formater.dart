import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Formatter {
  Formatter._();

  static String formatPrice(double price) {
    String formatted = price.toStringAsFixed(0);
    final StringBuffer buffer = StringBuffer();
    int index = 0;
    for (int i = formatted.length - 1; i >= 0; i--) {
      buffer.write(formatted[i]);
      index++;
      if (index % 3 == 0 && i != 0) {
        buffer.write(' ');
      }
    }
    return '${buffer.toString().split('').reversed.join()} FCFA';
  }

  static double applyDiscount(double initialPrice, int discountPercentage) {
    double discountValue = initialPrice * (discountPercentage / 100);
    return initialPrice - discountValue;
  }

  static String getFormattedDateTime(String format) {
    var now = DateTime.now();
    var formatter = DateFormat(format);
    return formatter.format(now);
  }

  static Color hexToColor(String hexString) {
    return Color(int.parse(hexString.replaceFirst('#', '0xFF')));
  }

  static String capitalizeFirstLetter(String text) {
    return '${text[0].toUpperCase()}${text.substring(1)}';
  }
}
