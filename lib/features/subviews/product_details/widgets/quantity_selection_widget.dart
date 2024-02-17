import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/features/subviews/product_details/product_detail_page.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';

class QuantitySelectionWidget extends ConsumerWidget {
  const QuantitySelectionWidget({
    super.key,
    required this.ref,
    required this.selectedQuantityValue,
    required this.product,
  });

  final WidgetRef ref;
  final int selectedQuantityValue;
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedVariant = ref.watch(selectedVariantProvider);
    final selectedSize = ref.watch(selectedSizeProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorPalette.secondary.withOpacity(0.8),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            TextValue.quantitie,
            style: Theme.of(context).textTheme.displayMedium!.apply(color: Colors.black),
          ),
          Row(
            children: [
              SizedBox(
                height: 55,
                width: 55,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(quantityProvider.notifier).decrement();
                  },
                  child: Text('-', style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.white)),
                ),
              ),
              SizedBox(
                height: 55,
                width: 50,
                child: Center(
                    child: Text(selectedQuantityValue.toString(),
                        style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.black))),
              ),
              SizedBox(
                height: 55,
                width: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedSize?.size != null) {
                      // Get the available stock of selection before incrementing
                      int availableStock = HelperFunctions.getStockWithSizeAndColor(
                          product.variants, selectedVariant!.color, selectedSize!.size);
                      if (availableStock < 1) {
                        SnackBarPop.showErrorPopup(TextValue.insufficentStockMessage, duration: 3);
                        return;
                      }
                      ref.read(quantityProvider.notifier).increment(availableStock);
                    } else {
                      SnackBarPop.showErrorPopup(TextValue.selectColorAndSizeFirst, duration: 3);
                    }
                  },
                  child: Text('+', style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
