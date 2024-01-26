import 'package:flutter/material.dart';
import 'package:gshopp_flutter/common/models/category/category_model.dart';
import 'package:gshopp_flutter/features/shell/widgets/vertical_image_text_widget.dart';

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
            return VerticalImageText(
              title: categoryItem.title,
              image: categoryItem.image,
            );
          }),
    );
  }
}
