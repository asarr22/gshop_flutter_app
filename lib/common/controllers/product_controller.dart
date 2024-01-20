import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/firebase_services/product_repository.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';

class ProductController extends StateNotifier<Map<String, List<Product>>> {
  final ProductRepository productRepository;
  ProductController(this.productRepository)
      : super({
          'isPopular': [],
          'isNew': [],
          'regular': [],
        }) {
    initHomeScreenProducts(4);
  }

  Future<void> initHomeScreenProducts(int limit) async {
    await fetchProductWithSingleFitler(limit, {'isPopular': true});
    await fetchProductWithSingleFitler(limit, {'isNew': true});
  }

  Future<void> fetchProductWithSingleFitler(int limit, Map<String, dynamic> filter) async {
    final products = productRepository.getProductbySingleFilter(limit, filter);
    state = {...state, filter.keys.first: await products};
  }
}
