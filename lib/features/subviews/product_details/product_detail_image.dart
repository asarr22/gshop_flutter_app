import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/features/shell/widgets/rounded_image.dart';
import 'package:gshopp_flutter/features/subviews/product_details/state/product_details_image_controller.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/images_values.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/custom_widget/custom_app_bar.dart';
import 'package:gshopp_flutter/utils/styles/circular_icon.dart';
import 'package:gshopp_flutter/utils/styles/curved_edge_widget.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailImage extends ConsumerWidget {
  const ProductDetailImage({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    final selectedImage = ref.watch(productDetailImageControllerProvider);
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
                  child: product.imageUrl.isEmpty
                      ? Shimmer.fromColors(
                          baseColor: ColorPalette.lightGrey,
                          highlightColor: ColorPalette.extraLightGray,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey),
                          ),
                        )
                      : Image.network(
                          product.imageUrl[selectedImage].isEmpty
                              ? ImagesValue.monitorIcon
                              : product.imageUrl[selectedImage],
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
              ),
            ),
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 60,
                child: Center(
                  child: ListView.builder(
                    itemCount: product.imageUrl.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      String imageUrl = product.imageUrl[index];

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: product.imageUrl.isEmpty
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
            CustomAppBar(
              mainContext: context,
              showBackArrow: true,
              actions: [
                IconButton(
                  onPressed: () {},
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
                    icon: Icons.favorite,
                    color: Colors.red,
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
