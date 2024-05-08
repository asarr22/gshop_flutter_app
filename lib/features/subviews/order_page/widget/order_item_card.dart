import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/models/order/order_model.dart';
import 'package:gshopp_flutter/features/shell/widgets/rounded_image.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/formatters/value_formater.dart';
import 'package:gshopp_flutter/utils/widgets/rounded_container.dart';
import 'package:gshopp_flutter/utils/styles/shadow.dart';
import 'package:gshopp_flutter/utils/helpers/helper_fuctions.dart';
import 'package:shimmer/shimmer.dart';

class OrderItemCard extends ConsumerWidget {
  const OrderItemCard({
    super.key,
    required this.orderItem,
  });

  final OrderItems orderItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = GHelper.isDarkMode(context);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SizesValue.padding / 2, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RoundedContainer(
                height: 80,
                backgroundColor: isDarkMode ? const Color.fromARGB(255, 71, 66, 59) : ColorPalette.extraLightGrayPlus,
                boxShadow: [ShadowStyle.tileListShadow],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 60,
                          child: orderItem.image.isEmpty
                              ? Shimmer.fromColors(
                                  baseColor: ColorPalette.lightGrey,
                                  highlightColor: ColorPalette.extraLightGray,
                                  child: Container(
                                    width: double.infinity,
                                    decoration:
                                        BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey),
                                  ),
                                )
                              : RoundedImage(
                                  imgUrl: orderItem.image,
                                  isNetworkImage: true,
                                  backgroundColor: Colors.transparent,
                                )),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      orderItem.name,
                                      style: Theme.of(context).textTheme.displaySmall,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${TextValue.capacity} : ",
                                  style: Theme.of(context).textTheme.labelMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  orderItem.size,
                                  style: Theme.of(context).textTheme.labelMedium!.apply(fontWeightDelta: 2),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: Text(
                                    "${TextValue.color} : ",
                                    style: Theme.of(context).textTheme.labelMedium,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Flexible(
                                  child: RoundedContainer(
                                    radius: 100,
                                    height: 15,
                                    width: 15,
                                    backgroundColor: Formatter.hexToColor(orderItem.color),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Formatter.formatPrice(orderItem.price.toDouble()),
                                    style: Theme.of(context).textTheme.displaySmall!.apply(fontWeightDelta: 2),
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
            ],
          ),
        ),
        if (orderItem.quantity > 1)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorPalette.primary,
              ),
              height: 25,
              width: 25,
              child: Center(
                child: Text(
                  "x${orderItem.quantity}",
                  style: Theme.of(context).textTheme.labelSmall!.apply(fontSizeDelta: 1.2),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
