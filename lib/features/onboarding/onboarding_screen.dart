import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/features/onboarding/controller/onboarding_controller.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final pageIndexProvider = StateNotifierProvider<OnBoardingController, int>((ref) => OnBoardingController());

class OnBoardingPage extends ConsumerWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final pageIndex = ref.watch(pageIndexProvider);
    final pageController = ref.watch(pageIndexProvider.notifier).pageController;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              onPageChanged: (value) => ref.read(pageIndexProvider.notifier).updatePageIndicator(value),
              controller: pageController,
              children: const [
                OnBoardHelper(
                  boardTitle: TextValue.bTitle1,
                  boardImage: 'assets/images/onboarding/ob1.png',
                  boardDescription: TextValue.bDescription1,
                ),
                OnBoardHelper(
                  boardTitle: TextValue.bTitle2,
                  boardImage: 'assets/images/onboarding/ob2.png',
                  boardDescription: TextValue.bDescription2,
                ),
                OnBoardHelper(
                  boardTitle: TextValue.bTitle3,
                  boardImage: 'assets/images/onboarding/ob3.png',
                  boardDescription: TextValue.bDescription3,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(SizesValue.padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '${pageIndex + 1}',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: isDarkMode ? Colors.white : Colors.black),
                      ),
                      const Text(
                        '/3',
                        style: TextStyle(
                            fontFamily: 'Roboto', fontWeight: FontWeight.w700, fontSize: 20, color: Colors.grey),
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        ref.watch(pageIndexProvider.notifier).skipPage(context);
                      },
                      child: Text(
                        'Passer',
                        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                      )),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 50.0,
          child: Align(
              alignment: Alignment.center,
              child: SmoothPageIndicator(
                controller: pageController,
                onDotClicked: (index) => ref.read(pageIndexProvider.notifier).dotNavigationClick(index),
                count: 3,
                effect: ExpandingDotsEffect(
                    activeDotColor: isDarkMode ? ColorPalette.onPrimaryDark : ColorPalette.onPrimaryLight,
                    dotHeight: 6),
              )),
        ),
      ),
    );
  }
}

class OnBoardHelper extends ConsumerWidget {
  final String boardTitle;
  final String boardImage;
  final String boardDescription;

  const OnBoardHelper({
    super.key,
    required this.boardImage,
    required this.boardTitle,
    required this.boardDescription,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Image.asset(boardImage),
          ),
        ),
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
              child: Column(
                children: [
                  Text(
                    boardTitle,
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    boardDescription,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
                child: SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(pageIndexProvider.notifier).nextPage(context);
                    },
                    child: const Text(
                      'ALLEZ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
