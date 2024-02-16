import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/features/subviews/product_details/product_detail_page.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/formatters/value_formater.dart';
import 'package:gshopp_flutter/utils/styles/rounded_container.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';
import 'package:iconsax/iconsax.dart';

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
              InkWell(
                child: Ink(
                  child: (selectedVariant != null)
                      ? Row(
                          children: [
                            Container(
                              height: 27,
                              width: 27,
                              decoration: BoxDecoration(
                                color: Formatter.hexToColor(selectedVariant.color),
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(Iconsax.arrow_down_1, size: 20, color: ColorPalette.secondary2),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                child: Text(TextValue.select,
                                    style:
                                        Theme.of(context).textTheme.labelLarge!.apply(color: ColorPalette.secondary2)),
                              ),
                              const SizedBox(width: 5),
                              const Icon(Iconsax.arrow_down_1, size: 20, color: ColorPalette.secondary2),
                            ],
                          ),
                        ),
                ),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isDismissible: true,
                    backgroundColor: Colors.transparent,
                    barrierColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (context) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: GestureDetector(
                        onTap: () {},
                        child: DraggableScrollableSheet(
                          initialChildSize: 0.5,
                          minChildSize: 0.25,
                          maxChildSize: 1,
                          builder: (_, controller) {
                            return Container(
                              decoration: BoxDecoration(
                                color: isDarkMode ? ColorPalette.backgroundDark : ColorPalette.backgroundLight,
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(SizesValue.padding),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 5,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: isDarkMode ? Colors.white : Colors.black,
                                          borderRadius: BorderRadius.circular(100)),
                                    ),
                                    const SizedBox(height: SizesValue.spaceBtwSections),
                                    Text(
                                      TextValue.colors,
                                      style: Theme.of(context).textTheme.displayMedium,
                                    ),
                                    const SizedBox(height: SizesValue.spaceBtwSections),

                                    // Color List
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: variants.length,
                                        itemBuilder: (__, index) {
                                          final variant = variants[index];
                                          Color color =
                                              variant.color == "" ? Colors.grey : Formatter.hexToColor(variant.color);
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: GestureDetector(
                                              onTap: () {
                                                ref.read(selectedVariantProvider.notifier).selectVariant(variant);
                                                ref.read(selectedSizeProvider.notifier).resetSelection();
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                clipBehavior: Clip.antiAlias,
                                                height: 60,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: selectedVariant?.color == variant.color
                                                      ? ColorPalette.secondary
                                                      : isDarkMode
                                                          ? ColorPalette.containerDark
                                                          : ColorPalette.containerLight,
                                                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                                                ),
                                                padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding / 2),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        RoundedContainer(
                                                          backgroundColor: color,
                                                          height: 35,
                                                          width: 35,
                                                          radius: 100,
                                                          elevation: 5,
                                                          borderThickness: 4,
                                                          strokeAlign: BorderSide.strokeAlignOutside,
                                                        ),
                                                        const SizedBox(width: SizesValue.spaceBtwItems),
                                                        Text(
                                                          "${TextValue.color} ${index + 1}",
                                                          style: Theme.of(context).textTheme.labelLarge!.apply(
                                                              color: selectedVariant?.color == variant.color
                                                                  ? Colors.black
                                                                  : isDarkMode
                                                                      ? Colors.white
                                                                      : Colors.black),
                                                        )
                                                      ],
                                                    ),

                                                    // Tick Icon
                                                    if (selectedVariant?.color == variant.color)
                                                      const Icon(Icons.check, color: Colors.black),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  TextValue.specs,
                  style: Theme.of(context).textTheme.displayMedium!.apply(color: Colors.black),
                ),
              ),
              if (selectedVariant != null)
                InkWell(
                  child: Ink(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        selectedSize?.size != null
                            ? Row(
                                children: [
                                  SizedBox(
                                    child: Text(
                                      selectedSize!.size,
                                      style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Iconsax.arrow_down_1,
                                    size: 20,
                                    color: ColorPalette.secondary2,
                                  ),
                                ],
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      child: Text(
                                        TextValue.select,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .apply(color: ColorPalette.secondary2),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Icon(Iconsax.arrow_down_1, size: 20, color: ColorPalette.secondary2),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isDismissible: true,
                      backgroundColor: Colors.transparent,
                      barrierColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) => GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: GestureDetector(
                          onTap: () {},
                          child: DraggableScrollableSheet(
                            initialChildSize: 0.5,
                            minChildSize: 0.25,
                            maxChildSize: 1,
                            builder: (_, controller) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: isDarkMode ? ColorPalette.backgroundDark : ColorPalette.backgroundLight,
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20)), // Rounded corners at the top
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(SizesValue.padding),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 5,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            color: isDarkMode ? Colors.white : Colors.black,
                                            borderRadius: BorderRadius.circular(100)),
                                      ),
                                      const SizedBox(height: SizesValue.spaceBtwSections),
                                      Text(
                                        TextValue.specs,
                                        style: Theme.of(context).textTheme.displayMedium,
                                      ),
                                      const SizedBox(height: SizesValue.spaceBtwSections),
                                      // Size List
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: selectedVariant.size.length,
                                          itemBuilder: (__, index) {
                                            final size = selectedVariant.size[index];
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 10),
                                              child: GestureDetector(
                                                onTap: () {
                                                  ref.read(selectedSizeProvider.notifier).selectSize(size);
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  clipBehavior: Clip.antiAlias,
                                                  height: 60,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: selectedSize == size
                                                        ? ColorPalette.secondary
                                                        : isDarkMode
                                                            ? ColorPalette.lightGrey
                                                            : ColorPalette.extraLightGray,
                                                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                                                  ),
                                                  padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        size.size,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelLarge!
                                                            .apply(color: Colors.black),
                                                      ),

                                                      // Tick Icon
                                                      if (selectedSize == size)
                                                        const Icon(
                                                          Icons.check,
                                                          color: Colors.black,
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                )
              else
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    TextValue.selectAColorFirst,
                    style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.grey),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
