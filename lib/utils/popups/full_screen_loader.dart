import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/helpers/helper_fuctions.dart';

class PFullScreenLoader {
  static void openLoadingDialog(context) {
    final spinkit = SpinKitFadingCube(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(color: index.isEven ? ColorPalette.primary : ColorPalette.secondary),
        );
      },
    );
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: GHelper.isDarkMode(context) ? ColorPalette.backgroundDark : ColorPalette.backgroundLight,
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: spinkit,
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
