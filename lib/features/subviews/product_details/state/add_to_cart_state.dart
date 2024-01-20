import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddToCartButtonState extends StateNotifier<bool> {
  AddToCartButtonState() : super(false);

  void toggle() {
    state = !state;
  }
}

final addToCartButtonStateProvider = StateNotifierProvider<AddToCartButtonState, bool>((ref) => AddToCartButtonState());
