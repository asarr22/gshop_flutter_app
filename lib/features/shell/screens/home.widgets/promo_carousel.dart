import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/controllers/promo_event_controller.dart';
import 'package:gshopp_flutter/features/shell/controllers/carousel_indicator_controler.dart';
import 'package:gshopp_flutter/features/shell/widgets/circular_container_of_carousel.dart';
import 'package:gshopp_flutter/features/shell/widgets/rounded_image.dart';
import 'package:gshopp_flutter/features/subviews/global_products/global_product_page.dart';
import 'package:gshopp_flutter/utils/animations/beat_animation.dart';

final carouselIndicatorProvider =
    StateNotifierProvider<CarousleIndicatorControler, int>((ref) => CarousleIndicatorControler());

class PromoCarousel extends ConsumerWidget {
  const PromoCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indicatorValue = ref.watch(carouselIndicatorProvider);
    final promoEventList = ref.watch(promoEventControllerProvider);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
              viewportFraction: 1,
              aspectRatio: 2,
              onPageChanged: (index, _) => ref.read(carouselIndicatorProvider.notifier).updateIndicator(index)),
          items: promoEventList
              .map<Widget>((event) => BeatAnimationWidget(
                    onTap: () {
                      Get.to(
                        GlobalProductPage(
                          pageTitle: event.title,
                          isFlashSale: event.id == '0',
                          initialQuery:
                              FirebaseFirestore.instance.collection('Products').where('promoCode', isEqualTo: event.id),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RoundedImage(
                        borderRadius: 10,
                        imgUrl: event.imageUrl,
                        isNetworkImage: true,
                      ),
                    ),
                  ))
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < promoEventList.length; i++)
              CircularContainer(
                  width: 5,
                  height: 5,
                  margin: const EdgeInsets.fromLTRB(0, 0, 5, 10),
                  backgroundColor: indicatorValue == i ? Colors.white : Colors.grey.withOpacity(0.7)),
          ],
        ),
      ],
    );
  }
}
