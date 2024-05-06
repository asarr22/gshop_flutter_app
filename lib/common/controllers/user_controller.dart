import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/repositories/user_repository.dart';
import 'package:gshopp_flutter/common/models/address/address_model.dart';
import 'package:gshopp_flutter/features/authentication/models/user_model.dart';
import 'package:gshopp_flutter/app.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends StateNotifier<UserModel> {
  final UserRepository userRepository;
  UserController(this.userRepository) : super(UserModel.empty()) {
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      final user = await userRepository.fetchUserDetails();
      state = user;
    } catch (e) {
      state = UserModel.empty();
    }
  }

  void updateUserInfo(
      {String? firstName,
      String? lastName,
      String? userName,
      String? email,
      String? phoneNumber,
      String? profilePicture,
      String? id,
      String? gender,
      String? birthday,
      List<UserAddress>? address}) {
    var newState = UserModel(
        id: id ?? state.id,
        firstName: firstName ?? state.firstName,
        lastName: lastName ?? state.lastName,
        username: userName ?? state.username,
        email: email ?? state.email,
        phoneNumber: phoneNumber ?? state.phoneNumber,
        profilePicture: profilePicture ?? state.profilePicture,
        gender: gender ?? state.gender,
        address: address ?? state.address,
        birthday: birthday ?? state.birthday);
    if (newState != state) {
      state = newState;
    }
  }

  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {
        final nameParts = UserModel.nameParts(userCredentials.user!.displayName ?? '');
        final username = UserModel.generateUsername(userCredentials.user!.displayName ?? '');

        final user = UserModel(
          id: userCredentials.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          username: username,
          email: userCredentials.user!.email ?? '',
          phoneNumber: userCredentials.user!.phoneNumber ?? '',
          profilePicture: userCredentials.user!.photoURL ?? '',
          gender: TextValue.undefined,
          birthday: TextValue.undefined,
          address: List.empty(),
        );

        await userRepository.saveUserRecord(user);
        state = user;
      }
    } catch (e) {
      SnackBarPop.showErrorPopup(TextValue.errorSavingProfileInfoMessage);
    }
  }

  // Upload user Image
  uploadProfileImage(WidgetRef ref) async {
    try {
      final image =
          await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 1024, maxWidth: 1024);
      final userController = ref.read(userControllerProvider.notifier);
      if (image != null) {
        final imgUrl = await userRepository.uploadImage("Users/Images/Profile/", image);

        //Update User Image Record
        Map<String, dynamic> json = {'ProfilePicture': imgUrl};
        await userRepository.updateSingleField(json);
        userController.updateUserInfo(profilePicture: imgUrl);

        // Send Success Message
        SnackBarPop.showSucessPopup(TextValue.operationSuccess, duration: 4);
      }
    } catch (e) {
      SnackBarPop.showErrorPopup(e.toString(), duration: 4);
    }
  }
}
