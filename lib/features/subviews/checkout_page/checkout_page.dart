import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/controllers/app_parameters_controller.dart';
import 'package:gshopp_flutter/common/controllers/order_controller.dart';
import 'package:gshopp_flutter/common/controllers/user_cart_controller.dart';
import 'package:gshopp_flutter/common/controllers/user_controller.dart';
import 'package:gshopp_flutter/common/models/order/order_model.dart';
import 'package:gshopp_flutter/features/subviews/checkout_page/widgets/order_review_screen.dart';
import 'package:gshopp_flutter/features/subviews/checkout_page/widgets/payment_method_screen.dart';
import 'package:gshopp_flutter/features/subviews/checkout_page/state/checkout_page_controller.dart';
import 'package:gshopp_flutter/features/subviews/checkout_page/widgets/stepper_widget.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/screens/address_list.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/formatters/value_formater.dart';
import 'package:iconsax/iconsax.dart';

final stepperProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

class CheckoutPage extends ConsumerWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = PageController();
    final currentStep = ref.watch(stepperProvider);

    void onStepContinue() {
      if (currentStep < 2) {
        // Check if payment info is valid and Store it
        if (currentStep == 1) {
          if (!getPaymentInfo(ref)) {
            return;
          }
        }
        pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      } else if (currentStep == 2) {
        // Build Order
        buildOrder(ref, context);
      }
    }

    void onStepCancel() {
      if (currentStep > 0) {
        pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    }

    void onPageChanged(int page) {
      ref.read(stepperProvider.notifier).state = page;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_24),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          TextValue.orderVerification,
        ),
      ),
      body: Column(
        children: [
          // Step Indicator Widget
          StepperIndicator(currentStep: currentStep),

          // Page View Widget
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: onPageChanged,
              children: [
                // Address List Widget
                Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
                  child: SizedBox(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: SizesValue.defaultSpace),
                      Text(TextValue.selectAddress, style: Theme.of(context).textTheme.displayMedium),
                      const SizedBox(height: SizesValue.defaultSpace),
                      const AddressListWidget(),
                    ],
                  )),
                )),

                // Payment Method Widget
                const Center(
                  child: SizedBox(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: SizesValue.padding),
                      child: PaymentMethodScreen(),
                    ),
                  ),
                ),

                // Order Review Widget
                const OrderReviewScreen(),
              ],
            ),
          ),

          // Continue and Cancel buttons here
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding, vertical: SizesValue.padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 60,
                    child: TextButton(
                      onPressed: onStepCancel,
                      child: const Text(TextValue.previous),
                    ),
                  ),
                ),
                const SizedBox(width: SizesValue.defaultSpace),
                Expanded(
                  child: SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: onStepContinue,
                      child: Text(currentStep == 2 ? TextValue.confirm : TextValue.next),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool getPaymentInfo(WidgetRef ref) {
    final paymentMethod = ref.watch(paymentMethodProvider);

    if (paymentMethod == PaymentMethod.creditCard) {
      final creditInfo = ref.watch(creditCardControllerProvider);

      // Check if credit info is valid
      if (!creditInfo['formKey'].currentState!.validate()) {
        return false;
      }
      ref.read(paymentMethodControllerProvider.notifier).setPaymentInfo(creditInfo, paymentMethod.name);
    } else if (paymentMethod == PaymentMethod.localPayement) {
      final localInfo = ref.watch(localPaymentControllerProvider);

      // Check if local info is valid
      if (!localInfo['formKey'].currentState!.validate()) {
        return false;
      }
      ref.read(paymentMethodControllerProvider.notifier).setPaymentInfo(localInfo, paymentMethod.name);
    } else {
      if (kDebugMode) {
        print("Payment method : $paymentMethod");
      }
      ref.read(paymentMethodControllerProvider.notifier).setPaymentInfo(null, paymentMethod.name);
    }
    return true;
  }

  double userShippingFee(WidgetRef ref) {
    try {
      final user = ref.watch(userControllerProvider);
      final appParameter = ref.watch(appControllerProvider);
      final cities = appParameter['shippingFee'];
      final defaultAddress = user.address.isEmpty ? null : user.address.singleWhere((element) => element.isDefault);
      final userCity = cities.singleWhere((element) => element.name == defaultAddress?.city);
      final userZone = userCity.zones.singleWhere((element) => element.name == defaultAddress?.zone);
      return userZone.shippingFee;
    } catch (e) {
      return 0;
    }
  }

  void buildOrder(WidgetRef ref, context) {
    final cartItems = ref.watch(userCartControllerProvider);
    final user = ref.watch(userControllerProvider);

    // Get Total Brute
    double totalBrute =
        cartItems.isEmpty ? 0 : cartItems.map((e) => e.productPrice * e.quantity).reduce((a, b) => a + b).toDouble();

    // Get Shipping Fee
    double shippingFee = userShippingFee(ref);

    // Get Coupon Discount
    double couponDiscount = 0;

    // Get Default Address from user
    final defaultAddress = user.address.firstWhere((element) => element.isDefault == true);

    // Get Total Net
    double totalNet = totalBrute + shippingFee - couponDiscount;

    // Get Order Items
    List<OrderItems> orderItems = [];
    String title = "";
    for (var item in cartItems) {
      title += "${item.productName}, ";
      orderItems.add(OrderItems(
          name: item.productName,
          image: item.productImage,
          price: item.productPrice.toDouble(),
          quantity: item.quantity,
          size: item.size,
          iD: item.productId,
          color: item.color));
    }
    title = title.substring(0, title.length - 2);

    // Order Date
    String orderDate = Formatter.getFormattedDateTime('dd/MM/yyyy');
    String orderTime = Formatter.getFormattedDateTime('HH:mm');

    // Order ETA , 3 days from now
    DateTime etaDateTime = DateTime.now().add(const Duration(days: 3));
    String orderETA = Formatter.getFormattedDateTime('dd/MM/yyyy', dateTime: etaDateTime);

    // Order ID
    String orderID = Formatter.getFormattedDateTime('ddMMyyyyHHmmss');

    // Payment Method
    var paymentMethod = ref.watch(paymentMethodControllerProvider)['payment_method'];

    if (paymentMethod == 'cashOnDelivery') {
      paymentMethod = 'Cash';
    } else if (paymentMethod == 'creditCard') {
      paymentMethod = 'Credit Card';
    } else if (paymentMethod == 'localPayment') {
      paymentMethod = 'Local Payment';
    }

    // User Address
    String userAddress =
        '${defaultAddress.address}, ${defaultAddress.city}, ${defaultAddress.zone}, ${defaultAddress.country}, ${defaultAddress.fullName}, ${defaultAddress.phoneNumber}';

    // Build Order
    OrderModel order = OrderModel(
        couponValue: couponDiscount,
        title: title,
        orderDate: orderDate,
        orderETA: orderETA,
        orderID: orderID,
        orderItems: orderItems,
        orderDateStatus: [orderDate, '', '', ''],
        orderTimeStatus: [orderTime, '', '', ''],
        orderStatus: 0,
        paymentMethod: paymentMethod,
        paymentMethodCode: '',
        totalAmount: totalNet,
        userAddress: userAddress,
        userID: user.id,
        username: user.fullName,
        deliveryFee: shippingFee.toInt(),
        userPhone: user.phoneNumber);

    // Set Order
    ref.read(orderControllerProvider.notifier).setOrder(order, context);
  }
}
