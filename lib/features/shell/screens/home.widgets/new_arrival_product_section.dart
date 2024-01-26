import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/app.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/features/shell/widgets/product_card_vertical.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/shimmer/product_card_shimmer.dart';

class NewArriavalProductSection extends ConsumerWidget {
  const NewArriavalProductSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newArrivalProduct = ref.watch(productControllerProvider)['isNew'];
    final isLoading = newArrivalProduct == null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
      child: GridView.builder(
        itemCount: isLoading ? 4 : newArrivalProduct.length, // Adjust based on state
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
            return const ProductCardShimmer(); // Shimmer effect during loading
          } else {
            Product product = newArrivalProduct[index];
            return ProductCardVertical(
              product: product,
            );
          }
        },
      ),
    );
  }
}
