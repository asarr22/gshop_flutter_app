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
    if (discountPercentage == 100) {
      throw ArgumentError("Discount percentage cannot be 100.");
    }
    double discountValue = initialPrice * (discountPercentage / 100);
    return initialPrice - discountValue;
  }

  static double removeDiscount(double finalPrice, int discountPercentage) {
    // Ensure the discount percentage is not 100% to avoid division by zero
    if (discountPercentage == 100) {
      throw ArgumentError("Discount percentage cannot be 100.");
    }

    return finalPrice / (1 - (discountPercentage / 100.0));
  }

  static String getFormattedDateTime(String format, {DateTime? dateTime}) {
    var value = dateTime ?? DateTime.now();
    var formatter = DateFormat(format);
    return formatter.format(value);
  }

  static DateTime getDateFromString(String dateString) {
    DateTime parsedDate = DateFormat('dd/MM/yyyy HH:mm').parse(dateString);
    return parsedDate;
  }

  static Color hexToColor(String hexString) {
    return Color(int.parse(hexString.replaceFirst('#', '0xFF')));
  }

  static String capitalizeFirstLetter(String text) {
    return '${text[0].toUpperCase()}${text.substring(1)}';
  }
}
