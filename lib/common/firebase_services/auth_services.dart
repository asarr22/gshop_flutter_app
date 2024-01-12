import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/app.dart';
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
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';
import 'package:shared_preferences/shared_preferences.dart';

final firebaseAuthService = Provider<FirebaseAuthService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return FirebaseAuthService(prefs);
});

class FirebaseAuthService extends GetxController {
  static FirebaseAuthService get instance => Get.find();

  final SharedPreferences prefs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    // Remove the native splash screen
    FlutterNativeSplash.remove();
    // Redirect to the appropriate screch
    screenRedirect();
  }

  FirebaseAuthService(this.prefs);

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
      prefs.setBool(
          'IsFirstTime', prefs.getBool('IsFirstTime') ?? true); // Check if it's the first time Launching the app
      (prefs.getBool('IsFirstTime') != true) ? Get.offAll(() => const LoginPage()) : Get.offAll(const OnBoardingPage());
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

  /// [EmailVerification] - PASSWORD CHANGES
  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: _auth.currentUser!.email ?? "",
        password: oldPassword,
      );

      await _auth.currentUser!.reauthenticateWithCredential(credential);
      await _auth.currentUser!.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackBarPop.showErrorPopup('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        SnackBarPop.showErrorPopup(TextValue.oldPassMismatch);
      }
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
