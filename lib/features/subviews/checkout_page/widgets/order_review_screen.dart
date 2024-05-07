import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/controllers/app_parameters_controller.dart';
import 'package:gshopp_flutter/common/controllers/user_cart_controller.dart';
import 'package:gshopp_flutter/common/controllers/user_controller.dart';
import 'package:gshopp_flutter/features/shell/screens/cart.widgets/cart_item_card.dart';
import 'package:gshopp_flutter/features/shell/screens/cart.widgets/purchase_info.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/formatters/value_formater.dart';

class OrderReviewScreen extends ConsumerWidget {
  const OrderReviewScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(userCartControllerProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final user = ref.watch(userControllerProvider);
    final appParameter = ref.watch(appControllerProvider);
    double totalBrute =
        cartItems.isEmpty ? 0 : cartItems.map((e) => e.productPrice * e.quantity).reduce((a, b) => a + b).toDouble();

    double couponDiscount = 0;
    double userShippingFee() {
      try {
        final cities = appParameter['shippingFee'];
        final defaultAddress = user.address.isEmpty ? null : user.address.singleWhere((element) => element.isDefault);
        final userCity = cities.singleWhere((element) => element.name == defaultAddress?.city);
        final userZone = userCity.zones.singleWhere((element) => element.name == defaultAddress?.zone);
        return userZone.shippingFee;
      } catch (e) {
        return 0;
      }
    }

    // Get Default Address from user
    final defaultAddress = user.address.firstWhere((element) => element.isDefault == true);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
        child: Column(
          children: [
            ExpansionTile(
              initiallyExpanded: true,
              collapsedBackgroundColor: isDarkMode ? ColorPalette.backgroundDark : ColorPalette.backgroundLight,
              title: Text('${TextValue.item} (${cartItems.length})', style: Theme.of(context).textTheme.labelLarge),
              children: [
                Container(
                  color: isDarkMode ? ColorPalette.darkGrey : ColorPalette.extraLightGrayPlus,
                  height: 250,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: cartItems.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        final item = cartItems[index];
                        return CartItemCard(
                          cartItem: item,
                        );
                      }),
                )
              ],
            ),

            // Order Summary
            const SizedBox(height: SizesValue.defaultSpace * 2),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    TextValue.shippingInfo,
                    style: Theme.of(context).textTheme.bodyLarge!.apply(fontSizeDelta: 2, fontWeightDelta: 2),
                  ),
                  const SizedBox(height: SizesValue.defaultSpace),
                  InfoDetailWidget(title: TextValue.name, info: defaultAddress.fullName),
                  InfoDetailWidget(title: TextValue.address, info: defaultAddress.address),
                  InfoDetailWidget(title: TextValue.phoneNo, info: defaultAddress.phoneNumber),
                  InfoDetailWidget(title: TextValue.city, info: defaultAddress.city),
                  InfoDetailWidget(title: TextValue.zone, info: defaultAddress.zone),
                  const SizedBox(height: SizesValue.defaultSpace),
                  Text(
                    TextValue.orderInfo,
                    style: Theme.of(context).textTheme.bodyLarge!.apply(fontSizeDelta: 2, fontWeightDelta: 2),
                  ),
                  const SizedBox(height: SizesValue.defaultSpace),
                  InfoDetailWidget(title: TextValue.purchase, info: Formatter.formatPrice(totalBrute)),
                  InfoDetailWidget(title: TextValue.shippingFee, info: Formatter.formatPrice(userShippingFee())),
                  InfoDetailWidget(title: TextValue.couponValue, info: Formatter.formatPrice(couponDiscount)),
                  const Divider(),
                  InfoDetailWidget(
                      title: TextValue.total,
                      info: Formatter.formatPrice(totalBrute + userShippingFee() - couponDiscount)),
                  const SizedBox(height: SizesValue.defaultSpace),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
