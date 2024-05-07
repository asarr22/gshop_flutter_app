import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/common/controllers/user_controller.dart';
import 'package:gshopp_flutter/features/subviews/checkout_page/state/checkout_page_controller.dart';
import 'package:gshopp_flutter/utils/animations/custom_fade_animation.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/images_values.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/widgets/text_field_borderless.dart';
import 'package:gshopp_flutter/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';

// Define the possible payment methods
enum PaymentMethod {
  cashOnDelivery,
  localPayement,
  creditCard,
}

// Provider to manage the state of the selected payment method
final paymentMethodProvider = StateProvider.autoDispose<PaymentMethod>((ref) {
  return PaymentMethod.cashOnDelivery; // default payment method
});

class PaymentMethodScreen extends ConsumerWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PaymentMethod paymentMethod = ref.watch(paymentMethodProvider);
    final method = ref.watch(paymentMethodProvider);

    // Function to generate a random position for a circle
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: SizesValue.spaceBtwItems),
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              clipBehavior: Clip.antiAlias,
              constraints: const BoxConstraints(maxHeight: 180, minHeight: 170, maxWidth: 400, minWidth: 300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: method == PaymentMethod.creditCard
                      ? [Colors.orange, Colors.orangeAccent, Colors.deepOrange]
                      : method == PaymentMethod.localPayement
                          ? [Colors.blue, Colors.blueAccent]
                          : [Colors.green, Colors.greenAccent],
                ),
              ),
              child: Stack(
                children: [
                  if (paymentMethod == PaymentMethod.cashOnDelivery) ...[
                    Container(
                      color: Colors.transparent,
                      child: FadeTranslateAnimation(
                        delay: 500,
                        child: Center(
                          child: Image.asset(
                            ImagesValue.cashPayPicture,
                            color: Colors.white,
                            height: 80,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (paymentMethod == PaymentMethod.localPayement) ...[
                    SizedBox(
                      child: FadeTranslateAnimation(
                        delay: 500,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Center(
                              child: Image.asset(
                                ImagesValue.waveLogo,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 0,
                      left: 10,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Wave',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .apply(color: Colors.white, fontSizeFactor: 1.2, fontWeightDelta: 2),
                        ),
                      ),
                    ),
                  ],
                  if (paymentMethod == PaymentMethod.creditCard) ...[
                    Positioned(
                      bottom: 0,
                      right: 10,
                      child: SizedBox(
                        height: 70,
                        width: 70,
                        child: Image.asset(ImagesValue.visaLogo),
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      left: 10,
                      child: Text(
                        '1234  5678  9012  3456',
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                              fontSizeFactor: 1.4,
                              color: ColorPalette.extraLightGrayPlus,
                            ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Payment method buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: PaymentMethod.values.map((method) {
                return PaymentMethodButton(
                  method: method,
                  isSelected: paymentMethod == method,
                  onSelected: () {
                    ref.read(paymentMethodProvider.notifier).state = method;
                  },
                );
              }).toList(),
            ),

            // Fields that appear based on the selected payment method
            if (paymentMethod == PaymentMethod.cashOnDelivery) const CashOnDeliveryInfo(),
            if (paymentMethod == PaymentMethod.creditCard) const CreditCardFields(),
            if (paymentMethod == PaymentMethod.localPayement) const LocalPaymentFields(),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodButton extends StatelessWidget {
  final PaymentMethod method;
  final bool isSelected;
  final VoidCallback onSelected;

  const PaymentMethodButton({
    super.key,
    required this.method,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    dynamic icon;
    switch (method) {
      case PaymentMethod.cashOnDelivery:
        icon = Iconsax.moneys;
        break;
      case PaymentMethod.creditCard:
        icon = Iconsax.card;
        break;
      case PaymentMethod.localPayement:
        icon = ImagesValue.waveLogo;
        break;
    }

    return SizedBox(
      width: 70,
      child: IconButton(
        icon: icon is IconData
            ? Icon(icon, color: isSelected ? Colors.white : Colors.grey)
            : Image.asset(
                icon,
                height: 20,
              ),
        style: ElevatedButton.styleFrom(
          foregroundColor: isSelected ? Colors.white : Colors.black,
          backgroundColor: isSelected ? ColorPalette.primary : ColorPalette.extraLightGrayPlus,
          textStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onPressed: onSelected,
      ),
    );
  }
}

class CreditCardFields extends ConsumerWidget {
  const CreditCardFields({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(creditCardControllerProvider);
    // Add your Credit Card input fields here
    return Form(
      key: controller['formKey'],
      child: Column(children: [
        const SizedBox(height: 24),
        GTextField(
          title: TextValue.cardOwner,
          isForm: true,
          validator: (value) => PValidator.validateEmptyText(TextValue.name, value),
          textEditingController: controller['name'],
        ),
        const SizedBox(height: SizesValue.spaceBtwItems),
        GTextField(
          title: TextValue.cardNumber,
          isForm: true,
          validator: (value) => PValidator.validateEmail(value),
          keyboardType: TextInputType.number,
          textEditingController: controller['cardNumber'],
        ),
        const SizedBox(height: SizesValue.spaceBtwItems),
        Row(
          children: [
            Expanded(
              child: GTextField(
                title: TextValue.expiryDate,
                isForm: true,
                validator: (value) => PValidator.validateCardExpiryDate(value),
                keyboardType: TextInputType.number,
                textEditingController: controller['expiryDate'],
              ),
            ),
            const SizedBox(width: SizesValue.spaceBtwItems),
            Expanded(
              child: GTextField(
                title: TextValue.cvv,
                isForm: true,
                validator: (value) => PValidator.validateCVV(value),
                keyboardType: TextInputType.number,
                textEditingController: controller['cvv'],
              ),
            ),
          ],
        )
      ]),
    );
  }
}

class LocalPaymentFields extends ConsumerWidget {
  const LocalPaymentFields({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(localPaymentControllerProvider);
    final user = ref.watch(userControllerProvider);

    // Add your Local Payment input fields here
    return Form(
      key: controller['formKey'],
      child: Column(children: [
        const SizedBox(height: 24),
        GTextField(
          title: TextValue.name,
          isForm: true,
          validator: (value) => PValidator.validateEmptyText(TextValue.name, value),
          textEditingController: controller['name'],
        ),
        const SizedBox(height: SizesValue.spaceBtwItems),
        GTextField(
          title: TextValue.phoneNo,
          isForm: true,
          validator: (value) => PValidator.validatePhoneNumber(value),
          keyboardType: TextInputType.number,
          textEditingController: controller['phoneNumber'],
        ),
        const SizedBox(height: SizesValue.spaceBtwItems),
        Row(
          children: [
            Checkbox(
              value: controller['useAccountInfo'],
              onChanged: (bool? value) {
                ref
                    .read(localPaymentControllerProvider.notifier)
                    .toggleUseAccountInfo(value!, user.fullName, user.phoneNumber);
              },
            ),
            const SizedBox(width: 10),
            Text(
              TextValue.useMyAddressInfo,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
        const SizedBox(height: SizesValue.spaceBtwItems),
      ]),
    );
  }
}

class CashOnDeliveryInfo extends StatelessWidget {
  const CashOnDeliveryInfo({super.key});

  @override
  Widget build(BuildContext context) {
    // Add your Cash on Delivery information here
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Text(
            '${TextValue.payInCash} 💸',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: SizesValue.spaceBtwItems),
          Text(
            TextValue.payInCashMessage,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    ); // Placeholder for cash on delivery info
  }
}
