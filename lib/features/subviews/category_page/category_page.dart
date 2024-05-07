import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/models/category/category_model.dart';
import 'package:gshopp_flutter/features/subviews/category_page/subcategory_page.dart';
import 'package:gshopp_flutter/features/subviews/category_page/widget/horizontal_card.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/helpers/helper_fuctions.dart';
import 'package:iconsax/iconsax.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key, this.automaticallyImplyLeading = false});

  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = GHelper.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TextValue.categories,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        leading: automaticallyImplyLeading
            ? IconButton(
                icon: const Icon(Iconsax.arrow_left_24),
                onPressed: () => Get.back(),
              )
            : null,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: CategoryModel().count,
                itemBuilder: (_, index) {
                  final item = CategoryModel().getItemAt(index);
                  return HorizontalCategoryCard(
                      isDarkMode: isDarkMode,
                      item: item,
                      onTap: () => Get.to(
                            () => SubcategoryPage(
                              title: item.title,
                              mainIndex: index,
                            ),
                          ));
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
