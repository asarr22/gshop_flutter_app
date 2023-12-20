import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';

class SelectedVariantController extends StateNotifier<Variant> {
  SelectedVariantController() : super(HelperFunctions.pdVariantHandler);

  void updateSelectedVariant(
      String color, String size, List<Variant> variants) {
    state = Variant(price: 0, size: "", color: "", stock: 0);
    for (Variant variant in variants) {
      if (variant.color == color && variant.size == size) {
        state = variant;
        break;
      }
    }
  }
}
