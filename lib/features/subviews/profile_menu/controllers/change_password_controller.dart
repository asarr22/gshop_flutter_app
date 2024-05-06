import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/repositories/auth_services.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/helpers/network_manager.dart';
import 'package:gshopp_flutter/utils/popups/loading_screen_full.dart';
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';

class ChangePasswordFieldController extends StateNotifier<Map<String, TextEditingController>> {
  final Ref ref;
  ChangePasswordFieldController(this.ref)
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

  // Change Password
  Future<void> changeUserPassword(GlobalKey<FormState> nameKey) async {
    final authService = ref.watch(firebaseAuthServiceProvider);
    try {
      // Start Loading
      GLoadingScreen.openLoadingDialog(Get.context!);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        GLoadingScreen.stopLoading();
        return;
      }

      // Form Validation
      if (!nameKey.currentState!.validate()) {
        GLoadingScreen.stopLoading();
        return;
      }

      // Check if Password and confirm password are identical

      bool areIdentical = state['newPassword']!.text.trim() == state['newPasswordConfirm']!.text.trim();
      if (!areIdentical) {
        GLoadingScreen.stopLoading();
        SnackBarPop.showErrorPopup(TextValue.passAndConfirmPassMismatch);
        return;
      }

      // Change Password
      await authService.changePassword(state['oldPassword']!.text.trim(), state['newPassword']!.text.trim());
      GLoadingScreen.stopLoading();

      // Show Success Message
      SnackBarPop.showSucessPopup(TextValue.passwordChangeSuccessMessage, duration: 4);

      //Move to previous Screen
      Get.back();
    } catch (e) {
      SnackBarPop.showErrorPopup(e.toString(), duration: 4);
      GLoadingScreen.stopLoading();
    }
  }
}
