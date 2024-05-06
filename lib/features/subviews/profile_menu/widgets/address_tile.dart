import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/widgets/rounded_container.dart';
import 'package:gshopp_flutter/utils/helpers/helper_fuctions.dart';
import 'package:iconsax/iconsax.dart';

class AddressTile extends StatelessWidget {
  const AddressTile({
    super.key,
    required this.selectedAddress,
    required this.fullName,
    required this.phoneNumber,
    required this.details,
    this.onTap,
    this.onRemove,
    this.onEdit,
  });

  final bool selectedAddress;
  final String fullName;
  final String phoneNumber;
  final String details;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = GHelper.isDarkMode(context);
    return InkWell(
      onTap: onTap,
      child: RoundedContainer(
        padding: const EdgeInsets.all(SizesValue.md),
        height: 160,
        borderColor: ColorPalette.grey,
        backgroundColor: selectedAddress ? ColorPalette.secondary.withOpacity(0.3) : Colors.transparent,
        width: double.infinity,
        showBorder: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(children: [
              SizedBox(
                width: double.infinity,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    fullName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: SizesValue.sm / 2),
                  Text(phoneNumber, maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: SizesValue.sm / 2),
                  Text(details, softWrap: true),
                ]),
              ),
              Positioned(
                right: 5,
                top: 0,
                child: Icon(
                  selectedAddress ? Iconsax.tick_circle5 : null,
                  color: selectedAddress
                      ? isDarkMode
                          ? ColorPalette.onPrimaryDark
                          : ColorPalette.onPrimaryLight
                      : null,
                ),
              ),
              Positioned(
                right: 5,
                top: 0,
                child: Icon(
                  selectedAddress ? Iconsax.tick_circle5 : null,
                  color: selectedAddress
                      ? isDarkMode
                          ? ColorPalette.onPrimaryDark
                          : ColorPalette.onPrimaryLight
                      : null,
                ),
              ),
            ]),
            SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: onEdit,
                    child: const Text(
                      TextValue.edit,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ColorPalette.primary,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: onRemove,
                    child: const Text(
                      TextValue.remove,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ColorPalette.primary,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
