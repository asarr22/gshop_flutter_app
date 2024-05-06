import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/features/authentication/controllers/reset_password_controller/forgot_pass_controller.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/validators/validation.dart';

final emailFieldProvider =
    StateNotifierProvider<ForgotPasswordController, TextEditingController>((ref) => ForgotPasswordController(ref));

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(emailFieldProvider);
    GlobalKey<FormState> resetKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TextValue.forgetPasswordTitle,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              TextValue.forgetPasswordSubtitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 30),

            // TextField
            Form(
              key: resetKey,
              child: TextFormField(
                controller: controller,
                validator: (value) => PValidator.validateEmail(value),
                decoration: const InputDecoration(
                  labelText: TextValue.email,
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                  autofocus: true,
                  child: const Text(
                    TextValue.submit,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    ref.read(emailFieldProvider.notifier).sendPasswordResetLink(context, resetKey);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
