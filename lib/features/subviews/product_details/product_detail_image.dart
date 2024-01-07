import 'package:flutter/material.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/features/shell/widgets/rounded_image.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/custom_widget/custom_app_bar.dart';
import 'package:gshopp_flutter/utils/styles/circular_icon.dart';
import 'package:gshopp_flutter/utils/styles/curved_edge_widget.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';

class ProductDetailImage extends StatelessWidget {
  const ProductDetailImage({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
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
                  child: Image(
                    image: AssetImage(product.imageUrl[0]),
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
                    itemCount: 4,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: RoundedImage(
                          width: 60,
                          backgroundColor: isDarkMode ? ColorPalette.black : ColorPalette.white,
                          border: Border.all(color: ColorPalette.primary),
                          imgUrl: product.imageUrl[0],
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
