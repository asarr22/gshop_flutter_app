import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/controllers/app_parameters_controller.dart';
import 'package:gshopp_flutter/common/controllers/user_cart_controller.dart';
import 'package:gshopp_flutter/features/shell/screens/cart.widgets/cart_item_card.dart';
import 'package:gshopp_flutter/features/shell/screens/cart.widgets/purchase_info.dart';
import 'package:gshopp_flutter/features/shell/screens/home.widgets/user_greetings_banner.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/formatters/value_formater.dart';
import 'package:gshopp_flutter/utils/styles/rounded_container.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(userCartControllerProvider);
    double totalBrute =
        cartItems.isEmpty ? 0 : cartItems.map((e) => e.productPrice * e.quantity).reduce((a, b) => a + b).toDouble();
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    final user = ref.watch(userControllerProvider);
    final appParameter = ref.watch(appControllerProvider);

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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Align(
            alignment: Alignment.center,
            child: Text(
              TextValue.cart,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      ref.read(userCartControllerProvider.notifier).clearAll();
                    },
                    child: Text(
                      TextValue.clearAll,
                      style:
                          Theme.of(context).textTheme.bodySmall!.apply(color: ColorPalette.primary, fontWeightDelta: 2),
                    ),
                  ),
                ),

                cartItems.isNotEmpty
                    ? Container(
                        constraints: const BoxConstraints(minHeight: 360),
                        width: double.infinity,
                        child: ListView.builder(
                            itemCount: cartItems.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (_, index) {
                              final item = cartItems[index];
                              return CartItemCard(
                                cartItem: item,
                              );
                            }),
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: Center(
                          child: Text(
                            TextValue.noItem,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        )),
                const SizedBox(height: 10),

                // Footer

                Visibility(
                  visible: cartItems.isEmpty ? false : true,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              TextValue.orderInfo,
                              style: Theme.of(context).textTheme.bodyLarge!.apply(fontSizeDelta: 2, fontWeightDelta: 2),
                            ),
                            const SizedBox(height: 10),
                            InfoDetailWidget(title: TextValue.purchase, info: Formatter.formatPrice(totalBrute)),
                            const SizedBox(height: 5),
                            InfoDetailWidget(
                                title: TextValue.shippingFee, info: Formatter.formatPrice(userShippingFee())),
                            const SizedBox(height: 5),
                            InfoDetailWidget(
                                title: TextValue.total, info: Formatter.formatPrice(totalBrute + userShippingFee())),
                            const SizedBox(height: 10),
                            Container(
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: isDarkMode ? ColorPalette.lightGrey : ColorPalette.extraLightGray,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const Expanded(
                                      child: TextField(
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.horizontal_split,
                                        color: ColorPalette.darkGrey,
                                      ),
                                      hintText: TextValue.couponCode,
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  )),
                                  RoundedContainer(
                                    height: 40,
                                    width: 40,
                                    margin: const EdgeInsets.all(5),
                                    backgroundColor: ColorPalette.primary,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text(TextValue.checkout),
                        ),
                      ),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
