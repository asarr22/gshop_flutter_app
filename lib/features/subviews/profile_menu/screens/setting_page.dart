import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/utils/animations/custom_fade_animation.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/constants/sizes_values.dart';
import 'package:gshopp_flutter/utils/constants/text_values.dart';
import 'package:gshopp_flutter/utils/formatters/value_formater.dart';
import 'package:gshopp_flutter/utils/widgets/rounded_container.dart';
import 'package:gshopp_flutter/utils/styles/shadow.dart';
import 'package:gshopp_flutter/utils/theme/theme_mode.dart';
import 'package:iconsax/iconsax.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final themeMode = ref.watch(themeModeProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_24),
          onPressed: () => Get.back(),
        ),
        title: Text(
          TextValue.settings,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizesValue.padding),
          child: Column(
            children: [
              const SizedBox(height: 20),
              themeOption(isDarkMode, context, themeMode, ref),
            ],
          ),
        ),
      ),
    );
  }

  FadeTranslateAnimation themeOption(bool isDarkMode, BuildContext context, AppThemeMode themeMode, WidgetRef ref) {
    return FadeTranslateAnimation(
      delay: 300,
      child: RoundedContainer(
        backgroundColor: isDarkMode ? const Color.fromARGB(255, 71, 66, 59) : ColorPalette.extraLightGrayPlus,
        boxShadow: [ShadowStyle.tileListShadow],
        child: SizedBox(
          height: 60,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  TextValue.theme,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Center(
                  child: DropdownButton<AppThemeMode>(
                    icon: const Icon(Iconsax.arrow_down_1, color: ColorPalette.primary),
                    iconSize: 20,
                    style: Theme.of(context).textTheme.labelLarge!.apply(color: ColorPalette.primary),
                    underline: Container(),
                    elevation: 16,
                    value: themeMode,
                    onChanged: (AppThemeMode? newValue) {
                      if (newValue != null) {
                        ref.read(themeModeProvider.notifier).setThemeMode(newValue);
                      }
                    },
                    items: AppThemeMode.values.map((AppThemeMode mode) {
                      var modeName = mode.toString().split('.').last; // Extracts enum value name
                      return DropdownMenuItem<AppThemeMode>(
                        value: mode,
                        child: Text(Formatter.capitalizeFirstLetter(
                            modeName)), // Assuming Formatter.capitalizeFirstLetter is implemented
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
