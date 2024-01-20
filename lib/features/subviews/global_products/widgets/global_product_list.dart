import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/app.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/features/shell/widgets/product_card_vertical.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';

class GlobalProductList extends ConsumerWidget {
  const GlobalProductList({super.key, required this.filter});

  final Map<String, dynamic> filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Send Query to ProductController
    ref.read(productControllerProvider.notifier).fetchProductWithSingleFitler(20, filter);

    // Receive Query from ProductController
    final productList = ref.watch(productControllerProvider)[filter.keys.first];

    // Widget
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
      child: productList!.isEmpty
          ? const Center(child: Text(TextValue.noItem))
          : GridView.builder(
              itemCount: productList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: 220,
              ),
              itemBuilder: (_, index) {
                Product product = productList[index];
                return ProductCardVertical(
                  product: product,
                );
              }),
    );
  }
}
