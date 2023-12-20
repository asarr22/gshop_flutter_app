import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.onTap,
    this.showActionButton = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
  });

  final String title;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final bool showActionButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.displayMedium!.apply(fontWeightDelta: 5),
            ),
            if (showActionButton)
              InkWell(
                onTap: onTap,
                child: Ink(
                  padding: const EdgeInsets.only(top: 5),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        TextValue.seeAll,
                        style: TextStyle(fontFamily: 'Roboto', fontSize: 16, fontWeight: FontWeight.w500, color: ColorPalette.primary),
                      ),
                      SizedBox(width: 2),
                      Icon(
                        Icons.arrow_right_alt_outlined,
                        color: ColorPalette.primary,
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
