import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpandController extends StateNotifier<bool> {
  ExpandController() : super(false);

  void toggle() => state = !state;
}
