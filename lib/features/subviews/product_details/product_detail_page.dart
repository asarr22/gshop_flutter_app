import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/app.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/common/widgets/texts/section_header.dart';
import 'package:gshopp_flutter/features/subviews/product_details/product_detail_image.dart';
import 'package:gshopp_flutter/features/subviews/product_details/state/product_details_controller.dart';
import 'package:gshopp_flutter/features/subviews/product_details/state/variant_controller.dart';
import 'package:gshopp_flutter/features/subviews/product_details/subviews/global_ratings_page.dart';
import 'package:gshopp_flutter/features/subviews/product_details/widgets/pd_bottom_bar.dart';
import 'package:gshopp_flutter/features/subviews/product_details/widgets/quantity_selection_widget.dart';
import 'package:gshopp_flutter/features/subviews/product_details/widgets/rating_container.dart';
import 'package:gshopp_flutter/features/subviews/product_details/widgets/variants_selection.dart';
import 'package:gshopp_flutter/utils/animations/custom_fade_animation.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/custom_widget/expendable_text.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';
import 'package:iconsax/iconsax.dart';

final quantityProvider = StateNotifierProvider.autoDispose<SelectedQuantity, int>((ref) => SelectedQuantity());
final selectedVariantProvider =
    StateNotifierProvider.autoDispose<SelectedVariant, Variant?>((ref) => SelectedVariant());
final selectedSizeProvider = StateNotifierProvider.autoDispose<SelectedSize, Size?>((ref) => SelectedSize());
final productDetailsControllerProvider = StateNotifierProvider<ProductDetailsController, Product>(
    (ref) => ProductDetailsController(ref.read(productRepositoryProvider)));

class ProductDetailPage extends ConsumerStatefulWidget {
  const ProductDetailPage(this.productID, {super.key});
  final String productID;

  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
    ref.read(productDetailsControllerProvider.notifier).setProduct(widget.productID);
  }

  @override
  Widget build(BuildContext context) {
    final selectedQuantityValue = ref.watch(quantityProvider);
    final product = ref.watch(productDetailsControllerProvider);
    ref.watch(globalRatingProvider.notifier).getProductReviews(product.id);

    final reviews = ref.watch(globalRatingProvider);

    final bool isDarkMode = HelperFunctions.isDarkMode(context);
    String stockStateLogger() {
      if (product.totalStock == 0) {
        return TextValue.outOfStock;
      } else if (product.totalStock < 5) {
        return TextValue.lowStock;
      } else {
        return TextValue.inStock;
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductDetailImage(product: product),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
              child: Column(
                children: [
                  //Brand
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      product.brand,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,
                    ),
                  ),

                  // Product title
                  FadeTranslateAnimation(
                    delay: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.title,
                          style: Theme.of(context).textTheme.displayLarge,
                          maxLines: 1,
                        ),

                        // Discount Box
                        Container(
                          height: 30,
                          width: 50,
                          decoration: BoxDecoration(
                            color: ColorPalette.secondary.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: Text(
                              '${product.discountValue}%',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .apply(color: Colors.black, fontWeightDelta: 3),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Rating Box
                  FadeTranslateAnimation(
                    delay: 500,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: reviews.isEmpty && product.rating == 0 ? null : 50,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: reviews.isEmpty && product.rating == 0
                              ? ColorPalette.lightGrey
                              : ColorPalette.secondary3.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 20,
                                  color: Colors.amber,
                                ),
                                Text(
                                  reviews.isEmpty && product.rating == 0
                                      ? TextValue.noReviewsYet
                                      : product.rating.toStringAsFixed(1),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Stock Count
                  const SizedBox(height: 10),
                  FadeTranslateAnimation(
                    delay: 600,
                    child: Row(
                      children: [
                        Icon(Iconsax.info_circle, size: 15, color: product.totalStock == 0 ? Colors.red : Colors.green),
                        const SizedBox(width: 5),
                        Text(stockStateLogger(),
                            style: Theme.of(context).textTheme.bodyMedium!.apply(
                                color: product.totalStock == 0
                                    ? Colors.red
                                    : product.totalStock < 5
                                        ? Colors.orange
                                        : Colors.green)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  //Description
                  FadeTranslateAnimation(
                    delay: 650,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        TextValue.description,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  FadeTranslateAnimation(delay: 700, child: ExpandableText(text: product.description)),
                  const SizedBox(height: 10),
                  FadeTranslateAnimation(
                    delay: 750,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        TextValue.variant,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Variant Selection
                  FadeTranslateAnimation(
                    delay: 800,
                    child: VariantSelection(
                      ref: ref,
                      variants: product.variants,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Quantity Selection

                  FadeTranslateAnimation(
                      delay: 800,
                      child: QuantitySelectionWidget(ref: ref, selectedQuantityValue: selectedQuantityValue)),

                  // Comment Section
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      TextValue.reviewsOnThisProduct,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SectionHeader(
                    title:
                        '${product.rating.toStringAsFixed(1)} ${product.rating > 1 ? TextValue.ratings : TextValue.rating}',
                    padding: EdgeInsets.zero,
                    onTap: () => Get.to(() => GlobalRatingPage(product.id, product.rating),
                        transition: Transition.rightToLeftWithFade, duration: const Duration(milliseconds: 500)),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${reviews.length} ${reviews.length > 1 ? TextValue.reviews : TextValue.review}',
                      style: Theme.of(context).textTheme.labelMedium!.apply(fontWeightDelta: 15),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    child: reviews.isEmpty
                        ? const Center(child: Text(TextValue.noReviewsYet))
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: reviews.length >= 2 ? 2 : reviews.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              final review = reviews[index];
                              return RatingContainer(
                                userName: review.name,
                                date: review.date,
                                comment: review.comment,
                                ratingValue: review.rating.toDouble(),
                                imgUrl: review.userImage ?? "",
                              );
                            }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ProductDetailBottomBar(isDarkMode: isDarkMode),
    );
  }
}
