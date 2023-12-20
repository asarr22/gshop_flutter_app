import 'package:flutter/material.dart';
import 'package:gshopp_flutter/features/shell/screens/cart.widgets/cart_item_card.dart';
import 'package:gshopp_flutter/features/shell/screens/cart.widgets/purchase_info.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/formatters/value_formater.dart';
import 'package:gshopp_flutter/utils/styles/rounded_container.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
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
                    onTap: () {},
                    child: Text(
                      TextValue.clearAll,
                      style: Theme.of(context).textTheme.bodySmall!.apply(color: ColorPalette.primary, fontWeightDelta: 2),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: 4,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return const CartItemCard();
                      }),
                ),

                // Footer
                const SizedBox(height: 10),
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
                      InfoDetailWidget(title: TextValue.purchase, info: Formatter.formatPrice(415000)),
                      const SizedBox(height: 5),
                      InfoDetailWidget(title: TextValue.shippingFee, info: Formatter.formatPrice(4000)),
                      const SizedBox(height: 5),
                      InfoDetailWidget(title: TextValue.total, info: Formatter.formatPrice(420000)),
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
        ),
      ),
    );
  }
}
