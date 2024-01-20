import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/controllers/user_cart_controller.dart';
import 'package:gshopp_flutter/common/models/product/user_cart_model.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/styles/rounded_container.dart';

class CartQuantityWidget extends ConsumerWidget {
  const CartQuantityWidget(
    this.item, {
    super.key,
    required this.quantityValue,
  });

  final int quantityValue;
  final UserCartItemModel item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        RoundedContainer(
          height: 30,
          width: 30,
          radius: 100,
          backgroundColor: ColorPalette.primary,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            onTap: () => ref.read(userCartControllerProvider.notifier).decreaseQuantity(item),
            child: Center(
              child: Text(
                "-",
                style: Theme.of(context).textTheme.labelLarge!.apply(fontSizeDelta: 1),
              ),
            ),
          ),
        ),
        RoundedContainer(
          height: 30,
          width: 30,
          radius: 100,
          backgroundColor: Colors.transparent,
          child: Center(
            child: Text(
              quantityValue.toString(),
              style: Theme.of(context).textTheme.labelLarge!.apply(fontSizeDelta: 1),
            ),
          ),
        ),
        RoundedContainer(
          height: 30,
          width: 30,
          radius: 100,
          backgroundColor: ColorPalette.primary,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            onTap: () => ref.read(userCartControllerProvider.notifier).increaseQuantity(item),
            child: Center(
              child: Text(
                "+",
                style: Theme.of(context).textTheme.labelLarge!.apply(fontSizeDelta: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
