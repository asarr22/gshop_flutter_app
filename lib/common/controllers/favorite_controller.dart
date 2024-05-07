import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/repositories/favorite_repository.dart';
import 'package:gshopp_flutter/common/models/user/favorite_item_model.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';

class FavoriteController extends StateNotifier<List<FavoriteItemModel>> {
  FavoriteRepository favoritetRepository;
  FavoriteController(this.favoritetRepository) : super(List<FavoriteItemModel>.empty()) {
    fetchFavorite();
  }

  void fetchFavorite() {
    favoritetRepository.getUserFavoriteItems().listen((items) {
      state = items;
    });
  }

  void clearAll() {
    favoritetRepository.removeAllItemsFromFavorite();
  }

  void deleteSingleItem(String id) {
    favoritetRepository.removeSingleItemFromFavorite(id);
    SnackBarPop.showInfoPopup(TextValue.itemRemovedfromFavorite, duration: 3);
  }

  void addItemToFavorite(FavoriteItemModel item) {
    favoritetRepository.addItemToFavorite(item);
    SnackBarPop.showSucessPopup(TextValue.itemAddedToFavorite, duration: 3);
  }
}

final favoriteControllerProvider = StateNotifierProvider<FavoriteController, List<FavoriteItemModel>>(
  (ref) {
    final favoriteRepository = ref.watch(favoriteRepositoryProvider);
    return FavoriteController(favoriteRepository);
  },
);
