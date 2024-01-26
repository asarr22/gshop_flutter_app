import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/controllers/favorite_controller.dart';
import 'package:gshopp_flutter/common/models/user/favorite_item_model.dart';
import 'package:gshopp_flutter/features/subviews/product_details/product_detail_page.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/images_values.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/formatters/value_formater.dart';
import 'package:gshopp_flutter/utils/styles/rounded_container.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

class FavoriteItemCard extends ConsumerWidget {
  const FavoriteItemCard({super.key, required this.favoriteItem});

  final FavoriteItemModel favoriteItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = HelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SizesValue.padding / 2, horizontal: 2),
      child: GestureDetector(
        onTap: () {
          Get.to(() => ProductDetailPage(favoriteItem.id));
        },
        child: RoundedContainer(
          height: 90,
          backgroundColor: isDarkMode ? ColorPalette.grey : ColorPalette.extraLightGray,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1.5,
              blurRadius: 5.0,
              offset: const Offset(-1, 4),
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  child: favoriteItem.image.isEmpty
                      ? Shimmer.fromColors(
                          baseColor: ColorPalette.lightGrey,
                          highlightColor: ColorPalette.extraLightGray,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey),
                          ),
                        )
                      : Image.network(
                          favoriteItem.image.isEmpty ? ImagesValue.monitorIcon : favoriteItem.image,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: ColorPalette.primary,
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              favoriteItem.title,
                              style: Theme.of(context).textTheme.displaySmall,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            GestureDetector(
                              onTap: () {
                                ref.read(favoriteControllerProvider.notifier).deleteSingleItem(favoriteItem.id);
                              },
                              child: const Icon(
                                Iconsax.shop_remove,
                                size: 20,
                                color: ColorPalette.black,
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Formatter.formatPrice(favoriteItem.price),
                            style: Theme.of(context).textTheme.displaySmall!.apply(fontWeightDelta: 2),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
