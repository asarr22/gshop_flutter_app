import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/features/authentication/controllers/signup_controller/privacy_policy.dart';
import 'package:gshopp_flutter/features/authentication/controllers/signup_controller/signup_controller.dart';
import 'package:gshopp_flutter/features/authentication/controllers/signup_controller/signup_info.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/helpers/helper_fuctions.dart';
import 'package:gshopp_flutter/utils/validators/validation.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:gshopp_flutter/utils/widgets/text_field_borderless.dart';
import 'package:iconsax/iconsax.dart';

final formControllersProvider =
    StateNotifierProvider.autoDispose<SignUpFormControllers, Map<String, TextEditingController>>(
        (ref) => SignUpFormControllers());
final passwordVisibilityProvider = StateProvider.autoDispose<bool>((ref) => false);

final privacyAndTermProvider =
    StateNotifierProvider.autoDispose<PrivacyPolicyAndTerm, bool>((ref) => PrivacyPolicyAndTerm());

final signUpProvider = StateNotifierProvider.autoDispose<SignUpController, SignUpInfo>((ref) => SignUpController(ref));

class SignUpForm extends ConsumerWidget {
  const SignUpForm({super.key, required this.mainContext});

  final BuildContext mainContext;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = GHelper.isDarkMode(context);
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
                child: GTextField(
                  isForm: true,
                  validator: (value) => PValidator.validateEmptyText('First Name', value),
                  textEditingController: controllers['firstName'],
                  hint: TextValue.firstName,
                  prefixIcon: const Icon(Iconsax.user),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GTextField(
                  isForm: true,
                  textEditingController: controllers['lastName'],
                  validator: (value) => PValidator.validateEmptyText('Last Name', value),
                  hint: TextValue.lastName,
                  prefixIcon: const Icon(Iconsax.user),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          GTextField(
              isForm: true,
              textEditingController: controllers['email'],
              validator: (value) => PValidator.validateEmail(value),
              hint: TextValue.email,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Iconsax.sms)),
          const SizedBox(height: 10),
          GTextField(
            isForm: true,
            textEditingController: controllers['phoneNumber'],
            validator: (value) => PValidator.validatePhoneNumber(value),
            hint: TextValue.phoneNo,
            prefixIcon: const Icon(Iconsax.call),
          ),
          const SizedBox(height: 10),
          GTextField(
            isForm: true,
            textEditingController: controllers['password'],
            validator: (value) => PValidator.validatePassword(value),
            obscureText: !isPasswordVisible,
            hint: TextValue.password,
            prefixIcon: const Icon(Iconsax.password_check),
            suffixIcon: IconButton(
              icon: Icon(!isPasswordVisible ? Iconsax.eye_slash : Iconsax.eye),
              onPressed: () => ref.read(passwordVisibilityProvider.notifier).state = !isPasswordVisible,
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
