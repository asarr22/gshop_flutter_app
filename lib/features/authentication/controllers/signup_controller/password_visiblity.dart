import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordVisibility extends StateNotifier<bool> {
  PasswordVisibility() : super(true);

  void toggle() => state = !state;
}
