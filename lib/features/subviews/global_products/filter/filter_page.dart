import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/controllers/product_controller.dart';
import 'package:gshopp_flutter/features/subviews/global_products/filter/widgets/price_range_slider.dart';
import 'package:gshopp_flutter/features/subviews/global_products/state/global_product_order.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/global_value.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/widgets/rounded_container.dart';
import 'package:gshopp_flutter/utils/helpers/helper_fuctions.dart';
import 'package:iconsax/iconsax.dart';

final selectedDiscountProvider = StateProvider.autoDispose<int?>((ref) => null);
final selectedRatingProvider = StateProvider.autoDispose<int?>((ref) => null);

class ProductFilterPage extends ConsumerStatefulWidget {
  const ProductFilterPage(this.query, {super.key});
  final Query<Map<String, dynamic>>? query;

  @override
  ConsumerState<ProductFilterPage> createState() => _ProductFilterPageState();
}

class _ProductFilterPageState extends ConsumerState<ProductFilterPage> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    List<int> ratingRange = [1, 2, 3, 4, 5];
    List<int> discountRange = [10, 20, 30, 40, 50];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_24),
          onPressed: () => Get.back(),
        ),
        title: Text(
          TextValue.filter,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TextValue.priceRange,
                style: Theme.of(context).textTheme.displayMedium!.apply(fontWeightDelta: 5),
              ),
              const SizedBox(height: 10),
              const PriceRangeSlider(),
              const Divider(),
              const SizedBox(height: 10),
              Text(
                TextValue.discount,
                style: Theme.of(context).textTheme.displayMedium!.apply(fontWeightDelta: 5),
              ),
              const SizedBox(height: 10),
              buildDiscountList(discountRange, isDarkMode),
              const Divider(),
              const SizedBox(height: 10),
              Text(
                TextValue.clientRating,
                style: Theme.of(context).textTheme.displayMedium!.apply(fontWeightDelta: 5),
              ),
              const SizedBox(height: 10),
              buildRatingList(ratingRange, isDarkMode),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(isDarkMode),
    );
  }

  Widget buildDiscountList(List<int> discountRange, bool isDarkMode) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: ListView.builder(
        itemCount: discountRange.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final int discount = discountRange[index];
          final isSelected = ref.watch(selectedDiscountProvider) == discount;
          return GestureDetector(
            onTap: () => ref.read(selectedDiscountProvider.notifier).state = discount,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RoundedContainer(
                height: 60,
                width: 90,
                radius: 15,
                backgroundColor: isSelected
                    ? ColorPalette.primary
                    : (isDarkMode ? ColorPalette.darkGrey : ColorPalette.extraLightGray),
                child: Center(
                  child: Text(
                    "$discount%",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildRatingList(List<int> ratingRange, bool isDarkMode) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: ListView.builder(
        itemCount: ratingRange.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final int rating = ratingRange[index];
          final isSelected = ref.watch(selectedRatingProvider) == rating;
          return GestureDetector(
            onTap: () => ref.read(selectedRatingProvider.notifier).state = rating,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RoundedContainer(
                height: 60,
                width: 90,
                radius: 15,
                backgroundColor: isSelected
                    ? ColorPalette.primary
                    : (isDarkMode ? ColorPalette.darkGrey : ColorPalette.extraLightGray),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Iconsax.star1, color: Colors.amber),
                    Text(" $rating", style: Theme.of(context).textTheme.labelLarge),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildBottomNavigationBar(bool isDarkMode) {
    return SizedBox(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
        child: Column(
          children: [
            SizedBox(
              height: 60,
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Implement clear functionality
                  ref.read(filterPriceRangeProvider.notifier).resetRange();
                  ref.read(selectedRatingProvider.notifier).state = null;
                  ref.read(selectedDiscountProvider.notifier).state = null;
                },
                child: Text(
                  TextValue.clear,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: isDarkMode ? ColorPalette.primaryDark : ColorPalette.primary),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Dispose the previous query
                  ref.read(productControllerProvider.notifier).dispose();
                  // Fetch the filtered products
                  ref
                      .read(productControllerProvider.notifier)
                      .fetchProductWithCustomQuery(GlobalValue.defautQueryLimit, buildFilteredQuery(ref));

                  // Set the filter state to true
                  ref.read(productOrderFilterCheckerProvider.notifier).update(true);
                  // Close the filter page
                  Get.back();
                },
                child: const Text(TextValue.apply),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Query<Map<String, dynamic>> buildFilteredQuery(WidgetRef ref) {
    // Start with the base query
    Query<Map<String, dynamic>>? query = GHelper.mainQueryHandler;
    final priceRange = ref.read(filterPriceRangeProvider);
    final num? selectedDiscount = ref.read(selectedDiscountProvider.notifier).state;
    final num? selectedRating = ref.read(selectedRatingProvider.notifier).state;

    // Apply price range filter
    if (priceRange.start != 100 || priceRange.end != 5000000) {
      query = query
          .where('price', isGreaterThanOrEqualTo: priceRange.start)
          .where('price', isLessThanOrEqualTo: priceRange.end);
    }

    // Apply discount filter
    if (selectedDiscount != null) {
      query = query.where('discountValue', isEqualTo: selectedDiscount);
    }

    // Apply rating filter
    if (selectedRating != null) {
      query = query.where('intRating', isEqualTo: selectedRating);
    }
    GHelper.filterQueryHandler = query;
    return query;
  }
}
