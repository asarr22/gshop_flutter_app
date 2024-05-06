import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';
import 'package:gshopp_flutter/utils/styles/borderless_text_field_decoration.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';

class PTextField extends StatelessWidget {
  const PTextField({
    super.key,
    this.title,
    this.textEditingController,
    this.isForm = false,
    this.validator,
    this.isPassword = false,
    this.obscureText = false,
    this.suffixicon,
    this.maxLines = 1,
    this.isEnabled = true,
    this.onShowPassword,
    this.keyboardType,
  });

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
  final TextInputType? keyboardType;

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
                  decoration: TextFieldStyles.borderless(isDarkMode),
                  keyboardType: keyboardType,
                )
              : TextField(
                  maxLines: maxLines,
                  controller: textEditingController,
                  cursorColor: ColorPalette.primary,
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: TextFieldStyles.borderless(isDarkMode),
                  keyboardType: keyboardType,
                ),
        ),
      ],
    );
  }
}
