// ignore_for_file: annotate_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/repositories/product_repository.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/utils/constants/global_value.dart';

class ProductController extends StateNotifier<Map<String, dynamic>> {
  final ProductRepository productRepository;
  DocumentSnapshot? _lastDocument;
  bool _hasMore = true;
  Ref? ref;

  /// Automatically fetches initial popular and new products for the home screen.
  ProductController(this.productRepository, this.ref)
      : super({
          'isPopular': null, // Holds popular products.
          'isFlash': null, // Holds flash sale products.
          'isNew': null, // Holds new arrival products.
          'regular': null, // Holds regular products, used in scrollable lists.
          'isRegularScrollLoading': false, // Indicates if the regular product list is currently loading.
          'category': null, // Holds the selected category filter.
          'subCategory': null, // Holds the selected sub-category filter.
        }) {
    initHomeScreenProducts(GlobalValue.homeScreenQueryLimit);
  }

  bool get hasMore => _hasMore; // Exposes the _hasMore flag.

  // ignore: must_call_super
  void dispose() {
    state.forEach((key, value) {
      if (key == 'regular') value?.clear(); // Clears the regular product list.
      if (key == 'isRegularScrollLoading') value = false; // Resets the loading state.
    });
    _lastDocument = null;
    _hasMore = true;
  }

  /// Toggles the loading state for scrolling through regular products.
  void toggleRegularScrollLoading(bool value) {
    state = {...state, 'isRegularScrollLoading': value};
  }

  /// Initializes home screen products with a specified [limit] for each category.
  Future<void> initHomeScreenProducts(int limit) async {
    await fetchProductWithSingleFitler(limit, {'isPopular': true});
    await fetchProductWithSingleFitler(limit, {'isNew': true});
    await fetchProductWithSingleFitler(2, {'promoCode': '0'});
  }

  /// Fetches products based on a single filter criteria with a specified [limit].
  Future<void> fetchProductWithSingleFitler(int limit, Map<String, dynamic> filter) async {
    final products = await productRepository.getProductbySingleFilter(limit, filter);
    state = {...state, filter.keys.first: products.isEmpty ? [] : products};
    ref?.read(globalLoadingProvider.notifier).state = false;
  }

  /// Fetches products using a custom Firestore [query] with pagination support.
  Future<void> fetchProductWithCustomQuery(int limit, Query<Map<String, dynamic>> query,
      {DocumentSnapshot<Map<String, dynamic>>? startAfter}) async {
    if (!_hasMore) return;

    final result = await productRepository.getProductbyCustomQuery(limit, query, startAfter: _lastDocument);
    _lastDocument = result.lastDocument;
    _hasMore = result.hasMore;

    final products = result.products;

    state = {
      ...state,
      'regular': state['regular'] == null ? products : [...state['regular']!, ...products]
    };
    toggleRegularScrollLoading(false);
    ref?.read(globalLoadingProvider.notifier).state = false;
  }

  /// Fetches products that match two sets of filter criteria with a specified [limit].
  Future<void> fetchProductWithDoubleFitler(
      int limit, Map<String, dynamic> filter1, Map<String, dynamic> filter2) async {
    final products = await productRepository.getProductbyDoubleFilter(limit, filter1, filter2);
    state = {...state, filter1.keys.first: products.isEmpty ? [] : products};
  }
}

/// Encapsulates the result of a Firestore query for products.
///
/// Includes the fetched products, the last document for pagination, and a flag indicating if more products are available.
class QueryResult {
  final List<Product> products;
  final DocumentSnapshot? lastDocument;
  final bool hasMore;

  QueryResult(this.products, this.lastDocument, this.hasMore);
}

final productControllerProvider = StateNotifierProvider<ProductController, Map<String, dynamic>>((ref) {
  return ProductController(ref.watch(productRepositoryProvider), ref);
});

final globalLoadingProvider = StateProvider.autoDispose<bool>((ref) => false);
