import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:gshopp_flutter/features/authentication/screens/emailconfirmation/emil_success.dart';
import 'package:gshopp_flutter/features/authentication/screens/emailconfirmation/verify_email_page.dart';
import 'package:gshopp_flutter/features/authentication/screens/forgot_password/forget_password.dart';
import 'package:gshopp_flutter/features/authentication/screens/forgot_password/reset_password.dart';
import 'package:gshopp_flutter/features/authentication/screens/login_screen.dart';
import 'package:gshopp_flutter/features/authentication/screens/signup_screen.dart';
import 'package:gshopp_flutter/features/shell/appshell.dart';
import 'package:gshopp_flutter/utils/theme/theme.dart';
import 'package:gshopp_flutter/utils/theme/theme_mode.dart';
import 'package:gshopp_flutter/utils/helpers/helper_fuctions.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(); // This will be overridden
});

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeMode = ref.watch(themeModeProvider);
    ThemeMode themeMode;
    switch (appThemeMode) {
      case AppThemeMode.dark:
        themeMode = ThemeMode.dark;
        break;
      case AppThemeMode.light:
        themeMode = ThemeMode.light;
        break;
      case AppThemeMode.system:
      default:
        themeMode = ThemeMode.system;
    }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => GHelper.initialRoute()),
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
