import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/features/authentication/controllers/signup_controller/verify_email.dart';
import 'package:gshopp_flutter/common/firebase_services/auth_services.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/images_values.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';

class VerifyEmailPage extends ConsumerWidget {
  const VerifyEmailPage({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final authService = ref.watch(firebaseAuthServiceProvider);
    final verifyEmailController = ref.watch(verifyEmailControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () async => authService.logout(),
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
              const Image(image: AssetImage(ImagesValue.emailSent)),
              //Title Subtitle
              Text(TextValue.confirmEmail,
                  style: Theme.of(context).textTheme.displayLarge, textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text(email ?? '', style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text(TextValue.confirmEmailSubtitle,
                  style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
              const SizedBox(height: 10),

              /// Buttons
              SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => verifyEmailController.checkEmailVerificationStatus(),
                      child: const Text(
                        TextValue.tContinue,
                      ))),
              const SizedBox(height: 10),
              SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: TextButton(
                      onPressed: () => verifyEmailController.sendEmailVerification(),
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
