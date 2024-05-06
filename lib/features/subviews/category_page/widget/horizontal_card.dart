import 'package:flutter/material.dart';
import 'package:gshopp_flutter/common/models/category/category_model.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/widgets/rounded_container.dart';

class HorizontalCategoryCard extends StatelessWidget {
  const HorizontalCategoryCard({
    super.key,
    required this.isDarkMode,
    required this.item,
    this.onTap,
  });

  final bool isDarkMode;
  final CategoryItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: SizesValue.padding / 2, horizontal: 2),
        child: RoundedContainer(
          height: 100,
          width: double.infinity,
          backgroundColor: isDarkMode ? const Color.fromARGB(255, 71, 66, 59) : ColorPalette.extraLightGrayPlus,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1.5,
              blurRadius: 5.0,
              offset: const Offset(-1, 4),
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: [
                Container(
                  height: 56,
                  width: 56,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: (isDarkMode ? Colors.white : Colors.white),
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image(
                    image: AssetImage(item.image),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.bodyLarge!.apply(fontSizeDelta: 2, fontWeightDelta: 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
