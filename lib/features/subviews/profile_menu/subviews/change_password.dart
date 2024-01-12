import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/widgets/texts/text_field_borderless.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/forgot_password/forget_password.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/controllers/change_password_controller.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/states/password_visiblity.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';

final changePasswordControllerProvider =
    StateNotifierProvider.autoDispose<ChangePasswordFieldController, Map<String, TextEditingController>>(
        (ref) => ChangePasswordFieldController(ref));

final changePasswordVisiblityProvider =
    StateNotifierProvider.autoDispose<ChangePasswordVisiblity, Map<String, bool>>((ref) => ChangePasswordVisiblity());

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(changePasswordControllerProvider);
    final isPasswordVisible = ref.watch(changePasswordVisiblityProvider);
    GlobalKey<FormState> nameKey = GlobalKey<FormState>();

    const String oldPasswordKey = "oldPassword";
    const String newPasswordKey = "newPassword";
    const String newPasswordConfirmKey = "newPasswordConfirm";

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_24),
          onPressed: () => Get.back(),
        ),
        title: Text(
          TextValue.changePassword,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
        child: Form(
          key: nameKey,
          child: Column(
            children: [
              PTextField(
                title: TextValue.oldPassword,
                textEditingController: controller[oldPasswordKey],
                validator: (value) => PValidator.validatePassword(value),
                isForm: true,
                isPassword: true,
                obscureText: isPasswordVisible[oldPasswordKey]!,
                suffixicon: IconButton(
                    onPressed: () => ref.read(changePasswordVisiblityProvider.notifier).toggle(oldPasswordKey),
                    icon: Icon(isPasswordVisible[oldPasswordKey]! ? Iconsax.eye_slash : Iconsax.eye_slash4)),
              ),
              const SizedBox(height: 10),
              PTextField(
                isForm: true,
                title: TextValue.newPassword,
                textEditingController: controller[newPasswordKey],
                validator: (value) => PValidator.validatePassword(value),
                isPassword: true,
                obscureText: isPasswordVisible[newPasswordKey]!,
                suffixicon: IconButton(
                    onPressed: () => ref.read(changePasswordVisiblityProvider.notifier).toggle(newPasswordKey),
                    icon: Icon(isPasswordVisible[newPasswordKey]! ? Iconsax.eye_slash : Iconsax.eye_slash4)),
              ),
              const SizedBox(height: 10),
              PTextField(
                isForm: true,
                title: '${TextValue.newPassword} (Confirmation)',
                textEditingController: controller[newPasswordConfirmKey],
                validator: (value) => PValidator.validatePassword(value),
                isPassword: true,
                obscureText: isPasswordVisible[newPasswordConfirmKey]!,
                suffixicon: IconButton(
                    onPressed: () => ref.read(changePasswordVisiblityProvider.notifier).toggle(newPasswordConfirmKey),
                    icon: Icon(isPasswordVisible[newPasswordConfirmKey]! ? Iconsax.eye_slash : Iconsax.eye_slash4)),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Get.off(() => const ForgotPasswordScreen());
                    },
                    child: Text(
                      TextValue.forgetPassword,
                      style: Theme.of(context).textTheme.labelLarge!.apply(color: ColorPalette.primary),
                      textAlign: TextAlign.end,
                    )),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(changePasswordControllerProvider.notifier).changeUserPassword(nameKey);
                  },
                  child: const Text(TextValue.submit),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
