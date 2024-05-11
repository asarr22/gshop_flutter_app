import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
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
    // Schedule the state update after the current call stack
    Future.microtask(() => ref.read(favoriteLoadingProvider.notifier).state = true);

    favoriteRepository.getUserFavoriteProductIds().listen((productIds) async {
      var products = await productRepository.getProductsByIds(productIds);
      state = products;
      Future.microtask(() => ref.read(favoriteLoadingProvider.notifier).state = false);
    });
  }

  void clearAll() {
    favoriteRepository.removeAllItemsFromFavorite();
  }

  void deleteSingleItem(int productId) {
    favoriteRepository.removeSingleItemFromFavorite(productId);
    SnackBarPop.showInfoPopup(TextValue.itemRemovedfromFavorite, duration: 3);
  }

  void addItemToFavorite(int productId) {
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
