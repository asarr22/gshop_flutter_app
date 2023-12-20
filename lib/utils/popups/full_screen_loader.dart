import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';

class PFullScreenLoader {
  static void openLoadingDialog(context) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: HelperFunctions.isDarkMode(context)
              ? ColorPalette.backgroundDark
              : ColorPalette.backgroundLight,
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Lottie.asset(
                'assets/images/animations/loading.json',
                animate: true,
                frameRate: FrameRate(60),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
