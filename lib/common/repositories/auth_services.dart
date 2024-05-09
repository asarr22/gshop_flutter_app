import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/controllers/app_parameters_controller.dart';
import 'package:gshopp_flutter/features/authentication/screens/emailconfirmation/emil_success.dart';
import 'package:gshopp_flutter/features/authentication/screens/emailconfirmation/verify_email_page.dart';
import 'package:gshopp_flutter/features/authentication/screens/login_screen.dart';
import 'package:gshopp_flutter/features/onboarding/onboarding_screen.dart';
import 'package:gshopp_flutter/features/shell/appshell.dart';
import 'package:gshopp_flutter/main.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:gshopp_flutter/utils/exceptions/firebase_exceptions.dart';
import 'package:gshopp_flutter/utils/exceptions/format_exceptions.dart';
import 'package:gshopp_flutter/utils/exceptions/platform_exceptions.dart';
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';
import 'package:gshopp_flutter/utils/helpers/helper_fuctions.dart';
import 'package:shared_preferences/shared_preferences.dart';

final firebaseAuthServiceProvider = Provider<FirebaseAuthService>((ref) {
  ref.watch(appControllerProvider);

  final prefs = ref.watch(sharedPreferencesProvider);
  return FirebaseAuthService(prefs);
});

class FirebaseAuthService {
  final SharedPreferences prefs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuthService(this.prefs);
  User? get authUser => _auth.currentUser;

  Future<void> initialSetup() async {
    FlutterNativeSplash.remove();
    await screenRedirect();
  }

  screenRedirect() async {
    final user = _auth.currentUser;
    if ((prefs.getBool('hasSkippedLogin') ?? false) == true) {
      try {
        Get.offAll(const AppShell());
      } catch (e) {
        if (kDebugMode) {
          print('Error: $e, App Will try to set manual route');
        }
      } finally {
        GHelper.initialRoute = () => const AppShell();
      }

      return;
    }

    if (user != null) {
      // Save login status
      prefs.setBool('hasSkippedLogin', true);
      prefs.setBool('hasLogin', true);

      if (user.emailVerified) {
        try {
          Get.offAll(const AppShell());
        } catch (e) {
          if (kDebugMode) {
            print('Error: $e, App Will try to set manual route');
          }
        } finally {
          GHelper.initialRoute = () => const AppShell();
        }
      } else {
        Get.offAll(() => VerifyEmailPage(
              email: _auth.currentUser?.email,
            ));
      }
    } else {
      // Local Storage
      prefs.setBool(
          'IsFirstTime', prefs.getBool('IsFirstTime') ?? true); // Check if it's the first time Launching the app
      (prefs.getBool('IsFirstTime') != true)
          ? Get.offAll(() => const LoginPage())
          : GHelper.initialRoute = () => const OnBoardingPage();
    }
  }

  /// [EmailAuthentication] SIGN IN

  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw GFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw GFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const GFormatException();
    } on PlatformException catch (e) {
      throw GPlatformException(e.code).message;
    } catch (e) {
      throw TextValue.somethingWentWrongMessage;
    }
  }

  /// [EmailVerification] - CREATE ACCOUNT
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
    } on FirebaseAuthException catch (e) {
      throw GFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw GFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const GFormatException();
    } on PlatformException catch (e) {
      throw GPlatformException(e.code).message;
    } catch (e) {
      throw TextValue.somethingWentWrongMessage;
    }
  }

  /// [EmailVerification] - MAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw GFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw GFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const GFormatException();
    } on PlatformException catch (e) {
      throw GPlatformException(e.code).message;
    } catch (e) {
      throw TextValue.somethingWentWrongMessage;
    }
  }

  /// [EmailVerification] - PASSWORD RESET
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw GFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw GFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const GFormatException();
    } on PlatformException catch (e) {
      throw GPlatformException(e.code).message;
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
      // Save login status
      prefs.setBool('hasLogin', false);
    } on FirebaseAuthException catch (e) {
      throw GFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw GFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const GFormatException();
    } on PlatformException catch (e) {
      throw GPlatformException(e.code).message;
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
      throw GFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw GFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const GFormatException();
    } on PlatformException catch (e) {
      throw GPlatformException(e.code).message;
    } catch (e) {
      throw TextValue.somethingWentWrongMessage;
    }
  }
}
