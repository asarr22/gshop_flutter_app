import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/firebase_services/auth_services.dart';
import 'package:gshopp_flutter/utils/constants/images_values.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';

class EmailSuccessScreen extends ConsumerWidget {
  const EmailSuccessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(firebaseAuthServiceProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SizesValue.padding),
          child: Column(
            children: [
              // Image
              Image(
                image: const AssetImage(ImagesValue.emailVerified),
                width: HelperFunctions.screenWidth(context) * 0.8,
              ),
              //Title Subtitle
              Text(TextValue.accountCreatedTitle,
                  style: Theme.of(context).textTheme.displayLarge, textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text(TextValue.accountCreatedSubtitle,
                  style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
              const SizedBox(height: 10),

              /// Buttons
              SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async => await authService.screenRedirect(),
                      child: const Text(
                        TextValue.tContinue,
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
