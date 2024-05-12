import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/controllers/promo_event_controller.dart';
import 'package:gshopp_flutter/common/repositories/auth_services.dart';
import 'package:gshopp_flutter/common/repositories/cart_repository.dart';
import 'package:gshopp_flutter/common/models/user/user_cart_model.dart';
import 'package:gshopp_flutter/common/repositories/product_repository.dart';
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';
import 'package:gshopp_flutter/utils/helpers/helper_fuctions.dart';

import '../../utils/constants/text_values.dart';

class UserCartController extends StateNotifier<List<UserCartItemModel>> {
  UserCartRepository userCartRepository;
  final Ref ref;
  StreamSubscription<List<UserCartItemModel>>? cartSubscription;

  UserCartController(this.userCartRepository, this.ref) : super([]) {
    fetchCart();
  }

  void fetchCart() async {
    try {
      if (!ref.watch(isLoggedInProvider)) {
        state = [];
        return;
      }

      final promoEventList = ref.watch(promoEventControllerProvider);
      cartSubscription = userCartRepository.getUserCartItems().listen((items) async {
        final productIds = items.map((item) => int.parse(item.productId)).toList();
        final products = await ref.watch(productRepositoryProvider).getProductsByIds(productIds);

        final productMap = {for (var product in products) product.id: product};
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
        if (!disposed) {
          state = items;
        }
      }, onError: (error) {
        SnackBarPop.showErrorPopup(error.toString(), duration: 3);
      });
    } catch (e) {
      throw e.toString();
    }
  }

  // Clear Cart
  void clearAll() {
    userCartRepository.removeAllItemsFromCart();
  }

  // Remove Single Item from Cart
  void deleteSingleItem(UserCartItemModel item) {
    try {
      userCartRepository.removeSingleItemFromCart(item);
      SnackBarPop.showInfoPopup(TextValue.itemRemovedfromCart, duration: 3);
    } catch (e) {
      SnackBarPop.showErrorPopup("${TextValue.somethingWentWrongMessage} error : $e", duration: 3);
    }
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

  bool disposed = false;
  @override
  void dispose() {
    disposed = true;
    cartSubscription?.cancel();
    super.dispose();
  }
}

final userCartControllerProvider = StateNotifierProvider<UserCartController, List<UserCartItemModel>>(
  (ref) => UserCartController(ref.watch(cartRepositoryProvider), ref),
);
