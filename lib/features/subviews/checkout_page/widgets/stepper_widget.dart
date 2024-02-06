import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:iconsax/iconsax.dart';

class StepperTile {
  final String title;
  final dynamic icon;
  final dynamic iconFilled;

  StepperTile({required this.title, required this.icon, this.iconFilled});
}

class StepperIndicator extends StatelessWidget {
  final int currentStep;

  const StepperIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final steppertiles = [
      StepperTile(title: TextValue.shipping, icon: Iconsax.dcube, iconFilled: Iconsax.dcube5),
      StepperTile(title: TextValue.payment, icon: Iconsax.card_tick_14, iconFilled: Iconsax.card_tick5),
      StepperTile(title: TextValue.confirmation, icon: Iconsax.clipboard_tick, iconFilled: Iconsax.clipboard_tick5),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Row(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 65,
                  height: 65,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          currentStep > index ? steppertiles[index].iconFilled : steppertiles[index].icon,
                          color: currentStep == index
                              ? ColorPalette.secondary
                              : currentStep > index
                                  ? ColorPalette.primary
                                  : Colors.grey,
                        ),
                        Text(steppertiles[index].title,
                            style: Theme.of(context).textTheme.labelSmall!.apply(
                                  color: currentStep == index
                                      ? ColorPalette.secondary
                                      : currentStep > index
                                          ? ColorPalette.primary
                                          : Colors.grey,
                                )),
                      ],
                    ),
                  ),
                ),
                if (index != 2)
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: 40,
                      height: 2,
                      color: currentStep == index
                          ? ColorPalette.secondary
                          : currentStep > index
                              ? ColorPalette.primary
                              : Colors.grey,
                    ),
                  ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
