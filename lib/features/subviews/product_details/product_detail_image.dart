import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/controllers/favorite_controller.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/features/shell/widgets/rounded_image.dart';
import 'package:gshopp_flutter/features/subviews/product_details/state/product_details_image_controller.dart';
import 'package:gshopp_flutter/utils/animations/custom_fade_animation.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/widgets/custom_app_bar.dart';
import 'package:gshopp_flutter/utils/widgets/circular_icon.dart';
import 'package:gshopp_flutter/utils/widgets/curved_edge_widget.dart';
import 'package:gshopp_flutter/utils/helpers/helper_fuctions.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailImage extends ConsumerStatefulWidget {
  final Product product;

  const ProductDetailImage({super.key, required this.product});

  @override
  ConsumerState<ProductDetailImage> createState() => _ProductDetailImageState();
}

class _ProductDetailImageState extends ConsumerState<ProductDetailImage> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = GHelper.isDarkMode(context);
    final selectedImage = ref.watch(productDetailImageControllerProvider);
    final favoriteList = ref.watch(favoriteControllerProvider);
    bool isAmoungFavorite = favoriteList!.any((element) => element.id == widget.product.id);

    return CurvedEdgesWidget(
      child: Container(
        color: isDarkMode ? ColorPalette.darkGrey : ColorPalette.extraLightGray,
        child: Stack(
          children: [
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(SizesValue.productImageRadius * 2),
                child: Center(
                    child: widget.product.imageUrl.isEmpty
                        ? Shimmer.fromColors(
                            baseColor: ColorPalette.lightGrey,
                            highlightColor: ColorPalette.extraLightGray,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey),
                            ),
                          )
                        : RoundedImage(
                            backgroundColor: Colors.transparent,
                            imgUrl: widget.product.imageUrl[selectedImage],
                            isNetworkImage: true,
                          )),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: FadeTranslateAnimation(
                delay: 1000,
                child: SizedBox(
                  height: 60,
                  child: Center(
                    child: ListView.builder(
                      itemCount: widget.product.imageUrl.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        String imageUrl = widget.product.imageUrl[index];

                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: widget.product.imageUrl.isEmpty
                              ? Shimmer.fromColors(
                                  baseColor: ColorPalette.lightGrey,
                                  highlightColor: ColorPalette.extraLightGray,
                                  child: Container(
                                    width: double.infinity,
                                    decoration:
                                        BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey),
                                  ),
                                )
                              : RoundedImage(
                                  width: 60,
                                  backgroundColor: Colors.transparent,
                                  border: Border.all(color: ColorPalette.primary),
                                  imgUrl: imageUrl,
                                  isNetworkImage: true,
                                  onPressed: () {
                                    ref.read(productDetailImageControllerProvider.notifier).changeImage(index);
                                  },
                                ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            CustomAppBar(
              mainContext: context,
              showBackArrow: true,
              actions: [
                IconButton(
                  onPressed: () {
                    if (isAmoungFavorite) {
                      ref.read(favoriteControllerProvider.notifier).deleteSingleItem(widget.product.id);
                      return;
                    }
                    ref.read(favoriteControllerProvider.notifier).addItemToFavorite(widget.product.id);
                  },
                  icon: CircularIcon(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2.0,
                        blurRadius: 4.0,
                      ),
                    ],
                    height: 40,
                    width: 40,
                    icon: isAmoungFavorite ? Iconsax.heart5 : Iconsax.heart,
                    color: isAmoungFavorite
                        ? Colors.red
                        : isDarkMode
                            ? Colors.white
                            : Colors.black,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
