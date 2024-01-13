import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/features/subviews/product_details/product_detail_page.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/styles/rounded_container.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';

class VariantSelection extends StatelessWidget {
  const VariantSelection({
    super.key,
    required this.ref,
    required this.variants,
  });

  final List<Variant> variants;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    //State Management

    final selectedVariant = ref.watch(selectedVariantProvider);
    final selectedSize = ref.watch(selectedSizeProvider);

    // Dark/Light Mode
    final bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Column(
      children: [
        // Color Variant
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorPalette.secondary,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  TextValue.colors,
                  style: Theme.of(context).textTheme.displayMedium!.apply(color: Colors.black),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: variants.length,
                    itemBuilder: (context, index) {
                      final variant = variants[index];
                      Color color = variant.color == ""
                          ? Colors.grey
                          : Color(int.parse(variant.color.substring(1, 7), radix: 16) + 0xFF000000);
                      return GestureDetector(
                        onTap: () {
                          ref.read(selectedVariantProvider.notifier).selectVariant(variant);
                          ref.read(selectedSizeProvider.notifier).resetSelection();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: RoundedContainer(
                            backgroundColor: color,
                            height: 35,
                            width: 35,
                            radius: 100,
                            elevation: 5,
                            borderColor: selectedVariant?.color == variant.color
                                ? isDarkMode
                                    ? ColorPalette.primaryDark
                                    : ColorPalette.primary
                                : Colors.transparent,
                            showBorder: true,
                            borderThickness: 4,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Size Variant
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorPalette.secondary,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  TextValue.specs,
                  style: Theme.of(context).textTheme.displayMedium!.apply(color: Colors.black),
                ),
              ),
              const SizedBox(width: 10),
              selectedVariant != null
                  ? Expanded(
                      child: SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: selectedVariant.size.length,
                          itemBuilder: (context, index) {
                            final size = selectedVariant.size[index];
                            return GestureDetector(
                              onTap: () {
                                ref.read(selectedSizeProvider.notifier).selectSize(size);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: RoundedContainer(
                                  padding: const EdgeInsets.all(2.0),
                                  height: 35,
                                  radius: 100,
                                  backgroundColor: Colors.transparent,
                                  borderColor: selectedSize == size ? ColorPalette.primary : Colors.transparent,
                                  showBorder: true,
                                  borderThickness: 4,
                                  child: Center(
                                      child: Text(
                                    size.size,
                                    style: Theme.of(context).textTheme.labelLarge,
                                  )),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Text(
                      TextValue.selectAColorFirst,
                      style: Theme.of(context).textTheme.labelMedium!.apply(color: Colors.red),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
