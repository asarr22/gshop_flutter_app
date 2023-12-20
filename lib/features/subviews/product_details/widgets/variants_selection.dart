import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/features/subviews/product_details/state/variant_controller.dart';
import 'package:gshopp_flutter/features/subviews/product_details/state/variant_state_provider.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/styles/rounded_container.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';

final colorProvider =
    StateNotifierProvider<SelectedIndex, int>((ref) => SelectedIndex());
final sizeProvider =
    StateNotifierProvider<SelectedIndex, int>((ref) => SelectedIndex());

String selectedColor = "";
String selectedSize = "";

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
    //Managing Variants
    final List<Color> colors = variants
        .map((variant) => Color(
            int.parse(variant.color.substring(1, 7), radix: 16) + 0xFF000000))
        .toSet()
        .toList();

    final List<String> sizes =
        variants.map((variant) => variant.size).toSet().toList();

    //State Management
    final selectedColorIndex = ref.watch(colorProvider);
    final selectedSizeIndex = ref.watch(sizeProvider);

    //Dark/Light Mode
    final bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Text(
                TextValue.colors,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: colors.asMap().entries.map((entry) {
                    int idx = entry.key;
                    Color color = entry.value;
                    return GestureDetector(
                      onTap: () {
                        ref.read(colorProvider.notifier).select(idx);
                        selectedColor =
                            "#${colors[idx].value.toRadixString(16).substring(2).toUpperCase()}";

                        if (selectedSize != "") {
                          ref
                              .read(variantSelectionProvider.notifier)
                              .updateSelectedVariant(
                                  selectedColor, selectedSize, variants);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RoundedContainer(
                          backgroundColor: color,
                          height: 35,
                          width: 35,
                          radius: 100,
                          borderColor: idx == selectedColorIndex
                              ? isDarkMode
                                  ? ColorPalette.primaryDark
                                  : ColorPalette.primary
                              : Colors.transparent,
                          showBorder: true,
                          borderThickness: 4,
                        ),
                      ),
                    );
                  }).toList(),
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
        Expanded(
          child: Column(
            children: <Widget>[
              Text(
                TextValue.specs,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: sizes.asMap().entries.map((entry) {
                    int idx = entry.key;
                    String size = entry.value;
                    return GestureDetector(
                      onTap: () {
                        ref.read(sizeProvider.notifier).select(idx);
                        selectedSize = sizes[idx];
                        if (selectedColor != "") {
                          ref
                              .read(variantSelectionProvider.notifier)
                              .updateSelectedVariant(
                                  selectedColor, selectedSize, variants);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RoundedContainer(
                          height: 35,
                          radius: 100,
                          backgroundColor: Colors.transparent,
                          borderColor: idx == selectedSizeIndex
                              ? ColorPalette.primary
                              : Colors.transparent,
                          showBorder: true,
                          borderThickness: 4,
                          child: Center(child: Text(size)),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
