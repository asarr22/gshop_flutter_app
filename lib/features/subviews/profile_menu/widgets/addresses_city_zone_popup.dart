import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/common/controllers/app_parameters_controller.dart';
import 'package:gshopp_flutter/common/models/address/shipping_model.dart';
import 'package:gshopp_flutter/features/subviews/profile_menu/controllers/change_address_controller.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';

class CityZoneSelectionPopup {
  static void showPicker(BuildContext context, WidgetRef ref,
      {bool isCity = false, bool isZone = true, String userCity = ''}) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    final appController = ref.watch(appControllerProvider);

    List<dynamic> cities = appController['shippingFee'];
    String? selectedCity = cities[0].name;

    List<Zone> zones = [];
    for (var item in cities) {
      if (item.name == userCity) {
        zones = item.zones;
      }
    }

    // Make City Widget List
    List<Center> cityList = [];
    for (var city in cities) {
      cityList.add(
        Center(
          child: Text(
            city.name,
            style: Theme.of(context).textTheme.labelLarge!.apply(fontSizeDelta: 2),
          ),
        ),
      );
    }

    // Make Zone Widget List
    List<Center> zoneList = [];
    for (var zone in zones) {
      zoneList.add(
        Center(
          child: Text(
            zone.name,
            style: Theme.of(context).textTheme.labelLarge!.apply(fontSizeDelta: 2),
          ),
        ),
      );
    }
    String? selectedZone = zones.isEmpty ? "" : zones[0].name;

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
                  TextValue.selectAnOption,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  backgroundColor: isDarkMode ? ColorPalette.backgroundDark : ColorPalette.backgroundLight,
                  onSelectedItemChanged: (value) {
                    if (isCity) {
                      selectedCity = cities[value].name;
                    }
                    if (isZone) {
                      selectedZone = zones[value].name;
                    }
                  },
                  itemExtent: 50.0,
                  children: [
                    if (isCity) ...cityList,
                    if (isZone) ...zoneList,
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
                      style:
                          Theme.of(context).textTheme.bodyLarge!.apply(color: ColorPalette.primary, fontWeightDelta: 2),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (isCity) {
                        ref.read(addressFieldControllerProvider.notifier).setCity(selectedCity!);
                        Get.back();
                      }
                      if (isZone) {
                        ref.read(addressFieldControllerProvider.notifier).setZone(selectedZone!);
                        Get.back();
                      }
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
