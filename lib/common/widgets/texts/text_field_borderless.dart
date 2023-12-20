import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';

class PTextField extends StatelessWidget {
  const PTextField({super.key, this.title, this.textEditingController, this.isForm = false, this.validator});

  final String? title;
  final TextEditingController? textEditingController;
  final bool isForm;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: isForm
              ? TextFormField(
                  validator: validator,
                  controller: textEditingController,
                  cursorColor: ColorPalette.primary,
                  decoration: InputDecoration(
                    fillColor: isDarkMode ? ColorPalette.darkGrey : ColorPalette.extraLightGray,
                    filled: true,
                    contentPadding: const EdgeInsets.all(15.0),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                )
              : TextField(
                  controller: textEditingController,
                  cursorColor: ColorPalette.primary,
                  decoration: InputDecoration(
                    fillColor: isDarkMode ? ColorPalette.darkGrey : ColorPalette.extraLightGray,
                    filled: true,
                    contentPadding: const EdgeInsets.all(15.0),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
