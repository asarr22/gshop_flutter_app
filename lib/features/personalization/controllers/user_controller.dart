import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/firebase_services/user_repository.dart';
import 'package:gshopp_flutter/features/authentication/models/user_Model.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';

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
      {String? firstName, String? lastName, String? userName, String? email, String? phoneNumber, String? profilePicture, String? id}) {
    state = UserModel(
      id: id ?? state.id,
      firstName: firstName ?? state.firstName,
      lastName: lastName ?? state.lastName,
      username: userName ?? state.username,
      email: email ?? state.email,
      phoneNumber: phoneNumber ?? state.phoneNumber,
      profilePicture: profilePicture ?? state.profilePicture,
    );
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
        );

        await userRepository.saveUserRecord(user);
        state = user;
      }
    } catch (e) {
      SnackBarPop.showErrorPopup(TextValue.errorSavingProfileInfoMessage);
    }
  }
}
