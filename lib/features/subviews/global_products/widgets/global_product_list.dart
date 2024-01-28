import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/app.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/features/shell/widgets/product_card_vertical.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/shimmer/product_card_shimmer.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';
import 'package:iconsax/iconsax.dart';

class GlobalProductList extends ConsumerStatefulWidget {
  const GlobalProductList({super.key, required this.query});
  final Query<Map<String, dynamic>>? query;

  @override
  ConsumerState<GlobalProductList> createState() => _GlobalProductListState();
}

class _GlobalProductListState extends ConsumerState<GlobalProductList> {
  @override
  void initState() {
    super.initState();
    ref.read(productControllerProvider.notifier).dispose();
    ref.read(productControllerProvider.notifier).fetchProductWithCustomQuery(20, widget.query!);
  }

  @override
  Widget build(BuildContext context) {
    final productList = ref.watch(productControllerProvider)['regular'];
    final isLoading = productList == null;

    // Widget
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
      child: productList != null && productList.isEmpty
          ? SizedBox(
              height: HelperFunctions.screenHeight(context) - 100,
              width: double.infinity,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Iconsax.document,
                    color: ColorPalette.lightGrey,
                    size: 200,
                  ),
                  Text(
                    TextValue.noItem,
                    style: Theme.of(context).textTheme.bodyLarge!.apply(color: ColorPalette.lightGrey),
                  ),
                ],
              )))
          : GridView.builder(
              itemCount: isLoading ? 4 : productList.length,
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
                  Product product = productList[index];
                  return ProductCardVertical(
                    product: product,
                  );
                }
              }),
    );
  }
}
