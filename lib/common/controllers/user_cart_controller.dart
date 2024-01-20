import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/app.dart';
import 'package:gshopp_flutter/common/firebase_services/cart_repository.dart';
import 'package:gshopp_flutter/common/models/product/user_cart_model.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';

class UserCartController extends StateNotifier<List<UserCartItemModel>> {
  UserCartRepository userCartRepository;
  UserCartController(this.userCartRepository) : super(List<UserCartItemModel>.empty()) {
    fetchCart();
  }

  void fetchCart() {
    userCartRepository.getUserCartItems().listen((items) {
      state = items;
    });
  }

  void clearAll() {
    userCartRepository.removeAllItemsFromCart();
  }

  void deleteSingleItem(UserCartItemModel item) {
    userCartRepository.removeSingleItemFromCart(item);
    SnackBarPop.showInfoPopup(TextValue.itemRemovedfromCart, duration: 3);
  }

  void increaseQuantity(UserCartItemModel item) {
    int quantity = item.quantity;
    if (item.quantity < 10) {
      quantity++;
    }
    userCartRepository.mofidyItemQuantity(item, quantity);
  }

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
    return UserCartController(userCartRepository);
  },
);
