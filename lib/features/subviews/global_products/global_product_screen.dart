import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/features/subviews/global_products/widgets/global_product_list.dart';
import 'package:gshopp_flutter/features/subviews/global_products/widgets/subcategories_menu.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';
import 'package:iconsax/iconsax.dart';

class GlobalProductView extends StatelessWidget {
  const GlobalProductView({super.key, required this.pageTitle});
  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            pageTitle,
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_24),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Iconsax.filter,
              color: isDarkMode ? ColorPalette.onPrimaryDark : ColorPalette.onPrimaryLight,
            ),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: const SingleChildScrollView(
          child: Column(
        children: [
          // Category Filter
          SubcategoriesMenu(),

          SizedBox(height: 15),

          // List of Product
          GlobalProductList(),
        ],
      )),
    );
  }
}
