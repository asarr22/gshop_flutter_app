import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/app.dart';
import 'package:gshopp_flutter/common/controllers/promo_event_controller.dart';
import 'package:gshopp_flutter/common/firebase_services/cart_repository.dart';
import 'package:gshopp_flutter/common/models/user/user_cart_model.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';

class UserCartController extends StateNotifier<List<UserCartItemModel>> {
  UserCartRepository userCartRepository;
  Ref ref;
  UserCartController(this.userCartRepository, this.ref) : super(List<UserCartItemModel>.empty()) {
    fetchCart();
  }

  void fetchCart() async {
    // Get Promo Event List
    var promoEventList = ref.watch(promoEventControllerProvider);

    // Listen to Cart Changes
    userCartRepository.getUserCartItems().listen((items) async {
      try {
        // Fetch all products at once to reduce await points inside the loop
        var productIds = items.map((item) => item.productId).toList();
        var products = await ref.watch(productRepositoryProvider).getProductsByIds(productIds);

        // Map products by ID for quick lookup
        var productMap = {for (var product in products) product.id: product};

        // Apply Discount Value on Item in Live So we can Spot Changes
        for (var item in items) {
          var product = productMap[item.productId];
          if (product != null) {
            int discountValue = HelperFunctions.isTherePromoDiscount(product, promoEventList)
                ? product.promoDiscountValue ?? 0
                : product.discountValue > 0
                    ? product.discountValue
                    : 0;
            item.applyDiscount(discountValue);
          }
        }

        state = items;
      } catch (e) {
        // Handle errors, possibly set an error state
        SnackBarPop.showErrorPopup(e.toString(), duration: 4);
      }
    });
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
    }
    userCartRepository.mofidyItemQuantity(item, quantity);
  }

  // Decrease Quantity
  void decreaseQuantity(UserCartItemModel item) {
    int quantity = item.quantity;
    if (item.quantity > 1) {
      quantity--;
    }
    userCartRepository.mofidyItemQuantity(item, quantity);
  }
}

final userCartControllerProvider = StateNotifierProvider<UserCartController, List<UserCartItemModel>>(
  (ref) {
    final userCartRepository = ref.watch(cartRepositoryProvider);
    return UserCartController(userCartRepository, ref);
  },
);
