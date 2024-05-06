import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/features/authentication/controllers/login_controller/login_controller.dart';
import 'package:gshopp_flutter/features/authentication/controllers/login_controller/login_form_controller.dart';
import 'package:gshopp_flutter/features/authentication/controllers/login_controller/login_info.dart';
import 'package:gshopp_flutter/features/authentication/controllers/login_controller/password_visiblity.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/forgot_password/forget_password.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/signup.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/validators/validation.dart';
import 'package:gshopp_flutter/utils/widgets/text_field_borderless.dart';

final loginFormControllerProvider =
    StateNotifierProvider.autoDispose<LoginFormControllers, Map<String, TextEditingController>>(
        (ref) => LoginFormControllers());

final signInProvider = StateNotifierProvider.autoDispose<LoginController, LoginInfo>((ref) => LoginController(ref));

final passwordVisibilityProvider =
    StateNotifierProvider.autoDispose<LoginPasswordVisibility, bool>((ref) => LoginPasswordVisibility());

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> signinKey = GlobalKey<FormState>();
    final isPasswordVisible = ref.watch(passwordVisibilityProvider);
    final controller = ref.watch(loginFormControllerProvider);
    const emailKey = 'email';
    const passwordKey = 'password';
    return Form(
      key: signinKey,
      child: Column(
        children: [
          /// Email
          GTextField(
            isForm: true,
            textEditingController: controller[emailKey],
            validator: (value) => PValidator.validateEmail(value),
            prefixIcon: const Icon(Icons.email_outlined),
            hint: TextValue.email,
          ),

          const SizedBox(height: SizesValue.sm),

          /// Password
          GTextField(
            isForm: true,
            textEditingController: controller[passwordKey],
            hint: TextValue.password,
            validator: (value) => PValidator.validatePassword(value),
            obscureText: isPasswordVisible,
            isPassword: true,
            prefixIcon: const Icon(Icons.password_outlined),
            suffixIcon: IconButton(
              icon: Icon(isPasswordVisible ? Icons.visibility_off : Icons.visibility),
              onPressed: () => ref.read(passwordVisibilityProvider.notifier).toggle(),
            ),
          ),

          /// Remember Me & Forget Password
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Get.to(const ForgotPasswordScreen());
              },
              child: const Text(
                TextValue.forgetPassword,
                style: TextStyle(
                  color: ColorPalette.primary,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),

          /// Sign In
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
                child: const Text(
                  TextValue.signin,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () {
                  final info = LoginInfo(
                      email: controller[emailKey]!.text, password: controller[passwordKey]!.text, signinKey: signinKey);
                  ref.read(signInProvider.notifier).signWithEmailAndPassword(info, context, controller);
                }),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: OutlinedButton(
                child: const Text(
                  TextValue.createAccount,
                  style: TextStyle(color: ColorPalette.primary, fontSize: 16),
                ),
                onPressed: () => Get.to(const SignUpPage())),
          ),
        ],
      ),
    );
  }
}
