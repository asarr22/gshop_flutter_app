import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentMethodController extends StateNotifier<Map<String, dynamic>> {
  PaymentMethodController()
      : super({
          'payment_method': '',
          'payment_data': '',
        });

  void setPaymentInfo(Map<String, dynamic>? data, String paymentMethod) {
    state = {...state, 'payment_method': paymentMethod, 'payment_data': data};
  }
}

final paymentMethodControllerProvider = StateNotifierProvider<PaymentMethodController, Map<String, dynamic>>((ref) {
  return PaymentMethodController();
});

class LocalPaymentController extends StateNotifier<Map<String, dynamic>> {
  LocalPaymentController()
      : super({
          'name': TextEditingController(),
          'phoneNumber': TextEditingController(),
          'useAccountInfo': false,
          'formKey': GlobalKey<FormState>(),
        });

  void toggleUseAccountInfo(bool value, name, phoneNumber) {
    if (value) {
      state['name'].text = name;
      state['phoneNumber'].text = phoneNumber;
    } else {
      state['name'].text = '';
      state['phoneNumber'].text = '';
    }

    state = {...state, 'useAccountInfo': value, 'name': state['name'], 'phoneNumber': state['phoneNumber']};
  }

  @override
  void dispose() {
    state['name'].dispose();
    state['phoneNumber'].dispose();
    super.dispose();
  }
}

final localPaymentControllerProvider =
    StateNotifierProvider.autoDispose<LocalPaymentController, Map<String, dynamic>>((ref) {
  return LocalPaymentController();
});

class CreditCardController extends StateNotifier<Map<String, dynamic>> {
  CreditCardController()
      : super({
          'name': TextEditingController(),
          'cardNumber': TextEditingController(),
          'expiryDate': TextEditingController(),
          'cvv': TextEditingController(),
          'formKey': GlobalKey<FormState>(),
        });
  @override
  void dispose() {
    state['name'].dispose();
    state['cardNumber'].dispose();
    state['expiryDate'].dispose();
    state['cvv'].dispose();
    super.dispose();
  }
}

final creditCardControllerProvider =
    StateNotifierProvider.autoDispose<CreditCardController, Map<String, dynamic>>((ref) {
  return CreditCardController();
});
