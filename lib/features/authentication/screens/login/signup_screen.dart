import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/signup.widget/signup_form.dart';
import 'package:gshopp_flutter/features/authentication/screens/login/signup.widget/signup_heder_footer.dart';

import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:iconsax/iconsax.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_24),
          onPressed: () => Get.back(),
        ),
        toolbarHeight: 50,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SizesValue.padding),
          child: Column(
            children: [
              const SignupHeader(),
              const SizedBox(height: 30),
              SignUpForm(mainContext: context),

              const SizedBox(height: 20),
              const SignupWithProvider(),

              //Footer
              const SizedBox(height: 20),
              const SignupFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
