import 'package:flutter/material.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/features/shell/widgets/rounded_image.dart';
import 'package:gshopp_flutter/features/subviews/product_details/product_detail_page.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/formatters/value_formater.dart';
import 'package:gshopp_flutter/utils/styles/circular_icon.dart';
import 'package:gshopp_flutter/utils/styles/rounded_container.dart';
import 'package:gshopp_flutter/utils/styles/shadow.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailPage(product.id)));
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
                        '${product.discountValue}%',
                        style:
                            Theme.of(context).textTheme.labelSmall!.apply(color: ColorPalette.black, fontSizeDelta: 2),
                      ),
                    ),
                  )),
              const Positioned(
                top: 0,
                right: 0,
                child: CircularIcon(
                  icon: Icons.favorite,
                  color: Colors.red,
                  backgroundColor: ColorPalette.white,
                  size: 18,
                  height: 33,
                  width: 33,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, //New
                        blurRadius: 8.0,
                        spreadRadius: -2,
                        offset: Offset(1, 1))
                  ],
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
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        Formatter.formatPrice(Formatter.applyDiscount(product.price.toDouble(), product.discountValue)),
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
