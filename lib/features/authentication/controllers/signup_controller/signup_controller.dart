import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/features/authentication/controllers/signup_controller/signup_info.dart';
import 'package:gshopp_flutter/common/firebase_services/auth_services.dart';
import 'package:gshopp_flutter/common/firebase_services/user_repository.dart';
import 'package:gshopp_flutter/features/authentication/models/user_Model.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/emailconfirmation/verify_email_page.dart';
import 'package:gshopp_flutter/utils/helpers/network_manager.dart';
import 'package:gshopp_flutter/utils/popups/full_screen_loader.dart';

class SignUpFormControllers
    extends StateNotifier<Map<String, TextEditingController>> {
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
  SignUpController()
      : super(
          SignUpInfo(
              userName: "",
              firstName: "",
              lastName: "",
              email: "",
              password: "",
              phoneNumber: "",
              signupKey: GlobalKey()),
        );

  void signup(SignUpInfo signInfo, context, controllers) async {
    final isConnected = await NetworkManager.instance.isConnected();
    try {
      //Start Loading
      PFullScreenLoader.openLoadingDialog(context);

      //Return if no Network
      if (!isConnected) {
        PFullScreenLoader.stopLoading();
        return;
      }

      //Check if user has properly entered information
      if (!signInfo.signupKey.currentState!.validate()) {
        PFullScreenLoader.stopLoading();
        return;
      }

      //Connexion to backend for SignUp
      Get.put(FirebaseAuthService());
      final userCredential = await FirebaseAuthService.instance
          .registerWithEmailAndPassword(signInfo.email, signInfo.password);

      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: signInfo.firstName.trim(),
        lastName: signInfo.lastName.trim(),
        username: signInfo.userName.trim(),
        email: signInfo.email.trim(),
        phoneNumber: signInfo.phoneNumber.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      userRepository.saveUserRecord(newUser);

      //Clear TextFields
      clearTextFields(controllers);

      //
      PFullScreenLoader.stopLoading();
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
