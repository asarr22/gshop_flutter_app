import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/models/category/category_model.dart';
import 'package:gshopp_flutter/features/shell/screens/profile.widgets/button_card.dart';
import 'package:gshopp_flutter/features/subviews/global_products/global_product_page.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:iconsax/iconsax.dart';

class SubcategoryPage extends StatelessWidget {
  const SubcategoryPage({super.key, required this.title, required this.mainIndex});
  final String title;
  final int mainIndex;

  @override
  Widget build(BuildContext context) {
    // final bool isDarkMode = GHelper.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_24),
          onPressed: () => Get.back(),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: CategoryModel().getItemAt(mainIndex).subCategories.length,
                itemBuilder: (_, index) {
                  final item = CategoryModel().getItemAt(mainIndex).subCategories[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, SizesValue.padding / 2, 0, SizesValue.padding / 2),
                    child: ButtonCardTile(
                      implyDescription: false,
                      title: item.values.first.toUpperCase(),
                      onTap: () {
                        if (item.keys.first == 'all') {
                          Get.to(() => GlobalProductPage(
                                pageTitle: title,
                                initialQuery: FirebaseFirestore.instance
                                    .collection('Products')
                                    .where('category', isEqualTo: CategoryModel().getItemAt(mainIndex).codeName),
                              ));
                        } else {
                          Get.to(() => GlobalProductPage(
                                pageTitle: title,
                                initialQuery: FirebaseFirestore.instance
                                    .collection('Products')
                                    .where('category', isEqualTo: CategoryModel().getItemAt(mainIndex).codeName)
                                    .where('subCategory', isEqualTo: item.keys.first.toLowerCase()),
                              ));
                        }
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 110),
            ],
          ),
        ),
      ),
    );
  }
}
