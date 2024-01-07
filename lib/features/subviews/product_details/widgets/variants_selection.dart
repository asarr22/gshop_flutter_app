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
    return Row(
      children: [
        // Color Section
        Expanded(
          child: Column(
            children: [
              Text(
                TextValue.colors,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: variants.length,
                  itemBuilder: (context, index) {
                    final variant = variants[index];
                    Color color = Color(int.parse(variant.color.substring(1, 7), radix: 16) + 0xFF000000);
                    return GestureDetector(
                      onTap: () {
                        ref.read(selectedVariantProvider.notifier).selectVariant(variant);
                        ref.read(selectedSizeProvider.notifier).resetSelection();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RoundedContainer(
                          backgroundColor: color,
                          height: 35,
                          width: 35,
                          radius: 100,
                          borderColor: selectedVariant?.color == variant.color
                              ? isDarkMode
                                  ? ColorPalette.primaryDark
                                  : ColorPalette.primary
                              : Colors.transparent,
                          showBorder: true,
                          borderThickness: 4,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 5,
          height: 50,
          child: VerticalDivider(
            color: Colors.grey,
          ),
        ),

        // SizeSection
        Expanded(
          child: Column(
            children: [
              Text(
                TextValue.specs,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              if (selectedVariant != null)
                SizedBox(
                  width: double.infinity,
                  height: 50,
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
                          padding: const EdgeInsets.all(8.0),
                          child: RoundedContainer(
                            padding: const EdgeInsets.all(5),
                            height: 35,
                            radius: 100,
                            backgroundColor: Colors.transparent,
                            borderColor: selectedSize == size ? ColorPalette.primary : Colors.transparent,
                            showBorder: true,
                            borderThickness: 4,
                            child: Center(child: Text(size.size)),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
