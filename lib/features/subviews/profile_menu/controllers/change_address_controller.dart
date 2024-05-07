import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/controllers/user_controller.dart';
import 'package:gshopp_flutter/common/models/address/address_model.dart';
import 'package:gshopp_flutter/common/repositories/user_repository.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/helpers/network_manager.dart';
import 'package:gshopp_flutter/utils/popups/loading_screen_full.dart';
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';

final addressFieldControllerProvider =
    StateNotifierProvider.autoDispose<AddAddressController, Map<String, dynamic>>((ref) => AddAddressController());

class AddAddressController extends StateNotifier<Map<String, dynamic>> {
  AddAddressController()
      : super({
          'fullName': TextEditingController(),
          'country': TextEditingController(),
          'zone': '',
          'city': '',
          'address': TextEditingController(),
          'phoneNumber': TextEditingController(),
          'isDefault': false
        });

  @override
  void dispose() {
    state.forEach((key, controller) {
      if (key != 'isDefault' && key != 'city' && key != 'zone') {
        controller.dispose();
      }
    });
    super.dispose();
  }

  void setNameAndPhoneNumber(String name, String phoneNo) {
    state['fullName']!.text = name;
    state['phoneNumber']!.text = phoneNo;
  }

  void setFieldsValue(UserAddress userAddress) {
    state['fullName']!.text = userAddress.fullName;
    state['phoneNumber']!.text = userAddress.phoneNumber;
    state['country']!.text = userAddress.country;
    state['zone'] = userAddress.zone;
    state['city'] = userAddress.city;
    state['address']!.text = userAddress.address;
    state['isDefault'] = userAddress.isDefault;
  }

  void setCity(String city) {
    state = {...state, 'city': city};
  }

  void setZone(String zone) {
    state = {...state, 'zone': zone};
  }

  void setDefaultToggle(value) {
    state = {...state, 'isDefault': value};
  }

  Future<void> addNewAddress(GlobalKey<FormState> nameKey, WidgetRef ref) async {
    try {
      // Start Loading
      GLoadingScreen.openLoadingDialog(Get.context!);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        GLoadingScreen.stopLoading();
        return;
      }

      // Form Validation
      if (!nameKey.currentState!.validate()) {
        GLoadingScreen.stopLoading();
        return;
      }

      // Update user's first & last name in the Firebase Firestore
      final userController = ref.read(userControllerProvider.notifier);
      final userRepository = ref.read(userRepositoryProvider);
      final user = ref.read(userControllerProvider);

      final userAddresses = user.address;
      final bool wasListEmpty = userAddresses.isEmpty;

      if (state['isDefault'] == true) {
        for (var element in userAddresses) {
          element.isDefault = false;
        }
      }

      userAddresses.add(UserAddress(
          fullName: state['fullName']!.text,
          phoneNumber: state['phoneNumber']!.text,
          country: state['country']!.text,
          city: state['city']!,
          zone: state['zone']!,
          address: state['address']!.text,
          isDefault: wasListEmpty ? true : state['isDefault']!,
          id: (userAddresses.length + 1).toString()));

      Map<String, dynamic> addresses = {'Address': userAddresses.map((userAddress) => userAddress.toJson()).toList()};
      await userRepository.updateSingleField(addresses);

      // Update the Provider User Value
      userController.updateUserInfo(
        address: userAddresses,
      );
      // Remove Loader
      GLoadingScreen.stopLoading();

      // Show Success Message
      SnackBarPop.showSucessPopup(TextValue.operationSuccess, duration: 4);

      //Move to previous Screen
      Get.back();
    } catch (e) {
      SnackBarPop.showErrorPopup(e.toString(), duration: 4);
      GLoadingScreen.stopLoading();
    }
  }

  Future<void> updateAddress(GlobalKey<FormState> nameKey, WidgetRef ref, String oldId) async {
    try {
      // Start Loading
      GLoadingScreen.openLoadingDialog(Get.context!);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        GLoadingScreen.stopLoading();
        return;
      }

      // Form Validation
      if (!nameKey.currentState!.validate()) {
        GLoadingScreen.stopLoading();
        return;
      }

      // Update user's first & last name in the Firebase Firestore
      final userController = ref.read(userControllerProvider.notifier);
      final userRepository = ref.read(userRepositoryProvider);
      final user = ref.read(userControllerProvider);

      final userAddresses = user.address;
      final selectedIndex = userAddresses.indexWhere((element) => element.id == oldId);

      if (state['isDefault'] == true) {
        for (var element in userAddresses) {
          element.isDefault = false;
        }
      }

      userAddresses[selectedIndex] = UserAddress(
          fullName: state['fullName']!.text,
          phoneNumber: state['phoneNumber']!.text,
          country: state['country']!.text,
          city: state['city']!,
          zone: state['zone']!,
          address: state['address']!.text,
          isDefault: state['isDefault'],
          id: oldId);

      Map<String, dynamic> addresses = {'Address': userAddresses.map((userAddress) => userAddress.toJson()).toList()};
      await userRepository.updateSingleField(addresses);

      // Update the Provider User Value
      userController.updateUserInfo(
        address: userAddresses,
      );
      // Remove Loader
      GLoadingScreen.stopLoading();

      // Show Success Message
      SnackBarPop.showSucessPopup(TextValue.operationSuccess, duration: 4);

      //Move to previous Screen
      Get.back();
    } catch (e) {
      SnackBarPop.showErrorPopup(e.toString(), duration: 4);
      GLoadingScreen.stopLoading();
    }
  }
}
