import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/firebase_services/auth_services.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/emailconfirmation/emil_success.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  void sendEmailVerification() async {
    try {
      await FirebaseAuthService.instance.sendEmailVerification();
      SnackBarPop.showInfoPopup(TextValue.confirmEmailSent);
    } catch (e) {
      SnackBarPop.showErrorPopup('Oh No : ${e.toString()}');
      if (kDebugMode) {
        print("ERROR SPOTTED:    ${e.toString()}");
      }
    }
  }

  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => const EmailSuccessScreen());
      }
    });
  }

  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => const EmailSuccessScreen());
    }
  }
}
