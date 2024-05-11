import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/controllers/user_controller.dart';
import 'package:gshopp_flutter/common/models/address/address_model.dart';
import 'package:gshopp_flutter/utils/widgets/text_field_borderless.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/controllers/change_address_controller.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/widgets/addresses_city_zone_popup.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/popups/pcombobox.dart';

class EditdAddressScreen extends ConsumerStatefulWidget {
  const EditdAddressScreen({super.key, required this.selectedId});
  final String selectedId;
  @override
  ConsumerState<EditdAddressScreen> createState() => _EditdAddressScreenState();
}

class _EditdAddressScreenState extends ConsumerState<EditdAddressScreen> {
  @override
  void initState() {
    super.initState();
    final user = ref.read(userControllerProvider);
    UserAddress oldAddress = user.address.firstWhere((e) => e.id == widget.selectedId);
    ref.read(addressFieldControllerProvider.notifier).setFieldsValue(oldAddress);
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> nameKey = GlobalKey<FormState>();
    final controller = ref.watch(addressFieldControllerProvider);
    return Scaffold(
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
                GTextField(
                  title: TextValue.name,
                  textEditingController: controller['fullName'],
                  validator: (value) => PValidator.validateEmptyText('Full Name', value),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: GTextField(
                        isEnabled: false,
                        title: TextValue.country,
                        textEditingController: controller['country'],
                        validator: (value) => PValidator.validateEmptyText('Country', value),
                      ),
                    ),
                    const SizedBox(width: 10),
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
                GTextField(
                  title: TextValue.phoneNo,
                  textEditingController: controller['phoneNumber'],
                  validator: (value) => PValidator.validatePhoneNumber(value),
                ),
                const SizedBox(height: 10),
                GTextField(
                  title: TextValue.address,
                  textEditingController: controller['address'],
                  validator: (value) => PValidator.validateEmptyText('Address', value),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: controller['isDefault'],
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
                      ref.read(addressFieldControllerProvider.notifier).updateAddress(nameKey, ref, widget.selectedId);
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
