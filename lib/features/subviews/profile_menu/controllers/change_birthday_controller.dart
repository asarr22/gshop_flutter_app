// Not Trans !!! Just Gender Picker
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/app.dart';
import 'package:gshopp_flutter/features/shell/screens/home.widgets/user_greetings_banner.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/helpers/network_manager.dart';
import 'package:gshopp_flutter/utils/popups/full_screen_loader.dart';
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';

class ChangeBirthdayController extends StateNotifier<String> {
  ChangeBirthdayController() : super(TextValue.undefined);

  void setValue(String date) {
    state = date;
  }

  Future<void> updateDate(WidgetRef ref) async {
    try {
      // Start Loading
      PFullScreenLoader.openLoadingDialog(Get.context!);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        PFullScreenLoader.stopLoading();
        return;
      }

      // Update user's phone number in the Firebase Firestore
      final userController = ref.read(userControllerProvider.notifier);
      final userRepository = ref.read(userRepositoryProvider);

      Map<String, dynamic> birthdate = {'Birthday': state.trim()};
      await userRepository.updateSingleField(birthdate);

      // Update the Provider User Value
      userController.updateUserInfo(birthday: state.trim());
      // Remove Loader
      PFullScreenLoader.stopLoading();

      // Show Success Message
      SnackBarPop.showSucessPopup(TextValue.operationSuccess, duration: 4);

      //Move to previous Screen
      Get.back();
    } catch (e) {
      SnackBarPop.showErrorPopup(e.toString(), duration: 4);
      PFullScreenLoader.stopLoading();
    }
  }
}
