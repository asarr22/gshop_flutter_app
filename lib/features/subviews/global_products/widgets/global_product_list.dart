import 'package:flutter/material.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/features/shell/widgets/product_card_vertical.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';

class GlobalProductList extends StatelessWidget {
  const GlobalProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
      child: GridView.builder(
          itemCount: ProductModel().count,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: 220,
          ),
          itemBuilder: (_, index) {
            Product product = ProductModel().getByIndex(index);
            return ProductCardVertical(
              product: product,
            );
          }),
    );
  }
}
