import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/app.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/common/widgets/texts/section_header.dart';
import 'package:gshopp_flutter/features/subviews/product_details/product_detail_image.dart';
import 'package:gshopp_flutter/features/subviews/product_details/state/product_details_controller.dart';
import 'package:gshopp_flutter/features/subviews/product_details/state/variant_controller.dart';
import 'package:gshopp_flutter/features/subviews/product_details/widgets/pd_bottom_bar.dart';
import 'package:gshopp_flutter/features/subviews/product_details/widgets/rating_container.dart';
import 'package:gshopp_flutter/features/subviews/product_details/widgets/variants_selection.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/custom_widget/expendable_text.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';

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
    final bool isDarkMode = HelperFunctions.isDarkMode(context);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.title,
                        style: Theme.of(context).textTheme.displayLarge,
                        maxLines: 1,
                      ),
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
                            style:
                                Theme.of(context).textTheme.labelMedium!.apply(color: Colors.black, fontWeightDelta: 3),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Rating Box
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 50,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: ColorPalette.secondary3.withOpacity(0.8),
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
                                '4.5',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  //Description
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      TextValue.description,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 5),
                  ExpandableText(text: product.description),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      TextValue.variant,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Variant Selection
                  VariantSelection(
                    ref: ref,
                    variants: product.variants,
                  ),
                  const SizedBox(height: 20),

                  // Quantity Selection

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorPalette.secondary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          TextValue.quantitie,
                          style: Theme.of(context).textTheme.displayMedium!.apply(color: Colors.black),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 55,
                              width: 55,
                              child: ElevatedButton(
                                onPressed: () {
                                  ref.read(quantityProvider.notifier).decrement();
                                },
                                child: Text('-',
                                    style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.white)),
                              ),
                            ),
                            SizedBox(
                              height: 55,
                              width: 50,
                              child: Center(
                                  child: Text(selectedQuantityValue.toString(),
                                      style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.black))),
                            ),
                            SizedBox(
                              height: 55,
                              width: 55,
                              child: ElevatedButton(
                                onPressed: () {
                                  ref.read(quantityProvider.notifier).increment();
                                },
                                child: Text('+',
                                    style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

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
                  const SectionHeader(
                    title: '4.5 Notes',
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '127 ${TextValue.reviews}',
                      style: Theme.of(context).textTheme.labelMedium!.apply(fontWeightDelta: 15),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          return const RatingContainer(
                            userName: "User Name",
                            date: "22/10/2023",
                            comment:
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                            ratingValue: 4.5,
                          );
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ProductDetailBottomBar(
          selectedQuantityValue: selectedQuantityValue, product: product, isDarkMode: isDarkMode),
    );
  }
}
