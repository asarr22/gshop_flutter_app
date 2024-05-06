import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/app.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/helpers/network_manager.dart';
import 'package:gshopp_flutter/utils/popups/loading_screen_full.dart';
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';

class NameFieldController extends StateNotifier<Map<String, TextEditingController>> {
  NameFieldController()
      : super({
          'firstName': TextEditingController(),
          'lastName': TextEditingController(),
        });

  @override
  void dispose() {
    state.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  void setName(String firstName, String lastName) {
    state['firstName']!.text = firstName;
    state['lastName']!.text = lastName;
  }

  Future<void> updateUserFullName(GlobalKey<FormState> nameKey, WidgetRef ref) async {
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

      // Update user's first & last name in the Firebase Firestore
      final userController = ref.read(userControllerProvider.notifier);
      final userRepository = ref.read(userRepositoryProvider);

      Map<String, dynamic> name = {
        'FirstName': state['firstName']!.text.trim(),
        'LastName': state['lastName']!.text.trim()
      };
      await userRepository.updateSingleField(name);

      // Update the Provider User Value
      userController.updateUserInfo(
        firstName: state['firstName']!.text.trim(),
        lastName: state['lastName']!.text.trim(),
      );
      // Remove Loader
      GLoadingScreen.stopLoading();

      // Show Success Message
      SnackBarPop.showSucessPopup(TextValue.operationSuccess, duration: 4);

      //Move to previous Screen
      Get.back();
    } catch (e) {
      SnackBarPop.showErrorPopup(e.toString(), duration: 4);
      GLoadingScreen.stopLoading();
    }
  }
}
