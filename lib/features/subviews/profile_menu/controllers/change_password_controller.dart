import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/firebase_services/auth_services.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/helpers/network_manager.dart';
import 'package:gshopp_flutter/utils/popups/full_screen_loader.dart';
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';

class ChangePasswordFieldController extends StateNotifier<Map<String, TextEditingController>> {
  ChangePasswordFieldController()
      : super({
          'oldPassword': TextEditingController(),
          'newPassword': TextEditingController(),
          'newPasswordConfirm': TextEditingController(),
        });

  @override
  void dispose() {
    state.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  Future<void> changeUserPassword(GlobalKey<FormState> nameKey) async {
    try {
      // Start Loading
      PFullScreenLoader.openLoadingDialog(Get.context!);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        PFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!nameKey.currentState!.validate()) {
        PFullScreenLoader.stopLoading();
        return;
      }

      // Check if Password and confirm password are identical

      bool areIdentical = state['newPassword']!.text.trim() == state['newPasswordConfirm']!.text.trim();
      if (!areIdentical) {
        PFullScreenLoader.stopLoading();
        SnackBarPop.showErrorPopup(TextValue.passAndConfirmPassMismatch);
        return;
      }

      // Change Password
      Get.put(FirebaseAuthService());
      await FirebaseAuthService.instance.changePassword(state['oldPassword']!.text.trim(), state['newPassword']!.text.trim());
      PFullScreenLoader.stopLoading();

      // Show Success Message
      SnackBarPop.showSucessPopup(TextValue.passwordChangeSuccessMessage, duration: 4);

      //Move to previous Screen
      Get.back();
    } catch (e) {
      SnackBarPop.showErrorPopup(e.toString(), duration: 4);
      PFullScreenLoader.stopLoading();
    }
  }
}
