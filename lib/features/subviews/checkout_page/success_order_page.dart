import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/features/subviews/order_page/order_page.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/images_values.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:iconsax/iconsax.dart';

class SuccessOrderPage extends StatelessWidget {
  const SuccessOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: ColorPalette.secondary3,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_24),
          onPressed: () => Get.back(),
        ),
        title: Text(
          TextValue.orderStatus,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(ImagesValue.orderSuccess),
              ),
            ),
          ),
          const SizedBox(height: SizesValue.spaceBtwSections),
          Container(
            height: 310,
            width: double.infinity,
            padding: const EdgeInsets.all(SizesValue.padding),
            decoration: BoxDecoration(
              color: isDarkMode ? ColorPalette.backgroundDark : ColorPalette.backgroundLight,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
            ),
            child: Column(children: [
              const SizedBox(height: SizesValue.spaceBtwSections),
              Text(
                TextValue.orderPlacedSuccessfly,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: SizesValue.spaceBtwSections * 2),
              Text(
                TextValue.orderPlacedSuccessflyDescription,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: SizesValue.spaceBtwSections * 2),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {
                    Get.back();
                    Get.off(() => const OrderPage());
                  },
                  child: const Text(
                    TextValue.trackOrder,
                  ),
                ),
              ),
              const SizedBox(height: SizesValue.spaceBtwSections),
              SizedBox(
                height: 56,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                  child: const Text(TextValue.continueShopping),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
