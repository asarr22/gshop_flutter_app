import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/controllers/user_controller.dart';
import 'package:gshopp_flutter/features/authentication/controllers/signup_controller/signup_info.dart';
import 'package:gshopp_flutter/common/repositories/auth_services.dart';
import 'package:gshopp_flutter/features/authentication/screens/emailconfirmation/verify_email_page.dart';
import 'package:gshopp_flutter/utils/helpers/network_manager.dart';
import 'package:gshopp_flutter/utils/popups/loading_screen_full.dart';

class SignUpFormControllers extends StateNotifier<Map<String, TextEditingController>> {
  SignUpFormControllers()
      : super({
          'firstName': TextEditingController(),
          'lastName': TextEditingController(),
          'email': TextEditingController(),
          'username': TextEditingController(),
          'password': TextEditingController(),
          'phoneNumber': TextEditingController(),
        });

  @override
  void dispose() {
    state.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }
}

class SignUpController extends StateNotifier<SignUpInfo> {
  final Ref ref;

  SignUpController(this.ref)
      : super(
          SignUpInfo(firstName: "", lastName: "", email: "", password: "", phoneNumber: "", signupKey: GlobalKey()),
        );

  void signup(SignUpInfo signInfo, context, controllers) async {
    final authService = ref.watch(firebaseAuthServiceProvider);

    final isConnected = await NetworkManager.instance.isConnected();
    try {
      //Start Loading
      GLoadingScreen.openLoadingDialog(context);

      //Return if no Network
      if (!isConnected) {
        GLoadingScreen.stopLoading();
        return;
      }

      //Check if user has properly entered information
      if (!signInfo.signupKey.currentState!.validate()) {
        GLoadingScreen.stopLoading();
        return;
      }

      //Connexion to backend for SignUp
      final userCredential = await authService.registerWithEmailAndPassword(signInfo.email, signInfo.password);

      await ref.read(userControllerProvider.notifier).saveUserRecord(userCredential);

      //Clear TextFields
      clearTextFields(controllers);

      //
      GLoadingScreen.stopLoading();
      Get.to(() => VerifyEmailPage(
            email: signInfo.email.trim(),
          ));
    } catch (e) {
      //

      //
      if (kDebugMode) {
        print("G-ERROR SPOTTED :  ${e.toString()}");
      }
    }
  }

  void clearTextFields(Map<String, TextEditingController> controllers) {
    controllers.forEach((key, controller) {
      controller.clear();
    });
  }
}
