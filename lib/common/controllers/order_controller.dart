import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/app.dart';
import 'package:gshopp_flutter/common/firebase_services/order_repository.dart';
import 'package:gshopp_flutter/common/models/order/order_model.dart';
import 'package:gshopp_flutter/features/subviews/checkout_page/state/checkout_page_controller.dart';
import 'package:gshopp_flutter/features/subviews/checkout_page/success_order_page.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/helpers/network_manager.dart';
import 'package:gshopp_flutter/utils/popups/full_screen_loader.dart';
import 'package:gshopp_flutter/utils/popups/snackbar_popup.dart';

class OrderController extends StateNotifier<List<OrderModel>> {
  final OrderRepository _repository;
  Ref ref;
  OrderController(this._repository, this.ref) : super([]);

  Future<void> setOrder(OrderModel order, BuildContext context) async {
    // Start Loading
    PFullScreenLoader.openLoadingDialog(context);

    //Check Internet Connectivity
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      PFullScreenLoader.stopLoading();
      return;
    }

    final productRepository = ref.watch(productRepositoryProvider);

    // Check if Orders item has enough stock
    for (var item in order.orderItems) {
      var stock = await productRepository.getProductStockFromVariant(item.iD, item.color, item.size);
      if (item.quantity > stock) {
        PFullScreenLoader.stopLoading();
        SnackBarPop.showErrorPopup("${TextValue.itemOutOfStockErrorMessage} : ${item.name}", duration: 4);
        ref.read(localPaymentControllerProvider.notifier).dispose();
        ref.read(creditCardControllerProvider.notifier).dispose();
        Get.back();
        return;
      }
    }

    // Check Payment Method

    if (order.paymentMethod == 'Local Payment') {
      /// Retrieves Local Payment Information
      ///
      /// This utility leverages the `localPaymentControllerProvider` for accessing and managing local payment details. To fetch the required information, employ the following statement:
      /// ```
      /// final paymentInfo = ref.read(localPaymentControllerProvider);
      /// ```
      ///
      /// Payment details are stored within a `Map`, characterized by keys such as `name` and `phoneNumber`, facilitating the integration with local payment systems that necessitate a phone number for transaction processing.
      ///
      /// **Security Advisory:**
      /// Exercise caution in the handling of sensitive payment information. The `localPaymentControllerProvider` is designed with security measures, including disposal functions, to prevent unauthorized data access. It is imperative to execute the appropriate disposal methods after use to safeguard the privacy and security of payment data.
      ///
      /// Don't forget to get the transaction ID from the payment system after the transaction is complete. Store it in the order as paymentMethodCode
    }

    if (order.paymentMethod == 'Credit Card') {
      /// Retrieves Credit Card Information
      ///
      /// This method utilizes the `creditCardControllerProvider` to access and manage credit card details. To obtain the card information, use the following syntax:
      /// ```
      /// final cardInfo = ref.read(creditCardControllerProvider);
      /// ```
      ///
      /// The card information is encapsulated within a `Map`, with keys including `name`, `cardNumber`, `cvv`, and `expiryDate` formatted as MM/yy. This structured approach facilitates the integration with payment APIs, enabling seamless transaction processing.
      ///
      /// **Security Notice:**
      /// Ensure the secure handling of credit card details. The `creditCardControllerProvider` incorporates disposal mechanisms to mitigate data exposure risks. Invoke the appropriate disposal methods post-usage to maintain data integrity and confidentiality.
      ///
      /// Don't forget to get the transaction ID from the payment system after the transaction is complete. Store it in the order as paymentMethodCode
    }

    if (order.paymentMethod == 'Cash On Delivery') {
      order.paymentMethodCode = 'No Code';
    }

    // Set Order
    await _repository.addOrder(order);

    // Stop Loading
    PFullScreenLoader.stopLoading();

    // Navigate to Success Order Page
    Get.off(() => const SuccessOrderPage());
    try {} catch (e) {
      PFullScreenLoader.stopLoading();
      SnackBarPop.showErrorPopup(e.toString(), duration: 3);
    }
  }
}

final orderControllerProvider = StateNotifierProvider<OrderController, List<OrderModel>>(
  (ref) => OrderController(OrderRepository(ref), ref),
);