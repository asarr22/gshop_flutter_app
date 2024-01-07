import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/features/subviews/product_details/product_detail_page.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/formatters/value_formater.dart';

class ProductDetailBottomBar extends ConsumerWidget {
  const ProductDetailBottomBar({
    super.key,
    required this.selectedQuantityValue,
    required this.product,
    required this.isDarkMode,
  });

  final int selectedQuantityValue;
  final Product product;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSize = ref.watch(selectedSizeProvider);
    final bool isSelectedVariantAvailable = selectedSize != null && selectedSize.stock > 0;

    return SizedBox(
      height: 110,
      width: double.infinity,
      child: Column(children: [
        const Divider(
          indent: 10,
          endIndent: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding, vertical: SizesValue.padding / 2),
          child: SizedBox(
            height: 70,
            child: ElevatedButton(
                onPressed: !isSelectedVariantAvailable ? null : () {},
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_shopping_cart_outlined,
                      color: isSelectedVariantAvailable ? Colors.white : ColorPalette.primary,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      TextValue.addToCard,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(color: isSelectedVariantAvailable ? Colors.white : ColorPalette.primary),
                    ),
                    Visibility(
                      visible: isSelectedVariantAvailable,
                      child: const VerticalDivider(
                        indent: 20,
                        endIndent: 20,
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
                                selectedSize == null ? 0 : selectedSize.price.toDouble() * selectedQuantityValue, product.discountValue)),
                            style: Theme.of(context).textTheme.displayMedium!.apply(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            Formatter.formatPrice(selectedSize == null ? 0 : selectedSize.price.toDouble() * selectedQuantityValue),
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
