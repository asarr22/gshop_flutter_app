import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/app.dart';
import 'package:gshopp_flutter/common/controllers/promo_event_controller.dart';
import 'package:gshopp_flutter/common/firebase_services/cart_repository.dart';
import 'package:gshopp_flutter/common/models/user/user_cart_model.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';
import 'package:gshopp_flutter/utils/helpers/helper_fuctions.dart';

class UserCartController extends StateNotifier<List<UserCartItemModel>> {
  UserCartRepository userCartRepository;
  final Ref ref;
  UserCartController(this.userCartRepository, this.ref) : super(List<UserCartItemModel>.empty()) {
    fetchCart();
  }

  void fetchCart() async {
    // Wait for sometime before starting
    await Future.delayed(const Duration(seconds: 2));
    try {
      // Get Promo Event List
      final promoEventList = ref.watch(promoEventControllerProvider);

      // Listen to Cart Changes
      userCartRepository.getUserCartItems().listen((items) async {
        final productIds = items.map((item) => int.parse(item.productId)).toList();
        final products = await ref.watch(productRepositoryProvider).getProductsByIds(productIds);

        // Map products by ID for quick lookup
        final productMap = {for (var product in products) product.id: product};

        // Apply Discount Value on Item in Live So we can Spot Changes
        for (var item in items) {
          final product = productMap[int.parse(item.productId)];
          if (product != null) {
            int discountValue = GHelper.isTherePromoDiscount(product, promoEventList)
                ? product.promoDiscountValue ?? 0
                : product.discountValue > 0
                    ? product.discountValue
                    : 0;
            item.applyDiscount(discountValue);
          }
        }
        state = items;
      }, onError: (error) {
        // Handle errors, possibly by logging them or setting an error state.
        SnackBarPop.showErrorPopup(error.toString(), duration: 3);
      });
    } catch (e) {
      SnackBarPop.showErrorPopup(e.toString(), duration: 3);
    }
  }

  // Clear Cart
  void clearAll() {
    userCartRepository.removeAllItemsFromCart();
  }

  // Remove Single Item from Cart
  void deleteSingleItem(UserCartItemModel item) {
    userCartRepository.removeSingleItemFromCart(item);
    SnackBarPop.showInfoPopup(TextValue.itemRemovedfromCart, duration: 3);
  }

  // Increase Quantity
  void increaseQuantity(UserCartItemModel item) {
    int quantity = item.quantity;
    if (item.quantity < 10) {
      quantity++;
      item.removeDiscount(item.appliedDiscountValue);
      userCartRepository.mofidyItemQuantity(item, quantity);
    }
  }

  // Decrease Quantity
  void decreaseQuantity(UserCartItemModel item) {
    int quantity = item.quantity;
    if (item.quantity > 1) {
      quantity--;
      item.removeDiscount(item.appliedDiscountValue);
      userCartRepository.mofidyItemQuantity(item, quantity);
    } else {
      SnackBarPop.showInfoPopup(TextValue.quantityCannotBeZero, duration: 3);
    }
  }
}

final userCartControllerProvider = StateNotifierProvider<UserCartController, List<UserCartItemModel>>(
  (ref) => UserCartController(ref.watch(cartRepositoryProvider), ref),
);
