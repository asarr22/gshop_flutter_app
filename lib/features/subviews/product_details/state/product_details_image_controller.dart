import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailImageController extends StateNotifier<int> {
  ProductDetailImageController() : super(0);

  void changeImage(int index) {
    state = index;
  }
}

final productDetailImageControllerProvider = StateNotifierProvider<ProductDetailImageController, int>((ref) {
  return ProductDetailImageController();
});
