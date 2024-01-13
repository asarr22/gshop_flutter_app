import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/firebase_services/product_repository.dart';
import 'package:gshopp_flutter/features/subviews/product_details/subviews/model/ratings_model.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/helpers/network_manager.dart';
import 'package:gshopp_flutter/utils/popups/full_screen_loader.dart';
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';

class ProductRatingController extends StateNotifier<List<RatingModel>> {
  final ProductRepository productRepository;
  ProductRatingController(this.productRepository) : super(List<RatingModel>.empty());

  void getProductReviews(String productID) async {
    final reviews = productRepository.getProductReviews(productID);
    state = await reviews;
  }

  void addProductReview(String productID, RatingModel ratingModel) async {
    try {
      PFullScreenLoader.openLoadingDialog(Get.context!);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        PFullScreenLoader.stopLoading();
        return;
      }

      await productRepository.addProductReview(productID, ratingModel);

      // Remove Loader
      PFullScreenLoader.stopLoading();

      // Show Success Message
      SnackBarPop.showSucessPopup(TextValue.operationSuccess, duration: 4);

      //Move to previous Screen
      Get.back();
    } catch (e) {
      SnackBarPop.showErrorPopup(e.toString(), duration: 4);
      PFullScreenLoader.stopLoading();
    }
  }
}
