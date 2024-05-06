import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/widgets/rounded_container.dart';
import 'package:gshopp_flutter/utils/styles/shadow.dart';
import 'package:gshopp_flutter/utils/helpers/helper_fuctions.dart';
import 'package:iconsax/iconsax.dart';

class ButtonCardTile extends StatelessWidget {
  const ButtonCardTile({
    super.key,
    required this.title,
    this.description = "",
    this.onTap,
    this.implyDescription = true,
  });

  final String title;
  final String description;
  final VoidCallback? onTap;
  final bool implyDescription;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = GHelper.isDarkMode(context);
    return RoundedContainer(
      height: 70,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      boxShadow: [ShadowStyle.tileListShadow],
      backgroundColor: isDarkMode ? const Color.fromARGB(255, 71, 66, 59) : ColorPalette.extraLightGrayPlus,
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: implyDescription ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(
                    child: implyDescription
                        ? Text(
                            description,
                            style: Theme.of(context).textTheme.labelMedium!.apply(color: ColorPalette.grey),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          )
                        : null,
                  ),
                ],
              ),
            ),
            const Icon(
              Iconsax.arrow_right_34,
              size: 20,
              color: ColorPalette.grey,
            ),
          ],
        ),
      ),
    );
  }
}
