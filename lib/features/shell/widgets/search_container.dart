import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    super.key,
    this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    return InkWell(
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color:
              isDarkMode ? ColorPalette.lightGrey : ColorPalette.extraLightGray,
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: isDarkMode ? Colors.black : Colors.black,
            ),
            const SizedBox(width: 10),
            Text(
              TextValue.search,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
