import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/widgets/circular_icon.dart';
import 'package:gshopp_flutter/utils/helpers/helper_fuctions.dart';
import 'package:iconsax/iconsax.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false,
    required this.mainContext,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final BuildContext mainContext;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = GHelper.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding / 2),
      child: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: CircularIcon(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2.0,
                      blurRadius: 4.0,
                    ),
                  ],
                  height: 40,
                  width: 40,
                  icon: Iconsax.arrow_left_24,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              )
            : leadingIcon != null
                ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon))
                : null,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size(50, 50);
}
