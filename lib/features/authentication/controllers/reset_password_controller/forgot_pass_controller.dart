import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:gshopp_flutter/common/repositories/auth_services.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/forgot_password/reset_password.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/helpers/network_manager.dart';
import 'package:gshopp_flutter/utils/popups/loading_screen_full.dart';
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';

class ForgotPasswordController extends StateNotifier<TextEditingController> {
  final Ref ref;
  ForgotPasswordController(this.ref) : super(TextEditingController());

  void sendPasswordResetLink(BuildContext context, GlobalKey<FormState> validationKey) async {
    final authService = ref.watch(firebaseAuthServiceProvider);

    try {
      //Start Loading
      GLoadingScreen.openLoadingDialog(context);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        GLoadingScreen.stopLoading();
        return;
      }

      //Form Validation
      if (!validationKey.currentState!.validate()) {
        GLoadingScreen.stopLoading();
        return;
      }

      //Send Password Reset Request with Email
      await authService.sendPasswordResetEmail(state.text.trim());

      GLoadingScreen.stopLoading();

      //Success Screen
      SnackBarPop.showInfoPopup(TextValue.resetEmailSent, duration: 4);
      Get.to(() => const ResetPasswordScreen());
    } catch (e) {
      GLoadingScreen.stopLoading();
      SnackBarPop.showErrorPopup(e.toString(), duration: 4);
    }
  }

  void resendPasswordResetLink(BuildContext context) async {
    final authService = ref.watch(firebaseAuthServiceProvider);

    try {
      // Start Loading
      GLoadingScreen.openLoadingDialog(context);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        GLoadingScreen.stopLoading();
        return;
      }
      // Send Password Reset Request with Email
      await authService.sendPasswordResetEmail(state.text.trim());

      GLoadingScreen.stopLoading();

      // Success Screen
      SnackBarPop.showInfoPopup(TextValue.resetEmailSent, duration: 4);
    } catch (e) {
      GLoadingScreen.stopLoading();
      SnackBarPop.showErrorPopup(e.toString(), duration: 4);
    }
  }
}
