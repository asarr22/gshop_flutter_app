import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginFormControllers
    extends StateNotifier<Map<String, TextEditingController>> {
  LoginFormControllers()
      : super({
          'email': TextEditingController(),
          'password': TextEditingController(),
        });

  @override
  void dispose() {
    state.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }
}
