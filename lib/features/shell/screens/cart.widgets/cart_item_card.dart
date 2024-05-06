import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/controllers/user_cart_controller.dart';
import 'package:gshopp_flutter/common/models/user/user_cart_model.dart';
import 'package:gshopp_flutter/features/shell/screens/cart.widgets/quantity_widget.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/images_values.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/formatters/value_formater.dart';
import 'package:gshopp_flutter/utils/widgets/rounded_container.dart';
import 'package:gshopp_flutter/utils/styles/shadow.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';
import 'package:shimmer/shimmer.dart';

class CartItemCard extends ConsumerWidget {
  const CartItemCard({
    super.key,
    required this.cartItem,
  });

  final UserCartItemModel cartItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = HelperFunctions.isDarkMode(context);
    // Future<int> getRemainingStockFromVariant() async {
    //   return ref
    //       .watch(productRepositoryProvider)
    //       .getProductStockFromVariant(cartItem.productId, cartItem.color, cartItem.size);
    // }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SizesValue.padding / 2, horizontal: 2),
      child: RoundedContainer(
        height: 95,
        backgroundColor: isDarkMode ? const Color.fromARGB(255, 71, 66, 59) : ColorPalette.extraLightGrayPlus,
        boxShadow: [ShadowStyle.tileListShadow],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: 65,
                child: cartItem.productImage.isEmpty
                    ? Shimmer.fromColors(
                        baseColor: ColorPalette.lightGrey,
                        highlightColor: ColorPalette.extraLightGray,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey),
                        ),
                      )
                    : Image.network(
                        cartItem.productImage.isEmpty ? ImagesValue.monitorIcon : cartItem.productImage,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              color: ColorPalette.primary,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(
                width: 5,
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
                          Flexible(
                            child: Text(
                              cartItem.productName,
                              style: Theme.of(context).textTheme.displaySmall,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              ref.read(userCartControllerProvider.notifier).deleteSingleItem(cartItem);
                            },
                            child: const Icon(
                              Icons.delete,
                              size: 20,
                              color: Colors.redAccent,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "${TextValue.capacity} : ",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Text(
                          cartItem.size,
                          style: Theme.of(context).textTheme.labelMedium!.apply(fontWeightDelta: 2),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${TextValue.color} : ",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        RoundedContainer(
                          radius: 100,
                          height: 15,
                          width: 15,
                          backgroundColor: Formatter.hexToColor(cartItem.color),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Formatter.formatPrice(cartItem.productPrice.toDouble()),
                            style: Theme.of(context).textTheme.displaySmall!.apply(fontWeightDelta: 2),
                          ),
                          CartQuantityWidget(
                            cartItem,
                            quantityValue: cartItem.quantity,
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
