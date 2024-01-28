import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/features/subviews/global_products/filter/filter_page.dart';
import 'package:gshopp_flutter/features/subviews/global_products/widgets/global_product_list.dart';
import 'package:gshopp_flutter/features/subviews/global_products/widgets/subcategories_menu.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';
import 'package:iconsax/iconsax.dart';

class GlobalProductPage extends StatelessWidget {
  const GlobalProductPage({super.key, required this.pageTitle, this.query});
  final String pageTitle;

  final Query<Map<String, dynamic>>? query;

  @override
  Widget build(BuildContext context) {
    HelperFunctions.mainQueryHandler = query!;
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
            onPressed: () => Get.to(() => ProductFilterPage(query), transition: Transition.downToUp),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Category Filter (Disabled for now)
            const Visibility(
              visible: false,
              child: SubcategoriesMenu(),
            ),

            const SizedBox(height: 15),

            // List of Product
            GlobalProductList(query: HelperFunctions.mainQueryHandler),
          ],
        ),
      ),
    );
  }
}
