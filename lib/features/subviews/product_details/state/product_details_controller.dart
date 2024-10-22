import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/repositories/product_repository.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';

class ProductDetailsController extends StateNotifier<Product> {
  final ProductRepository productRepository;

  ProductDetailsController(this.productRepository) : super(Product.empty());

  void setProduct(int productID) {
    productRepository.getProductByID(productID).listen((product) {
      state = product;
    });
  }
}
