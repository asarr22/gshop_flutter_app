import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:gshopp_flutter/common/firebase_services/auth_services.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/forgot_password/reset_password.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/helpers/network_manager.dart';
import 'package:gshopp_flutter/utils/popups/full_screen_loader.dart';
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';

class ForgotPasswordController extends StateNotifier<TextEditingController> {
  ForgotPasswordController() : super(TextEditingController());

  void sendPasswordResetLink(
      BuildContext context, GlobalKey<FormState> validationKey) async {
    try {
      //Start Loading
      PFullScreenLoader.openLoadingDialog(context);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        PFullScreenLoader.stopLoading();
        return;
      }

      //Form Validation
      if (!validationKey.currentState!.validate()) {
        PFullScreenLoader.stopLoading();
        return;
      }

      //Send Password Reset Request with Email
      await FirebaseAuthService.instance
          .sendPasswordResetEmail(state.text.trim());

      PFullScreenLoader.stopLoading();

      //Success Screen
      SnackBarPop.showInfoPopup(TextValue.resetEmailSent, duration: 4);
      Get.to(() => const ResetPasswordScreen());
    } catch (e) {
      PFullScreenLoader.stopLoading();
      SnackBarPop.showErrorPopup(e.toString(), duration: 4);
    }
  }

  void resendPasswordResetLink(BuildContext context) async {
    try {
      // Start Loading
      PFullScreenLoader.openLoadingDialog(context);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        PFullScreenLoader.stopLoading();
        return;
      }
      // Send Password Reset Request with Email
      await FirebaseAuthService.instance
          .sendPasswordResetEmail(state.text.trim());

      PFullScreenLoader.stopLoading();

      // Success Screen
      SnackBarPop.showInfoPopup(TextValue.resetEmailSent, duration: 4);
    } catch (e) {
      PFullScreenLoader.stopLoading();
      SnackBarPop.showErrorPopup(e.toString(), duration: 4);
    }
  }
}
