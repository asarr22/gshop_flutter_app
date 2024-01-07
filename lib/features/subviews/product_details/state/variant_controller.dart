import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';

class SelectedVariant extends StateNotifier<Variant?> {
  SelectedVariant() : super(null);

  void selectVariant(Variant variant) {
    state = variant;
  }
}

class SelectedSize extends StateNotifier<Size?> {
  SelectedSize() : super(null);

  void selectSize(Size size) {
    state = size;
  }

  void resetSelection() {
    state = null;
  }
}

class SelectedQuantity extends StateNotifier<int> {
  SelectedQuantity() : super(1);

  void increment() {
    if (state < 10) {
      state++;
    }
  }

  void decrement() {
    if (state > 1) {
      state--;
    }
  }
}
