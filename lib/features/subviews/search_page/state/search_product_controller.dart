import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/app.dart';
import 'package:gshopp_flutter/common/firebase_services/product_repository.dart';

class SearchProductsController extends StateNotifier<Map<String, dynamic>> {
  final ProductRepository productRepository;

  SearchProductsController(this.productRepository)
      : super({
          'search': [],
          'isLoading': false,
        });

  @override
  void dispose() {
    state.forEach((key, value) {
      if (key == 'search') value?.clear();
    });
    super.dispose();
  }

  void searchProducts(String keyword, int limit) async {
    loadingToggle();
    final products = await productRepository.searchProducts(keyword, limit);
    state = {...state, 'search': products.isEmpty ? [] : products};
    loadingToggle();
  }

  void loadingToggle() {
    state = {...state, 'isLoading': !state['isLoading']};
  }
}

final searchControllerProvider =
    StateNotifierProvider.autoDispose<SearchProductsController, Map<String, dynamic>>((ref) {
  return SearchProductsController(ref.watch(productRepositoryProvider));
});
