import 'package:flutter/material.dart';
import 'package:gshopp_flutter/features/shell/screens/cart.widgets/quantity_widget.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/images_values.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/formatters/value_formater.dart';
import 'package:gshopp_flutter/utils/styles/rounded_container.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: SizesValue.padding / 2, horizontal: 2),
      child: RoundedContainer(
        height: 90,
        backgroundColor:
            isDarkMode ? ColorPalette.grey : ColorPalette.extraLightGrayPlus,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1.5,
            blurRadius: 5.0,
            offset: const Offset(-1, 4),
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const SizedBox(
                width: 80,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image(image: AssetImage(ImagesValue.productImg2)),
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "IPhone 13 Pro Max",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.delete,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "${TextValue.capacity} : ",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Text(
                          "256GB",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .apply(fontWeightDelta: 2),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${TextValue.color} : ",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const RoundedContainer(
                          radius: 100,
                          height: 20,
                          width: 20,
                          backgroundColor: Colors.grey,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Formatter.formatPrice(410000),
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .apply(fontWeightDelta: 2),
                          ),
                          const CartQuantityWidget(
                            quantityValue: 1,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
