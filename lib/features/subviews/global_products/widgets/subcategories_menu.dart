import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/features/subviews/global_products/state/subcategories_menu_state.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/helpers/helper_fuctions.dart';
import 'package:dotted_line/dotted_line.dart';

class SubcategoriesMenu extends ConsumerWidget {
  const SubcategoriesMenu({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = GHelper.isDarkMode(context);

    final subcategoryState = ref.watch(subcategoryProvider);
    final subcategories = subcategoryState.subcategories;
    final selectedSubcategory = subcategoryState.selectedSubcategory ?? subcategories[0];

    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: subcategories.length,
        itemBuilder: (context, index) {
          final subcategory = subcategories[index];
          bool isSelected = selectedSubcategory.id == subcategory.id;
          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => ref.read(subcategoryProvider.notifier).selectSubcategory(subcategory),
            child: SizedBox(
              width: 90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    subcategory.name,
                    style: Theme.of(context).textTheme.labelMedium!.apply(
                        fontWeightDelta: 1,
                        color: isSelected
                            ? ColorPalette.primary
                            : isDarkMode
                                ? ColorPalette.onPrimaryDark
                                : ColorPalette.onPrimaryLight),
                  ),
                  DottedLine(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    lineLength: 60.0,
                    lineThickness: 4.0,
                    dashLength: 4.0,
                    dashColor: isSelected
                        ? ColorPalette.primary
                        : isDarkMode
                            ? ColorPalette.onPrimaryDark
                            : ColorPalette.onPrimaryLight,
                    dashRadius: 100.0,
                    dashGapLength: 3.0,
                    dashGapColor: Colors.transparent,
                    dashGapRadius: 0.0,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
