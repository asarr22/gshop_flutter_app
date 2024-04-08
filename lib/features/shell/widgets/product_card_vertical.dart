import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/controllers/favorite_controller.dart';
import 'package:gshopp_flutter/common/controllers/promo_event_controller.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/common/models/user/favorite_item_model.dart';
import 'package:gshopp_flutter/features/shell/widgets/rounded_image.dart';
import 'package:gshopp_flutter/features/subviews/product_details/product_detail_page.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/formatters/value_formater.dart';
import 'package:gshopp_flutter/utils/styles/circular_icon.dart';
import 'package:gshopp_flutter/utils/styles/rounded_container.dart';
import 'package:gshopp_flutter/utils/styles/shadow.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';
import 'package:iconsax/iconsax.dart';

class ProductCardVertical extends ConsumerWidget {
  const ProductCardVertical({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    final favoriteList = ref.watch(favoriteControllerProvider);
    bool isAmoungFavorite = favoriteList.any((element) => element.id == product.id.toString());
    final promoEventList = ref.watch(promoEventControllerProvider);
    final bool isTherePromoDiscount = HelperFunctions.isTherePromoDiscount(product, promoEventList);

    getColorsWidgets() {
      List<Widget> widgets = [];

      for (var variant in product.variants) {
        widgets.add(
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Formatter.hexToColor(variant.color),
              shape: BoxShape.circle,
            ),
          ),
        );
      }

      return widgets;
    }

    final colorList = getColorsWidgets();

    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailPage(product.id),
            transition: Transition.rightToLeftWithFade, duration: const Duration(milliseconds: 300));
      },
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticolProductShadow],
          borderRadius: BorderRadius.circular(SizesValue.productImageRadius),
        ),
        child: RoundedContainer(
          height: 200,
          padding: const EdgeInsets.all(10),
          backgroundColor: isDarkMode ? ColorPalette.backgroundDark : ColorPalette.backgroundLight,
          child: Stack(
            children: [
              RoundedImage(
                backgroundColor: isDarkMode ? ColorPalette.backgroundDark : ColorPalette.backgroundLight,
                imgUrl: product.imageUrl[0],
                isNetworkImage: true,
                applyImageRadius: true,
                height: 110,
                width: 150,
                fit: BoxFit.scaleDown,
              ),

              Positioned(
                  top: 0,
                  child: Container(
                    height: 33,
                    width: 33,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: ColorPalette.white.withOpacity(0.8),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey, //New
                            blurRadius: 8.0,
                            spreadRadius: -2,
                            offset: Offset(1, 1))
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${isTherePromoDiscount ? product.promoDiscountValue! : product.discountValue}%',
                        style:
                            Theme.of(context).textTheme.labelSmall!.apply(color: ColorPalette.black, fontSizeDelta: 2),
                      ),
                    ),
                  )),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    if (isAmoungFavorite) {
                      ref.read(favoriteControllerProvider.notifier).deleteSingleItem(product.id.toString());
                      return;
                    }
                    final item = FavoriteItemModel(
                        id: product.id.toString(),
                        title: product.title,
                        image: product.imageUrl[0],
                        price: product.variants[0].size[0].price.toDouble());
                    ref.read(favoriteControllerProvider.notifier).addItemToFavorite(item);
                  },
                  child: CircularIcon(
                    icon: isAmoungFavorite ? Iconsax.heart5 : Iconsax.heart,
                    color: isAmoungFavorite ? Colors.red : Colors.black,
                    backgroundColor: ColorPalette.white,
                    size: 18,
                    height: 33,
                    width: 33,
                    boxShadow: const [
                      BoxShadow(color: Colors.grey, blurRadius: 8.0, spreadRadius: -2, offset: Offset(1, 1))
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                left: 0,
                child: SizedBox(
                  height: 60,
                  width: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: Theme.of(context).textTheme.labelMedium!.apply(fontWeightDelta: 2),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.brand,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .apply(color: isDarkMode ? ColorPalette.lightGrey : ColorPalette.darkGrey),
                          ),
                          SizedBox(
                            height: 10,
                            child: Row(
                              children: colorList,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        Formatter.formatPrice(Formatter.applyDiscount(product.price.toDouble(),
                            isTherePromoDiscount ? product.promoDiscountValue! : product.discountValue)),
                        style: Theme.of(context).textTheme.labelLarge!.apply(fontWeightDelta: 3),
                      ),
                    ],
                  ),
                ),
              ),
              // Positioned
            ],
          ),
        ),
      ),
    );
  }
}
