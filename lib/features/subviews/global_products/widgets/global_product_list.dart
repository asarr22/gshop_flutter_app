import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/controllers/product_controller.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/features/shell/widgets/product_card_vertical.dart';
import 'package:gshopp_flutter/features/shell/widgets/rounded_image.dart';
import 'package:gshopp_flutter/utils/constants/images_values.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/shimmer/product_card_shimmer.dart';
import 'package:gshopp_flutter/utils/helpers/helper_fuctions.dart';

class GlobalProductList extends ConsumerStatefulWidget {
  const GlobalProductList({super.key});

  @override
  ConsumerState<GlobalProductList> createState() => _GlobalProductListState();
}

class _GlobalProductListState extends ConsumerState<GlobalProductList> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final productList = ref.watch(productControllerProvider)['regular'];
    final isLoading = ref.watch(globalLoadingProvider);

    // Widget
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
      child: productList != null && productList.isEmpty && !isLoading
          ? SizedBox(
              height: GHelper.screenHeight(context) - 200,
              width: GHelper.screenWidth(context) - 40,
              child: const Center(
                child: RoundedImage(
                  imgUrl: ImagesValue.empty,
                  height: 100,
                  width: 100,
                  borderRadius: 0,
                  backgroundColor: Colors.transparent,
                ),
              ),
            )
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
              },
            ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    GHelper.filterQueryHandler = null;
    super.dispose();
  }
}
