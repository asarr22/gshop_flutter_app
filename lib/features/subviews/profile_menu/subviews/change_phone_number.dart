import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/app.dart';
import 'package:gshopp_flutter/utils/widgets/text_field_borderless.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/controllers/change_phone_number_controller.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';

final phoneNumberFieldProvider = StateNotifierProvider.autoDispose<ChangePhoneNumberController, TextEditingController>(
    (ref) => ChangePhoneNumberController());

class ChangePhoneNumberScreen extends ConsumerWidget {
  const ChangePhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userControllerProvider);
    final controller = ref.watch(phoneNumberFieldProvider);
    GlobalKey<FormState> nameKey = GlobalKey<FormState>();

    ref.read(phoneNumberFieldProvider.notifier).setValue(user.phoneNumber);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left_24),
            onPressed: () => Get.back(),
          ),
          title: Text(
            TextValue.editPhoneNumber,
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
                  title: TextValue.firstName,
                  textEditingController: controller,
                  validator: (value) => PValidator.validatePhoneNumber(value),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(phoneNumberFieldProvider.notifier).updatePhoneNumber(nameKey, ref);
                    },
                    child: const Text(TextValue.submit),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
