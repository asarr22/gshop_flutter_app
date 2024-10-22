import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/repositories/app_parameters_repository.dart';

class AppController extends StateNotifier<Map<String, dynamic>> {
  final AppRepository _repository;
  AppController(this._repository)
      : super({
          'shippingFee': [],
          'promoEvent': [],
        }) {
    getShippmentData();
  }

  Future<void> getShippmentData() async {
    state = {
      ...state,
      'shippingFee': await _repository.getShippmentData(),
    };
  }
}

final appControllerProvider = StateNotifierProvider<AppController, Map<String, dynamic>>(
  (ref) => AppController(AppRepository()),
);
