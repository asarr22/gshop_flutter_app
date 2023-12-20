import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarousleIndicatorControler extends StateNotifier<int> {
  CarousleIndicatorControler() : super(0);

  void updateIndicator(index) {
    state = index;
  }
}
