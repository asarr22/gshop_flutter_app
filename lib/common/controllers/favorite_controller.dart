import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/common/repositories/auth_services.dart';
import 'package:gshopp_flutter/common/repositories/favorite_repository.dart';
import 'package:gshopp_flutter/common/repositories/product_repository.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';

class FavoriteController extends StateNotifier<List<Product>?> {
  FavoriteRepository favoriteRepository;
  ProductRepository productRepository;
  Ref ref;

  FavoriteController(this.favoriteRepository, this.productRepository, this.ref) : super([]) {
    fetchFavorite();
  }

  void fetchFavorite() {
    if (!ref.watch(isLoggedInProvider)) {
      state = [];
      return;
    }
    // Schedule the state update after the current call stack
    Future.microtask(() => ref.read(favoriteLoadingProvider.notifier).state = true);

    favoriteRepository.getUserFavoriteProductIds().listen((productIds) async {
      var products = await productRepository.getProductsByIds(productIds);
      state = products;
      Future.microtask(() => ref.read(favoriteLoadingProvider.notifier).state = false);
    });
  }

  void clearAll() {
    // Check if the user is logged in
    if (!ref.watch(isLoggedInProvider)) {
      return;
    }
    favoriteRepository.removeAllItemsFromFavorite();
  }

  void deleteSingleItem(int productId) {
    // Check if the user is logged in (You Can't here anyway lol)
    if (!ref.watch(isLoggedInProvider)) {
      return;
    }
    favoriteRepository.removeSingleItemFromFavorite(productId);
    SnackBarPop.showInfoPopup(TextValue.itemRemovedfromFavorite, duration: 3);
  }

  void addItemToFavorite(int productId) {
    // Check if the user is logged in
    if (!ref.watch(isLoggedInProvider)) {
      SnackBarPop.showInfoPopup(TextValue.youNeedToLogin, duration: 3);
      return;
    }
    favoriteRepository.addItemToFavorite(productId);
    SnackBarPop.showSucessPopup(TextValue.itemAddedToFavorite, duration: 3);
  }
}

final favoriteControllerProvider = StateNotifierProvider<FavoriteController, List<Product>?>(
  (ref) {
    final favoriteRepository = ref.watch(favoriteRepositoryProvider);
    final productRepository = ref.watch(productRepositoryProvider);
    return FavoriteController(favoriteRepository, productRepository, ref);
  },
);

final favoriteLoadingProvider = StateProvider<bool>((ref) => false);
