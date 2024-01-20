import 'package:flutter/material.dart';
import 'package:gshopp_flutter/features/shell/models/category_view_model.dart';
import 'package:gshopp_flutter/features/subviews/category_page/widget/horizontal_card.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          TextValue.categories,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: CategoryModel().count,
              itemBuilder: (_, index) {
                final item = CategoryModel().getItemAt(index);
                return HorizontalCategoryCard(isDarkMode: isDarkMode, item: item);
              }),
        ),
      ),
    ));
  }
}
