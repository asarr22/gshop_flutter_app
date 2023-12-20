import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:get/get.dart';

class SnackBarPop {
  SnackBarPop._();

  static void showInfoPopup(String message, {int duration = 2}) {
    final mycontext = Get.overlayContext!;
    AnimatedSnackBar.material(message,
            duration: Duration(seconds: duration),
            type: AnimatedSnackBarType.info,
            mobileSnackBarPosition: MobileSnackBarPosition.bottom)
        .show(mycontext);
  }

  static void showSucessPopup(String message, {int duration = 2}) {
    final mycontext = Get.overlayContext!;
    AnimatedSnackBar.material(message,
            duration: Duration(seconds: duration),
            type: AnimatedSnackBarType.success,
            mobileSnackBarPosition: MobileSnackBarPosition.bottom)
        .show(mycontext);
  }

  static void showErrorPopup(String message, {int duration = 2}) {
    final mycontext = Get.overlayContext!;
    AnimatedSnackBar.material(message,
            duration: Duration(seconds: duration),
            type: AnimatedSnackBarType.error,
            mobileSnackBarPosition: MobileSnackBarPosition.bottom)
        .show(mycontext);
  }
}
