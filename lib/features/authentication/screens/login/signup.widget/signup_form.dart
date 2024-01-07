import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/features/authentication/controllers/signup_controller/password_visiblity.dart';
import 'package:gshopp_flutter/features/authentication/controllers/signup_controller/privacy_policy.dart';
import 'package:gshopp_flutter/features/authentication/controllers/signup_controller/signup_controller.dart';
import 'package:gshopp_flutter/features/authentication/controllers/signup_controller/signup_info.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';
import 'package:gshopp_flutter/utils/validators/validation.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

final formControllersProvider =
    StateNotifierProvider.autoDispose<SignUpFormControllers, Map<String, TextEditingController>>((ref) => SignUpFormControllers());
final passwordVisibilityProvider = StateNotifierProvider.autoDispose<PasswordVisibility, bool>((ref) => PasswordVisibility());

final privacyAndTermProvider = StateNotifierProvider.autoDispose<PrivacyPolicyAndTerm, bool>((ref) => PrivacyPolicyAndTerm());

final signUpProvider = StateNotifierProvider.autoDispose<SignUpController, SignUpInfo>((ref) => SignUpController());

class SignUpForm extends ConsumerWidget {
  const SignUpForm({super.key, required this.mainContext});

  final BuildContext mainContext;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = HelperFunctions.isDarkMode(context);
    GlobalKey<FormState> signupKey = GlobalKey<FormState>();
    final isPasswordVisible = ref.watch(passwordVisibilityProvider);
    final isPrivacyAccepted = ref.watch(privacyAndTermProvider);
    final controllers = ref.watch(formControllersProvider);

    return Form(
      key: signupKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  validator: (value) => PValidator.validateEmptyText('First Name', value),
                  controller: controllers['firstName'],
                  expands: false,
                  decoration: const InputDecoration(labelText: TextValue.firstName, prefixIcon: Icon(Icons.person_outlined)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: controllers['lastName'],
                  validator: (value) => PValidator.validateEmptyText('Last Name', value),
                  expands: false,
                  decoration: const InputDecoration(labelText: TextValue.lastName, prefixIcon: Icon(Icons.person_outlined)),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controllers['email'],
            validator: (value) => PValidator.validateEmail(value),
            expands: false,
            decoration: const InputDecoration(labelText: TextValue.email, prefixIcon: Icon(Icons.email_outlined)),
          ),
          const SizedBox(height: 10),
          TextFormField(
            expands: false,
            controller: controllers['phoneNumber'],
            validator: (value) => PValidator.validatePhoneNumber(value),
            decoration: const InputDecoration(labelText: TextValue.phoneNo, prefixIcon: Icon(Icons.call_outlined)),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controllers['password'],
            expands: false,
            validator: (value) => PValidator.validatePassword(value),
            obscureText: isPasswordVisible,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: TextValue.password,
              prefixIcon: const Icon(Icons.password_outlined),
              suffixIcon: IconButton(
                icon: Icon(isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                onPressed: () => ref.read(passwordVisibilityProvider.notifier).toggle(),
              ),
            ),
          ),

          const SizedBox(height: 20),
          // Terms and Condition

          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: isPrivacyAccepted,
                  onChanged: (value) {
                    ref.read(privacyAndTermProvider.notifier).toggle();
                  },
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: '${TextValue.agreeTo} ', style: Theme.of(context).textTheme.bodySmall),
                      TextSpan(
                        text: '${TextValue.privacyPolicy} ',
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: isDarkMode ? Colors.white : ColorPalette.primary,
                            decoration: TextDecoration.underline,
                            decorationColor: isDarkMode ? Colors.white : ColorPalette.primary),
                      ),
                      TextSpan(text: '${TextValue.and} ', style: Theme.of(context).textTheme.bodySmall),
                      TextSpan(
                          text: TextValue.termsOfUse,
                          style: Theme.of(context).textTheme.bodyMedium!.apply(
                                color: isDarkMode ? Colors.white : ColorPalette.primary,
                                decoration: TextDecoration.underline,
                                decorationColor: isDarkMode ? Colors.white : ColorPalette.primary,
                              )),
                    ],
                  ),
                  maxLines: 2,
                ),
              )
            ],
          ),

          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
                child: const Text(
                  TextValue.createAccount,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () {
                  if (isPrivacyAccepted) {
                    final SignUpInfo newSignup = SignUpInfo(
                        email: controllers['email']!.text,
                        firstName: controllers['firstName']!.text,
                        lastName: controllers['lastName']!.text,
                        password: controllers['password']!.text,
                        phoneNumber: controllers['phoneNumber']!.text,
                        signupKey: signupKey);

                    ref.read(signUpProvider.notifier).signup(newSignup, mainContext, controllers);
                  } else {
                    AnimatedSnackBar.material(TextValue.accetpPrivacyAndTerm,
                            type: AnimatedSnackBarType.warning, mobileSnackBarPosition: MobileSnackBarPosition.bottom)
                        .show(context);
                  }
                }),
          ),
        ],
      ),
    );
  }
}
