import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';

class PTextField extends StatelessWidget {
  const PTextField(
      {super.key,
      this.title,
      this.textEditingController,
      this.isForm = false,
      this.validator,
      this.isPassword = false,
      this.obscureText = false,
      this.suffixicon,
      this.maxLines = 1,
      this.isEnabled = true,
      this.onShowPassword});

  final String? title;
  final TextEditingController? textEditingController;
  final bool isForm;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool obscureText;
  final Widget? suffixicon;
  final VoidCallback? onShowPassword;
  final int maxLines;
  final bool isEnabled;

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
                  maxLines: maxLines,
                  validator: validator,
                  controller: textEditingController,
                  cursorColor: ColorPalette.primary,
                  obscureText: obscureText,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    enabled: isEnabled,
                    suffixIcon: suffixicon,
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
                  maxLines: maxLines,
                  controller: textEditingController,
                  cursorColor: ColorPalette.primary,
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: InputDecoration(
                    enabled: isEnabled,
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