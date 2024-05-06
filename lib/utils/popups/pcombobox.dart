import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/helpers/helper_fuctions.dart';
import 'package:gshopp_flutter/utils/widgets/rounded_container.dart';
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
    bool isDarkMode = GHelper.isDarkMode(context);

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
