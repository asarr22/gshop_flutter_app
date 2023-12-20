import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedIndex extends StateNotifier<int> {
  SelectedIndex() : super(-1);

  void select(int index) {
    state = index;
  }
}

class SelectedQuantity extends StateNotifier<int> {
  SelectedQuantity() : super(1);

  void increment() {
    if (state < 10) {
      state++;
    }
  }

  void decrement() {
    if (state > 1) {
      state--;
    }
  }
}
