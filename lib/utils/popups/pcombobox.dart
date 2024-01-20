import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/styles/rounded_container.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';
import 'package:iconsax/iconsax.dart';

class PComboBox extends StatelessWidget {
  const PComboBox({
    super.key,
    required this.tite,
    this.onTap,
  });

  final String tite;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    return RoundedContainer(
      width: double.infinity,
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      backgroundColor: isDarkMode ? ColorPalette.darkGrey : ColorPalette.extraLightGray,
      child: InkWell(
        onTap: onTap,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tite,
                style: Theme.of(context).textTheme.bodyLarge,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const Icon(Iconsax.arrow_right_34)
            ],
          ),
        ),
      ),
    );
  }
}
