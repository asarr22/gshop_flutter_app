import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/controllers/app_parameters_controller.dart';
import 'package:gshopp_flutter/common/repositories/auth_services.dart';
import 'package:gshopp_flutter/features/authentication/controllers/login_controller/login_info.dart';
import 'package:gshopp_flutter/utils/helpers/network_manager.dart';
import 'package:gshopp_flutter/utils/popups/loading_screen_full.dart';
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';

class LoginController extends StateNotifier<LoginInfo> {
  final Ref ref;
  LoginController(this.ref) : super(LoginInfo(email: 'email', password: 'password', signinKey: GlobalKey()));

  /// -- Email and Password SignIn
  void signWithEmailAndPassword(LoginInfo loginInfo, BuildContext context, controller) async {
    try {
      final authService = ref.watch(firebaseAuthServiceProvider);

      // Start Loading
      GLoadingScreen.openLoadingDialog(context);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        GLoadingScreen.stopLoading();
        return;
      }

      // Form Validation
      if (!loginInfo.signinKey.currentState!.validate()) {
        GLoadingScreen.stopLoading();
        return;
      }

      //Login with user Data
      await authService.loginWithEmailAndPassword(loginInfo.email.trim(), loginInfo.password.trim());

      //Clear Fields
      clearTextFields(controller);
      //Remove Loading Screen
      GLoadingScreen.stopLoading();

      // Go to Concerned Page
      authService.screenRedirect();

      // Init App Controller methods For the first time to avoid null exception
      ref.read(appControllerProvider.notifier).getShippmentData();
    } catch (e) {
      GLoadingScreen.stopLoading();
      SnackBarPop.showErrorPopup(e.toString(), duration: 3);
    }
  }

  void clearTextFields(Map<String, TextEditingController> controllers) {
    controllers.forEach((key, controller) {
      controller.clear();
    });
  }
}
