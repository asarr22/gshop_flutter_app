import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPasswordVisibility extends StateNotifier<bool> {
  LoginPasswordVisibility() : super(true);

  void toggle() => state = !state;
}
