import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrivacyPolicyAndTerm extends StateNotifier<bool> {
  PrivacyPolicyAndTerm() : super(false);

  void toggle() => state = !state;
}
