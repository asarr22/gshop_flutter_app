import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangePasswordVisiblity extends StateNotifier<Map<String, bool>> {
  ChangePasswordVisiblity() : super({"oldPassword": true, "newPassword": true, "newPasswordConfirm": true});
  void toggle(String key) {
    state = {
      ...state,
      key: !state[key]!,
    };
  }
}
