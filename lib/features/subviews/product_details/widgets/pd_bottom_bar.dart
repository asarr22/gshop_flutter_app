import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/app.dart';
import 'package:gshopp_flutter/common/controllers/user_cart_controller.dart';
import 'package:gshopp_flutter/common/models/user/user_cart_model.dart';
import 'package:gshopp_flutter/features/subviews/product_details/product_detail_page.dart';
import 'package:gshopp_flutter/features/subviews/product_details/state/add_to_cart_state.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/formatters/value_formater.dart';
import 'package:gshopp_flutter/utils/helpers/network_manager.dart';
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';
import 'package:iconsax/iconsax.dart';

class ProductDetailBottomBar extends ConsumerWidget {
  const ProductDetailBottomBar({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productDetailsControllerProvider);

    final selectedSize = ref.watch(selectedSizeProvider);
    final selectedQuantityValue = ref.watch(quantityProvider);
    final selectedVariant = ref.watch(selectedVariantProvider);
    final cartRepository = ref.watch(cartRepositoryProvider);
    final cartItems = ref.watch(userCartControllerProvider);
    bool isLoading = ref.watch(addToCartButtonStateProvider);

    final bool isSelectedVariantAvailable = selectedSize != null && selectedSize.stock > 0;

    Future<void> buildAndSendCartItem() async {
      ref.read(addToCartButtonStateProvider.notifier).toggle();

      // Get the Current time
      final time = Formatter.getFormattedDateTime("yyyy-MM-dd HH:mm:ss");

      // Get the price

      double price = Formatter.applyDiscount(
          selectedSize == null ? 0 : selectedSize.price.toDouble() * selectedQuantityValue, product.discountValue);

      //Check if Network is available
      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        SnackBarPop.showSucessPopup(TextValue.checkYourNetwork);
        return;
      }

      // Check if selected variant is available
      if (isSelectedVariantAvailable && selectedVariant != null) {
        // Add to cart
        final cartItemModel = UserCartItemModel(
            productId: product.id,
            quantity: selectedQuantityValue,
            createdAt: time,
            productName: product.title,
            productImage: product.imageUrl[0],
            productPrice: price.toInt(),
            color: selectedVariant.color,
            size: selectedSize.size);

        // Check if item exists in cart

        if (cartItems
            .where((item) =>
                item.productId == cartItemModel.productId &&
                item.size == cartItemModel.size &&
                item.color == cartItemModel.color)
            .isNotEmpty) {
          final existingItem = cartItems.firstWhere((item) =>
              item.productId == cartItemModel.productId &&
              item.size == cartItemModel.size &&
              item.color == cartItemModel.color);

          await cartRepository.mofidyItemQuantity(existingItem, existingItem.quantity + selectedQuantityValue);
        } else {
          await cartRepository.addItemToCart(cartItemModel);
        }

        SnackBarPop.showSucessPopup(TextValue.itemAddedToCart);
        ref.read(addToCartButtonStateProvider.notifier).toggle();
      } else {
        SnackBarPop.showInfoPopup(TextValue.selectedItemIsNotAvailable);
        ref.read(addToCartButtonStateProvider.notifier).toggle();
        return;
      }
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: ColorPalette.grey.withOpacity(0.3), width: 1),
        ),
      ),
      height: 95,
      width: double.infinity,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding, vertical: SizesValue.padding / 2),
          child: SizedBox(
            height: 70,
            child: ElevatedButton(
                onPressed: !isSelectedVariantAvailable
                    ? null
                    : () async {
                        await buildAndSendCartItem();
                      },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return ColorPalette.lightGrey;
                      }
                      return ColorPalette.primary;
                    },
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.shopping_cart,
                            color: isSelectedVariantAvailable ? Colors.white : ColorPalette.primary,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            TextValue.buy,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(color: isSelectedVariantAvailable ? Colors.white : ColorPalette.primary),
                          ),
                          Visibility(
                            visible: isSelectedVariantAvailable,
                            child: const VerticalDivider(
                              indent: 25,
                              endIndent: 25,
                              thickness: 2,
                              color: Colors.white,
                            ),
                          ),
                          Visibility(
                            visible: isSelectedVariantAvailable,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  Formatter.formatPrice(Formatter.applyDiscount(
                                      selectedSize == null ? 0 : selectedSize.price.toDouble() * selectedQuantityValue,
                                      product.discountValue)),
                                  style: Theme.of(context).textTheme.displayMedium!.apply(color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  Formatter.formatPrice(
                                      selectedSize == null ? 0 : selectedSize.price.toDouble() * selectedQuantityValue),
                                  style: Theme.of(context).textTheme.labelMedium!.apply(
                                      decorationColor: isDarkMode ? ColorPalette.black : ColorPalette.darkGrey,
                                      color: ColorPalette.extraLightGray,
                                      decoration: TextDecoration.lineThrough),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
          ),
        )
      ]),
    );
  }
}
