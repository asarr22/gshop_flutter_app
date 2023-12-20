import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/emailconfirmation/emil_success.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/emailconfirmation/verify_email_page.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/login.dart';
import 'package:gshopp_flutter/features/authentication/screens/onboarding_screen.dart';
import 'package:gshopp_flutter/features/shell/appshell.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:gshopp_flutter/utils/exceptions/firebase_exceptions.dart';
import 'package:gshopp_flutter/utils/exceptions/format_exceptions.dart';
import 'package:gshopp_flutter/utils/exceptions/platform_exceptions.dart';

class FirebaseAuthService extends GetxController {
  static FirebaseAuthService get instance => Get.find();

  /// Variable
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get authUser => _auth.currentUser;

  final deviceStorage = GetStorage();
  @override
  void onReady() {
// Remove the native splash screen
    FlutterNativeSplash.remove();
// Redirect to the appropriate screch
    screenRedirect();
  }

  /// Function to Show Relevant Screen
  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const AppShell());
      } else {
        Get.offAll(() => VerifyEmailPage(
              email: _auth.currentUser?.email,
            ));
      }
    } else {
      // Local Storage
      deviceStorage.writeIfNull('IsFirstTime', true);
// Check if it's the first time Launching the app
      deviceStorage.read('IsFirstTime') != true ? Get.offAll(() => const LoginPage()) : Get.offAll(const OnBoardingPage());
    }
  }

  /// [EmailAuthentication] SIGN IN

  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw TextValue.somethingWentWrongMessage;
    }
  }

  /// [EmailVerification] - CREATE ACCOUNT
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw TextValue.somethingWentWrongMessage;
    }
  }

  /// [EmailVerification] - MAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw TextValue.somethingWentWrongMessage;
    }
  }

  /// [EmailVerification] - PASSWORD RESET
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw TextValue.somethingWentWrongMessage;
    }
  }

  // Manually Check if Email Verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => const EmailSuccessScreen());
    }
  }

  /// [LogoutUser] - Valid for any authentication.
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginPage());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw TextValue.somethingWentWrongMessage;
    }
  }
}
