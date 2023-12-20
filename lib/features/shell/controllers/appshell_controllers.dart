import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
class AppShellController extends StateNotifier<int> {
  AppShellController() : super(0);

  void sendToIndex(int index) {
    state = index;
  }
}
