import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/features/subviews/product_details/product_detail_page.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';

class QuantitySelectionWidget extends StatelessWidget {
  const QuantitySelectionWidget({
    super.key,
    required this.ref,
    required this.selectedQuantityValue,
  });

  final WidgetRef ref;
  final int selectedQuantityValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorPalette.secondary,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            TextValue.quantitie,
            style: Theme.of(context).textTheme.displayMedium!.apply(color: Colors.black),
          ),
          Row(
            children: [
              SizedBox(
                height: 55,
                width: 55,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(quantityProvider.notifier).decrement();
                  },
                  child: Text('-', style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.white)),
                ),
              ),
              SizedBox(
                height: 55,
                width: 50,
                child: Center(
                    child: Text(selectedQuantityValue.toString(),
                        style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.black))),
              ),
              SizedBox(
                height: 55,
                width: 55,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(quantityProvider.notifier).increment();
                  },
                  child: Text('+', style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
