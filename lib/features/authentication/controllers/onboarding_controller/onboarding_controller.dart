import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class OnBoardingController extends StateNotifier<int> {
  OnBoardingController() : super(0);

  PageController pageController = PageController();

  void updatePageIndicator(index) {
    state = index;
  }

  void dotNavigationClick(index) {
    state = index;
    pageController.jumpToPage(index);
  }

  void nextPage(BuildContext context) {
    if (state == 2) {
      Get.toNamed('/login');
    } else {
      state++;
      pageController.jumpToPage(state);
    }
  }

  void skipPage(BuildContext context) {
    state = 2;
    Get.toNamed('/login');
  }
}
