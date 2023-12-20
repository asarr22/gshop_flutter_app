import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/styles/rounded_container.dart';

class CartQuantityWidget extends StatelessWidget {
  const CartQuantityWidget({
    super.key,
    required this.quantityValue,
  });

  final int quantityValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundedContainer(
          height: 30,
          width: 30,
          backgroundColor: ColorPalette.primary,
          child: Center(
            child: Text(
              "-",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(fontSizeDelta: 1),
            ),
          ),
        ),
        RoundedContainer(
          height: 30,
          width: 30,
          backgroundColor: Colors.transparent,
          child: Center(
            child: Text(
              quantityValue.toString(),
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(fontSizeDelta: 1),
            ),
          ),
        ),
        RoundedContainer(
          height: 30,
          width: 30,
          backgroundColor: ColorPalette.primary,
          child: Center(
            child: Text(
              "+",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(fontSizeDelta: 1),
            ),
          ),
        ),
      ],
    );
  }
}
