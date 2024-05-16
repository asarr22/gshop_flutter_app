import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/controllers/app_parameters_controller.dart';
import 'package:gshopp_flutter/common/controllers/user_cart_controller.dart';
import 'package:gshopp_flutter/common/controllers/user_controller.dart';
import 'package:gshopp_flutter/features/shell/screens/cart.widgets/cart_item_card.dart';
import 'package:gshopp_flutter/features/shell/screens/cart.widgets/purchase_info.dart';
import 'package:gshopp_flutter/features/subviews/checkout_page/checkout_page.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/formatters/value_formater.dart';
import 'package:gshopp_flutter/utils/helpers/helper_fuctions.dart';
import 'package:gshopp_flutter/utils/widgets/rounded_container.dart';
import 'package:iconsax/iconsax.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(userCartControllerProvider);
    double totalBrute =
        cartItems.isEmpty ? 0 : cartItems.map((e) => e.productPrice * e.quantity).reduce((a, b) => a + b).toDouble();
    bool isDarkMode = GHelper.isDarkMode(context);
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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_24),
          onPressed: () => Get.back(),
        ),
        title: Align(
          alignment: Alignment.center,
          child: Text(
            TextValue.cart,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: RoundedContainer(
              height: 30,
              width: 30,
              radius: 100,
              backgroundColor: isDarkMode ? ColorPalette.primaryDark : ColorPalette.primaryLight,
              child: Center(
                child: Text(
                  cartItems.length.toString(),
                  style: Theme.of(context).textTheme.bodySmall!.apply(color: Colors.white),
                ),
              ),
            ),
          )
        ],
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
                      constraints: const BoxConstraints(minHeight: 300),
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
                      height: GHelper.screenHeight(context) - 150,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconsax.shopping_cart, size: 100, color: isDarkMode ? Colors.white : Colors.black),
                            const SizedBox(height: SizesValue.spaceBtwItems),
                            Text(
                              TextValue.yourCartIsEmpty,
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          ],
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
                          couponCodeContainer(isDarkMode),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: Material(
                        elevation: 7,
                        borderRadius: BorderRadius.circular(100),
                        shadowColor: ColorPalette.primary,
                        child: ElevatedButton(
                          style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                                elevation: WidgetStateProperty.all(0),
                              ),
                          onPressed: () {
                            Get.to(() => const CheckoutPage());
                          },
                          child: const Text(TextValue.checkout),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: SizesValue.spaceBtwSections * 2,
              )
            ],
          ),
        ),
      ),
    );
  }

  Container couponCodeContainer(bool isDarkMode) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDarkMode ? ColorPalette.darkGrey : ColorPalette.extraLightGray,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.horizontal_split,
                color: isDarkMode ? Colors.white : Colors.black,
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
            radius: 100,
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
    );
  }
}
