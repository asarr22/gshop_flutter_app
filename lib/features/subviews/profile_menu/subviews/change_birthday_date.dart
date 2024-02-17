import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/controllers/change_birthday_controller.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';
import 'package:intl/intl.dart';

final birthdaychangeProvider =
    StateNotifierProvider<ChangeBirthdayController, String>((ref) => ChangeBirthdayController());

class BirthDateSelection {
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
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Text(
                  TextValue.selectAnOption,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  dateOrder: DatePickerDateOrder.dmy,
                  onDateTimeChanged: (value) {
                    ref.read(birthdaychangeProvider.notifier).setValue(DateFormat('dd/MM/yyyy').format(value));
                  },
                  initialDateTime: DateTime(2010),
                  minimumYear: 1945,
                  maximumYear: 2011,
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
                      style:
                          Theme.of(context).textTheme.bodyLarge!.apply(color: ColorPalette.primary, fontWeightDelta: 2),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.read(birthdaychangeProvider.notifier).updateDate(ref);
                    },
                    child: Text(
                      TextValue.submit,
                      style:
                          Theme.of(context).textTheme.bodyLarge!.apply(color: ColorPalette.primary, fontWeightDelta: 2),
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
