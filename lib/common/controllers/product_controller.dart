import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/firebase_services/product_repository.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';

class ProductController extends StateNotifier<Map<String, List<Product>?>> {
  final ProductRepository productRepository;
  ProductController(this.productRepository)
      : super({
          'isPopular': null,
          'isNew': null,
          'regular': null,
          'category': null,
          'subCategory': null,
        }) {
    initHomeScreenProducts(4);
  }

  Future<void> initHomeScreenProducts(int limit) async {
    await fetchProductWithSingleFitler(limit, {'isPopular': true});
    await fetchProductWithSingleFitler(limit, {'isNew': true});
  }

  Future<void> fetchProductWithSingleFitler(int limit, Map<String, dynamic> filter) async {
    final products = await productRepository.getProductbySingleFilter(limit, filter);
    state = {...state, filter.keys.first: products.isEmpty ? [] : products};
  }

  Future<void> fetchProductWithCustomQuery(int limit, Query<Map<String, dynamic>> query) async {
    final products = await productRepository.getProductbyCustomQuery(limit, query);
    state = {...state, 'regular': products.isEmpty ? [] : products};
  }

  Future<void> fetchProductWithDoubleFitler(
      int limit, Map<String, dynamic> filter1, Map<String, dynamic> filter2) async {
    final products = await productRepository.getProductbyDoubleFilter(limit, filter1, filter2);
    state = {...state, filter1.keys.first: products.isEmpty ? [] : products};
  }
}
