import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/models/category/category_model.dart';
import 'package:gshopp_flutter/features/shell/widgets/vertical_image_text_widget.dart';
import 'package:gshopp_flutter/features/subviews/global_products/global_product_page.dart';
import 'package:gshopp_flutter/utils/animations/custom_fade_animation.dart';

class HomeCategoryList extends StatelessWidget {
  const HomeCategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: CategoryModel().count,
          itemBuilder: (_, index) {
            CategoryItem categoryItem = CategoryModel().getItemAt(index);
            return FadeTranslateAnimation(
              delay: 200,
              child: VerticalImageText(
                firstItemPadding:
                    index == 0, // This will add padding to the first item of the list in order to align the items
                title: categoryItem.title,
                image: categoryItem.image,
                onTap: () {
                  Get.to(() => GlobalProductPage(
                        pageTitle: categoryItem.title,
                        query: FirebaseFirestore.instance
                            .collection('Products')
                            .where('category', isEqualTo: CategoryModel().getItemAt(index).codeName),
                      ));
                },
              ),
            );
          }),
    );
  }
}
