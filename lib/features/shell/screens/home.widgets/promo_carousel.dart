import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/features/shell/controllers/carousel_indicator_controler.dart';
import 'package:gshopp_flutter/features/shell/widgets/circular_container_of_carousel.dart';
import 'package:gshopp_flutter/features/shell/widgets/rounded_image.dart';

final carouselIndicatorProvider =
    StateNotifierProvider<CarousleIndicatorControler, int>((ref) => CarousleIndicatorControler());

class PromoCarousel extends ConsumerWidget {
  const PromoCarousel({
    required this.banners,
    super.key,
  });

  final List<String> banners;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indicatorValue = ref.watch(carouselIndicatorProvider);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
              viewportFraction: 1,
              aspectRatio: 2,
              onPageChanged: (index, _) => ref.read(carouselIndicatorProvider.notifier).updateIndicator(index)),
          items: banners
              .map((url) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RoundedImage(imgUrl: url),
                  ))
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < banners.length; i++)
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
