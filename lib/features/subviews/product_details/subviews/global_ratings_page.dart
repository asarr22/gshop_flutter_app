import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/repositories/product_repository.dart';
import 'package:gshopp_flutter/features/subviews/product_details/subviews/add_review_page.dart';
import 'package:gshopp_flutter/features/subviews/product_details/subviews/model/ratings_model.dart';
import 'package:gshopp_flutter/features/subviews/product_details/subviews/state/product_rating_controller.dart';
import 'package:gshopp_flutter/features/subviews/product_details/subviews/widgets/global_ratings_header.dart';
import 'package:gshopp_flutter/features/subviews/product_details/widgets/rating_container.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:iconsax/iconsax.dart';

final globalRatingProvider = StateNotifierProvider<ProductRatingController, List<RatingModel>>((ref) {
  return ProductRatingController(ref.watch(productRepositoryProvider));
});

class GlobalRatingPage extends ConsumerWidget {
  const GlobalRatingPage(this.productId, this.globalRating, {super.key});
  final int productId;
  final num globalRating;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(globalRatingProvider.notifier).getProductReviews(productId);

    final reviews = ref.watch(globalRatingProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          TextValue.reviewsOnThisProduct,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_24),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SizesValue.padding),
          child: Column(children: [
            // Global Rating Header
            GlobalRatingHeader(
              reviewsNumber: reviews.length,
              onPressed: () => Get.to(() => AddReviewPage(productId), transition: Transition.downToUp),
            ),

            const SizedBox(height: 10),

            // Users Reviews List
            SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: reviews.length,
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
          ]),
        ),
      ),
    );
  }
}
