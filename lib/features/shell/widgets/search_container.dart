import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    super.key,
    this.onTap,
    this.enableTextField = false,
    this.onChanged,
  });

  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final bool enableTextField;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    Widget searchContent = GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: isDarkMode ? ColorPalette.lightGrey : ColorPalette.extraLightGray,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: Colors.black,
            ),
            const SizedBox(width: 10),
            enableTextField
                ? Expanded(
                    child: TextField(
                    onChanged: onChanged,
                    style: Theme.of(context).textTheme.bodyLarge!.apply(color: Colors.black),
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: TextValue.search,
                      hintStyle: Theme.of(context).textTheme.bodyLarge!.apply(color: Colors.black),
                      contentPadding: const EdgeInsets.all(0.0),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ))
                : Text(
                    TextValue.search,
                    style: Theme.of(context).textTheme.labelMedium!.apply(color: Colors.black),
                  ),
          ],
        ),
      ),
    );

    // Only wrap with Hero if TextField is not enabled
    if (!enableTextField) {
      return Hero(
        tag: 'search',
        child: searchContent,
      );
    } else {
      return searchContent;
    }
  }
}
