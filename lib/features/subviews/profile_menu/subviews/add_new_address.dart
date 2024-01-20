import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/widgets/texts/text_field_borderless.dart';
import 'package:gshopp_flutter/features/shell/screens/home.widgets/user_greetings_banner.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/controllers/change_address_controller.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/widgets/addresses_city_zone_popup.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/popups/PCombobox.dart';
import 'package:gshopp_flutter/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends ConsumerWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userControllerProvider);
    final controller = ref.watch(addressFieldControllerProvider);
    final isDefaultToggle = controller["isDefault"];
    GlobalKey<FormState> nameKey = GlobalKey<FormState>();

    ref
        .read(addressFieldControllerProvider.notifier)
        .setNameAndPhoneNumber("${user.firstName} ${user.lastName}", user.phoneNumber.toString());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left_24),
            onPressed: () => Get.back(),
          ),
          title: Text(
            TextValue.editAddress,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
            child: Form(
              key: nameKey,
              child: Column(
                children: [
                  PTextField(
                    title: TextValue.name,
                    textEditingController: controller['fullName'],
                    validator: (value) => PValidator.validateEmptyText('Full Name', value),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: PTextField(
                          title: TextValue.country,
                          textEditingController: controller['country'],
                          validator: (value) => PValidator.validateEmptyText('Country', value),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              TextValue.city,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            const SizedBox(height: 10),
                            PComboBox(
                              tite: controller['city'],
                              onTap: () {
                                CityZoneSelectionPopup.showPicker(context, ref, isCity: true, isZone: false);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TextValue.zone,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 10),
                      PComboBox(
                        tite: controller['zone'],
                        onTap: () {
                          CityZoneSelectionPopup.showPicker(
                            context,
                            ref,
                            isCity: false,
                            isZone: true,
                            userCity: controller['city'],
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  PTextField(
                    title: TextValue.phoneNo,
                    textEditingController: controller['phoneNumber'],
                    validator: (value) => PValidator.validatePhoneNumber(value),
                  ),
                  const SizedBox(height: 10),
                  PTextField(
                    title: TextValue.address,
                    textEditingController: controller['address'],
                    validator: (value) => PValidator.validateEmptyText('Address', value),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: isDefaultToggle,
                        onChanged: (bool? value) {
                          ref.read(addressFieldControllerProvider.notifier).setDefaultToggle(value);
                        },
                      ),
                      const SizedBox(width: 10),
                      Text(
                        TextValue.setAsDefault,
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        ref.read(addressFieldControllerProvider.notifier).addNewAddress(nameKey, ref);
                      },
                      child: const Text(TextValue.add),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
