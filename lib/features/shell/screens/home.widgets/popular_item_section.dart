import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/app.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/features/shell/widgets/product_card_vertical.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/shimmer/product_card_shimmer.dart';

class PopularProductSection extends ConsumerWidget {
  const PopularProductSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularProduct = ref.watch(productControllerProvider)['isPopular'];
    final isLoading = popularProduct == null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
      child: GridView.builder(
        itemCount: isLoading ? 4 : popularProduct.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          mainAxisExtent: 220,
        ),
        itemBuilder: (_, index) {
          if (isLoading) {
            return const ProductCardShimmer();
          } else {
            Product product = popularProduct[index];
            return ProductCardVertical(
              product: product,
            );
          }
        },
      ),
    );
  }
}
