import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:gshopp_flutter/common/firebase_services/auth_services.dart';
import 'package:gshopp_flutter/common/firebase_services/product_repository.dart';
import 'package:gshopp_flutter/common/firebase_services/user_repository.dart';
import 'package:gshopp_flutter/common/models/product/product_model.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/emailconfirmation/emil_success.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/emailconfirmation/verify_email_page.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/forgot_password/forget_password.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/forgot_password/reset_password.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/login.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/signup.dart';
import 'package:gshopp_flutter/features/authentication/screens/onboarding_screen.dart';
import 'package:gshopp_flutter/common/controllers/product_controller.dart';
import 'package:gshopp_flutter/features/shell/appshell.dart';
import 'package:gshopp_flutter/utils/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  // Obtain the FirebaseAuthService instance from the provider
  final authService = ref.watch(firebaseAuthService);

  // Pass the FirebaseAuthService instance to UserRepository
  return UserRepository(authService);
});
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository();
});
final productControllerProvider = StateNotifierProvider<ProductController, Map<String, List<Product>>>((ref) {
  return ProductController(ref.watch(productRepositoryProvider));
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(); // This will be overridden
});

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const OnBoardingPage()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/signup', page: () => const SignUpPage()),
        GetPage(name: '/appshell', page: () => const AppShell()),
        GetPage(name: '/verifyemail', page: () => const VerifyEmailPage()),
        GetPage(name: '/emailsuccess', page: () => const EmailSuccessScreen()),
        GetPage(name: '/forgotpasswordscreen', page: () => const ForgotPasswordScreen()),
        GetPage(name: '/resetpassword', page: () => const ResetPasswordScreen()),
      ],
    );
  }
}
