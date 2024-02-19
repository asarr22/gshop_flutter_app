import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gshopp_flutter/common/models/app/event_model.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/features/authentication/screens/onboarding_screen.dart';
import 'package:gshopp_flutter/features/subviews/global_products/state/global_product_order.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/formatters/value_formater.dart';

class HelperFunctions {
  HelperFunctions._();

  static double screenWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  static bool isDarkMode(context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Widget Function() initialRoute = () => const OnBoardingPage();

  static BuildContext? currentContext;

  static BuildContext? loadingContext;

  static Variant pdVariantHandler = Variant(
    size: [Size(size: 'size', stock: 0, price: 0)],
    color: "",
  );

  static Query<Map<String, dynamic>> mainQueryHandler = FirebaseFirestore.instance.collection('Products');

  static Query<Map<String, dynamic>>? filterQueryHandler;

  static Variant getVariantFromList(List<Variant> variants, String color, String size) {
    for (var variant in variants) {
      if (variant.color == color) {
        for (var size_ in variant.size) {
          if (size_.size == size) {
            return variant;
          }
        }
      }
    }
    return Variant.empty();
  }

  static int getStockWithSizeAndColor(List<Variant> variants, String color, String size) {
    for (var variant in variants) {
      if (variant.color == color) {
        for (var size_ in variant.size) {
          if (size_.size == size) {
            return size_.stock;
          }
        }
      }
    }
    return -1;
  }

  static bool isTherePromoDiscount(Product product, List<PromoEventModel> promoEventList) {
    // Check at first if there is a promo discount
    int promoDiscountID = int.tryParse(product.promoCode!) ?? -1;
    if (promoDiscountID > -1) {
      // Check if the discount ID is amoung Discount List

      for (var element in promoEventList) {
        bool flag = Formatter.getDateFromString(element.endDate).isAfter(DateTime.now());
        if (int.parse(element.id) == promoDiscountID && flag) {
          return true;
        }
      }
    }
    return false;
  }

  // Get name From ProductOrder
  static String getNameFromProductOrder(ProductOrder productOrder) {
    switch (productOrder) {
      case ProductOrder.default_:
        return TextValue.default_;
      case ProductOrder.priceAsc:
        return TextValue.lowerPrice;
      case ProductOrder.priceDesc:
        return TextValue.higherPrice;
    }
  }
}
