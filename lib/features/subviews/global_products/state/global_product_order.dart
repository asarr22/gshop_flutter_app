import 'package:flutter_riverpod/flutter_riverpod.dart';

class GlobalProductOrderState extends StateNotifier<ProductOrder> {
  GlobalProductOrderState() : super(ProductOrder.default_);

  void update(ProductOrder value) {
    state = value;
  }
}

final globalProductOrderProvider = StateNotifierProvider<GlobalProductOrderState, ProductOrder>((ref) {
  return GlobalProductOrderState();
});

enum ProductOrder {
  default_,
  priceAsc,
  priceDesc,
}

class ProductOrderFilterChecker extends StateNotifier<bool> {
  ProductOrderFilterChecker() : super(false);

  void update(bool value) {
    state = value;
  }
}

final productOrderFilterCheckerProvider = StateNotifierProvider<ProductOrderFilterChecker, bool>((ref) {
  return ProductOrderFilterChecker();
});
