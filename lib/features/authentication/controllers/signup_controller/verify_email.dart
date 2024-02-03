import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/firebase_services/auth_services.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/emailconfirmation/emil_success.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';

final verifyEmailControllerProvider = StateNotifierProvider<VerifyEmailController, bool>((ref) {
  return VerifyEmailController(ref);
});

class VerifyEmailController extends StateNotifier<bool> {
  VerifyEmailController(this.ref) : super(false) {
    sendEmailVerification();
    setTimerForAutoRedirect();
  }
  final Ref ref;

  void sendEmailVerification() async {
    try {
      final authServices = ref.read(firebaseAuthServiceProvider);
      await authServices.sendEmailVerification();
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
