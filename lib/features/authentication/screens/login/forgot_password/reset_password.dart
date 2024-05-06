import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/forgot_password/forget_password.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/login.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/images_values.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import '../../../../../utils/helpers/helper_fuctions.dart';

class ResetPasswordScreen extends ConsumerWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.close,
                color: isDarkMode ? Colors.white : Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SizesValue.padding),
          child: Column(
            children: [
              // Image
              Image(
                image: const AssetImage(ImagesValue.emailSent),
                width: GHelper.screenWidth(context) * 0.8,
              ),
              //Title Subtitle
              Text(TextValue.passwordResetTitle,
                  style: Theme.of(context).textTheme.displayLarge, textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text(TextValue.passwordResetSubtitle,
                  style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
              const SizedBox(height: 30),

              /// Buttons
              SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Get.offAll(() => const LoginPage());
                      },
                      child: const Text(
                        TextValue.ok,
                      ))),
              const SizedBox(height: 10),
              SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: TextButton(
                      onPressed: () {
                        ref.read(emailFieldProvider.notifier).resendPasswordResetLink(context);
                      },
                      child: const Text(
                        TextValue.resendEmail,
                        style: TextStyle(color: ColorPalette.primary),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
