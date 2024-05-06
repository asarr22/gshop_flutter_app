import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/states/address_state.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/subviews/add_new_address.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/subviews/edit_address_screen.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/widgets/address_tile.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/helpers/helper_fuctions.dart';
import 'package:iconsax/iconsax.dart';

class AddressesScreen extends ConsumerWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = GHelper.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          TextValue.myAddresses,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_24),
          onPressed: () => Get.back(),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizesValue.padding),
          child: AddressListWidget(),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: IconButton(
          style: IconButton.styleFrom(
              backgroundColor: isDarkMode ? ColorPalette.primaryDark : ColorPalette.primary, elevation: 5),
          onPressed: () {
            Get.to(() => const AddNewAddressScreen());
          },
          icon: const Icon(
            Iconsax.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class AddressListWidget extends ConsumerWidget {
  const AddressListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userAddressProvider);
    final userAddressNotifier = ref.read(userAddressProvider.notifier);
    return SizedBox(
      width: double.infinity,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: state.addresses.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final address = state.addresses[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: AddressTile(
              selectedAddress: address.isDefault,
              fullName: address.fullName,
              phoneNumber: address.phoneNumber,
              details: "${address.address} ${address.country}, ${address.city}, ${address.zone}",
              onTap: () {
                userAddressNotifier.setAsDefault(address.id);
              },
              onEdit: () => Get.to(
                () => EditdAddressScreen(
                  selectedId: address.id,
                ),
              ),
              onRemove: () => userAddressNotifier.removeAddress(address.id),
            ),
          );
        },
      ),
    );
  }
}
