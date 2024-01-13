import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/features/subviews/product_details/product_detail_page.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:iconsax/iconsax.dart';

class GlobalRatingHeader extends ConsumerWidget {
  const GlobalRatingHeader({super.key, required this.reviewsNumber, this.onPressed});

  final int reviewsNumber;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalRating = ref.watch(productDetailsControllerProvider).rating;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 80,
              child: RichText(
                text: TextSpan(
                  text: reviewsNumber.toString(),
                  style: Theme.of(context).textTheme.labelLarge!.apply(fontWeightDelta: 2, fontSizeDelta: 1),
                  children: <TextSpan>[
                    TextSpan(
                      text: " ${reviewsNumber > 1 ? TextValue.reviews : TextValue.review} ",
                      style: Theme.of(context).textTheme.labelLarge!.apply(fontWeightDelta: 2, fontSizeDelta: 1),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  globalRating.toStringAsFixed(1),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(width: 2),
                RatingBar.builder(
                  ignoreGestures: true,
                  itemSize: 13,
                  initialRating: globalRating.toDouble(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ],
            )
          ],
        ),
        ElevatedButton(
          onPressed: onPressed,
          style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
              elevation: const MaterialStatePropertyAll(0),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ))),
          child: Row(
            children: [
              const Icon(
                Iconsax.message_add,
                color: Colors.white,
                size: 15,
              ),
              const SizedBox(width: 5),
              Text(
                TextValue.add,
                style: Theme.of(context).textTheme.labelMedium!.apply(color: Colors.white),
              ),
            ],
          ),
        )
      ],
    );
  }
}
