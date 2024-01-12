import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/app.dart';
import 'package:gshopp_flutter/common/models/address/address_model.dart';
import 'package:gshopp_flutter/features/shell/screens/home.widgets/user_greetings_banner.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/helpers/network_manager.dart';
import 'package:gshopp_flutter/utils/popups/full_screen_loader.dart';
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';

class UserAddressState {
  final List<UserAddress> addresses;
  final String? selectedAddressId; // You can use another unique identifier
  UserAddressState({required this.addresses, this.selectedAddressId});
  // Add a method to get the default address
  UserAddress? get defaultAddress =>
      addresses.firstWhereOrNull((address) => address.isDefault);
}

// Create a StateNotifier to manage the state
class UserAddressNotifier extends StateNotifier<UserAddressState> {
  UserAddressNotifier(this.ref)
      : super(UserAddressState(
            addresses: ref.watch(userControllerProvider).address));
  final Ref ref;

  void setAsDefault(String addressId) {
    for (var address in state.addresses) {
      if (address.id == addressId) {
        address.isDefault = true;
      } else {
        address.isDefault = false;
      }
    }
    state = UserAddressState(addresses: state.addresses);
    updateUserAddress();
  }

  void removeAddress(String addressId) {
    state.addresses.removeWhere((address) => address.id == addressId);

    // Reorder address IDs
    int i = 1;
    for (var address in state.addresses) {
      address.id = i.toString();
      i++;
    }
    // Set the first ID as default
    state.addresses[0].isDefault = true;
    state = UserAddressState(addresses: state.addresses);
    updateUserAddress();
  }

  Future<void> updateUserAddress() async {
    try {
      // Start Loading
      PFullScreenLoader.openLoadingDialog(Get.context!);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        PFullScreenLoader.stopLoading();
        return;
      }

      // Update user's first & last name in the Firebase Firestore
      final userController = ref.read(userControllerProvider.notifier);
      final userRepository = ref.read(userRepositoryProvider);
      final userAddresses = state.addresses;

      Map<String, dynamic> addresses = {
        'Address':
            userAddresses.map((userAddress) => userAddress.toJson()).toList()
      };
      await userRepository.updateSingleField(addresses);

      // Update the Provider User Value
      userController.updateUserInfo(
        address: userAddresses,
      );
      // Remove Loader
      PFullScreenLoader.stopLoading();

      // Show Success Message
      SnackBarPop.showSucessPopup(TextValue.defaultAddressSetSuccessMessage,
          duration: 4);
    } catch (e) {
      SnackBarPop.showErrorPopup(e.toString(), duration: 4);
      PFullScreenLoader.stopLoading();
    }
  }
}

final userAddressProvider =
    StateNotifierProvider<UserAddressNotifier, UserAddressState>((ref) {
  return UserAddressNotifier(ref);
});
