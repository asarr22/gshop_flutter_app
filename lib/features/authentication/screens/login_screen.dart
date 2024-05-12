import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/login_form.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/login_header_footer.dart';
import 'package:gshopp_flutter/features/shell/appshell.dart';
import 'package:gshopp_flutter/main.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:iconsax/iconsax.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pref = ref.watch(sharedPreferencesProvider);
    final bool comeFromProfile = pref.getBool('comeFromProfile') ?? false;

    return Scaffold(
      appBar: !comeFromProfile
          ? AppBar(
              actions: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text(
                      TextValue.skip,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: ColorPalette.primary),
                    ),
                    onPressed: () {
                      pref.setBool('hasSkippedLogin', true);
                      pref.setBool('hasLogin', false);
                      Get.offAll(() => const AppShell());
                    },
                  ),
                ),
              ],
            )
          : AppBar(
              toolbarHeight: 50,
              leading: IconButton(
                icon: const Icon(Iconsax.arrow_left_24),
                onPressed: () => Get.back(),
              ),
            ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SizesValue.padding),
          child: Column(
            children: [
              // Header
              const LoginPageHeader(),
              const SizedBox(height: 15),

              // Login Form
              const LoginForm(),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Flexible(
                    child: Divider(color: Colors.grey, endIndent: 10),
                  ),
                  Text(
                    TextValue.orSignInwith,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const Flexible(
                    child: Divider(color: Colors.grey, indent: 10),
                  ),
                ],
              ),

              //Footer
              const SizedBox(height: 20),
              const LoginPageFooter()
            ],
          ),
        ),
      ),
    );
  }
}
