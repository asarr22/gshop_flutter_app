import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart'; // Ensure you have the get package added to your pubspec.yaml
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/features/shell/widgets/product_card_vertical.dart';
import 'package:gshopp_flutter/features/shell/widgets/search_container.dart';
import 'package:gshopp_flutter/features/subviews/global_products/global_product_page.dart';
import 'package:gshopp_flutter/features/subviews/search_page/state/search_product_controller.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/shimmer/product_card_shimmer.dart';
import 'package:gshopp_flutter/utils/styles/shadow.dart';
import 'package:iconsax/iconsax.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

String keyword = '';

class _SearchPageState extends ConsumerState<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isLoading = ref.watch(searchControllerProvider)['isLoading'];
    final searchProduct = ref.watch(searchControllerProvider)['search'];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_24),
          onPressed: () => Get.back(),
        ),
        title: Hero(
          tag: 'search',
          child: Material(
            type: MaterialType.transparency,
            child: SearchContainer(
              enableTextField: true,
              onChanged: (value) {
                /// When invoking the Product Search function, the default limit is set to 5, with the user having the option to expand the result set
                /// by clicking the "See All" button. Additionally, users can apply additional filters to refine the search results.
                /// This suggestion is intended for enhancing the Quick Search feature.
                if (value.isNotEmpty) ref.read(searchControllerProvider.notifier).searchProducts(value, 5);
                keyword = value;
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              GridView.builder(
                itemCount: isLoading
                    ? 6
                    : searchProduct.isEmpty
                        ? searchProduct.length
                        : searchProduct.length + 1,
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
                    if (index == searchProduct.length && searchProduct.isNotEmpty) {
                      return seeAllButton(isDarkMode, context, keyword);
                    } else {
                      Product product = searchProduct[index];
                      return ProductCardVertical(
                        product: product,
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell seeAllButton(bool isDarkMode, BuildContext context, String keyword) {
    return InkWell(
      borderRadius: BorderRadius.circular(SizesValue.productImageRadius),
      hoverColor: ColorPalette.extraLightGray,
      onTap: () {
        // Spit the keyword into a list of tags
        List<String> tags = keyword.toLowerCase().split(' ');
        Get.to(() => GlobalProductPage(
              pageTitle: '${TextValue.searchResultFor} "$keyword"',
              initialQuery: FirebaseFirestore.instance.collection('Products').where(Filter.or(
                  Filter('tags', arrayContainsAny: tags),
                  Filter("brand", isEqualTo: keyword.substring(0, 1).toUpperCase() + keyword.substring(1)))),
            ));
      },
      child: Ink(
        height: 220,
        width: 160,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: isDarkMode ? ColorPalette.backgroundDark : ColorPalette.backgroundLight,
          boxShadow: [ShadowStyle.verticolProductShadow],
          borderRadius: BorderRadius.circular(SizesValue.productImageRadius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: Material(
                elevation: 10,
                shadowColor: ColorPalette.primary,
                borderRadius: BorderRadius.circular(100),
                color: ColorPalette.primary,
                child: const Icon(Iconsax.arrow_right_1, color: ColorPalette.white),
              ),
            ),
            const SizedBox(height: 10),
            Text(TextValue.seeAll, style: Theme.of(context).textTheme.labelLarge!.apply(color: ColorPalette.primary))
          ],
        ),
      ),
    );
  }
}
