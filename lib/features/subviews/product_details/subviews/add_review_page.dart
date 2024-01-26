import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/app.dart';
import 'package:gshopp_flutter/utils/styles/texts/text_field_borderless.dart';
import 'package:gshopp_flutter/features/subviews/product_details/subviews/global_ratings_page.dart';
import 'package:gshopp_flutter/features/subviews/product_details/subviews/model/ratings_model.dart';
import 'package:gshopp_flutter/features/subviews/product_details/subviews/state/add_new_review_controller.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/styles/star_slider_value_indicator_shape.dart';
import 'package:gshopp_flutter/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class AddReviewPage extends ConsumerWidget {
  const AddReviewPage(this.productID, {super.key});
  final String productID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textController = ref.watch(addNewReviewTextControllerProvider);
    final rateValue = ref.watch(addNewReviewControllerSliderProvider);
    final user = ref.watch(userControllerProvider);
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
          padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
          child: Column(
            children: [
              Form(
                  child: Column(
                children: [
                  PTextField(
                    maxLines: 5,
                    title: TextValue.howWasYourExperience,
                    textEditingController: textController,
                    validator: (value) => PValidator.validateEmptyText(TextValue.review, value),
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      TextValue.star,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  Row(
                    children: [
                      Text('0.0', style: Theme.of(context).textTheme.labelSmall!.apply(fontSizeDelta: 3)),
                      Expanded(
                        child: SizedBox(
                          child: SliderTheme(
                            data: SliderThemeData(
                              trackHeight: 10,
                              thumbColor: ColorPalette.primary,
                              valueIndicatorColor: ColorPalette.primary,
                              activeTrackColor: isDarkMode ? ColorPalette.darkGrey : ColorPalette.extraLightGray,
                              inactiveTrackColor: isDarkMode ? ColorPalette.darkGrey : ColorPalette.extraLightGray,
                              activeTickMarkColor: isDarkMode ? ColorPalette.darkGrey : ColorPalette.extraLightGray,
                              inactiveTickMarkColor: isDarkMode ? ColorPalette.darkGrey : ColorPalette.extraLightGray,
                              valueIndicatorShape: StarValueIndicatorShape(),
                              valueIndicatorTextStyle:
                                  Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorPalette.white),
                            ),
                            child: Slider(
                              value: rateValue,
                              max: 5.0,
                              min: 1.0,
                              label: rateValue.toString(),
                              divisions: 8,
                              onChanged: (value) {
                                ref.read(addNewReviewControllerSliderProvider.notifier).setSliderValue(value);
                              },
                            ),
                          ),
                        ),
                      ),
                      Text('5.0', style: Theme.of(context).textTheme.labelSmall!.apply(fontSizeDelta: 3)),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        DateFormat formatter = DateFormat('dd/MM/yyyy');
                        String date = formatter.format(DateTime.now());
                        final ratingModel = RatingModel(
                          comment: textController.text.trim(),
                          rating: rateValue,
                          userID: user.id,
                          name: user.fullName,
                          date: date,
                        );
                        ref.read(globalRatingProvider.notifier).addProductReview(productID, ratingModel);
                      },
                      child: const Text(TextValue.submit),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
