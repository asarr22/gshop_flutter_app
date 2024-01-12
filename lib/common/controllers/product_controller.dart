import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/firebase_services/product_repository.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';

class ProductController extends StateNotifier<Map<String, List<Product>>> {
  final ProductRepository productRepository;
  ProductController(this.productRepository)
      : super({
          'popular': [],
          'new': [],
          'regular': [],
        }) {
    fetchPopularProducts();
  }

  Future<void> fetchPopularProducts() async {
    final products = productRepository.getPopularProducts();
    state = {...state, 'popular': await products};
  }
}
