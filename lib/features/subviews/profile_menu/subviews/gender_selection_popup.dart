import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/controllers/change_gender_controller.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';

final genderProvider = StateNotifierProvider<ChangeGenderController, String>((ref) => ChangeGenderController());

class GenderSelect {
  static void showPicker(BuildContext context, WidgetRef ref) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isDarkMode ? ColorPalette.backgroundDark : ColorPalette.backgroundLight,
          ),
          padding: const EdgeInsets.all(10),
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Text(
                  TextValue.selectAndOption,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  backgroundColor: isDarkMode ? ColorPalette.backgroundDark : ColorPalette.backgroundLight,
                  onSelectedItemChanged: (value) {
                    ref.read(genderProvider.notifier).setValue(value == 0 ? 'Male' : 'Female');
                  },
                  itemExtent: 50.0,
                  children: [
                    Center(
                      child: Text(
                        'Male',
                        style: Theme.of(context).textTheme.labelLarge!.apply(fontSizeDelta: 2),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Female',
                        style: Theme.of(context).textTheme.labelLarge!.apply(fontSizeDelta: 2),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      TextValue.cancel,
                      style: Theme.of(context).textTheme.bodyLarge!.apply(color: ColorPalette.primary, fontWeightDelta: 2),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.read(genderProvider.notifier).updateGender(ref);
                    },
                    child: Text(
                      TextValue.submit,
                      style: Theme.of(context).textTheme.bodyLarge!.apply(color: ColorPalette.primary, fontWeightDelta: 2),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
