import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/widgets/texts/text_field_borderless.dart';
import 'package:gshopp_flutter/features/shell/screens/home.widgets/user_greetings_banner.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/controllers/update_name_controller.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';

final nameFieldControllerProvider = StateNotifierProvider<NameFieldController, Map<String, TextEditingController>>((ref) => NameFieldController());

class EditNameScreen extends ConsumerWidget {
  const EditNameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userControllerProvider);
    final controller = ref.watch(nameFieldControllerProvider);
    GlobalKey<FormState> nameKey = GlobalKey<FormState>();

    ref.read(nameFieldControllerProvider.notifier).setName(user.firstName, user.lastName);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left_24),
            onPressed: () => Get.back(),
          ),
          title: Text(
            TextValue.editName,
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
                  textEditingController: controller['firstName'],
                  validator: (value) => PValidator.validateEmptyText('First name', value),
                ),
                const SizedBox(height: 10),
                PTextField(
                  title: TextValue.lastName,
                  textEditingController: controller['lastName'],
                  validator: (value) => PValidator.validateEmptyText('Last name', value),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(nameFieldControllerProvider.notifier).updateUserFullName(nameKey, ref);
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
