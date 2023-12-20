import 'package:flutter/material.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';

class HelperFunctions {
  HelperFunctions._();

  static double screenWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  static bool isDarkMode(context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static BuildContext? currentContext;

  static BuildContext? loadingContext;

  static Variant pdVariantHandler =
      Variant(size: "", color: "", stock: 0, price: 0);
}
