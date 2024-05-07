import 'package:flutter/material.dart';
import 'package:gshopp_flutter/utils/constants/color_palette.dart';

class GTextField extends StatefulWidget {
  const GTextField({
    super.key,
    this.title,
    this.textEditingController,
    this.isForm = false,
    this.validator,
    this.isPassword = false,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines = 1,
    this.isEnabled = true,
    this.onChanged,
    this.labelText,
    this.keyboardType,
    this.hint,
  });

  final String? title;
  final String? hint;
  final String? labelText;
  final TextEditingController? textEditingController;
  final bool isForm;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int maxLines;
  final bool isEnabled;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;

  @override
  State<GTextField> createState() => _GTextFieldState();
}

class _GTextFieldState extends State<GTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) Text(widget.title!, style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: widget.isForm ? _buildTextFormField(isDarkMode) : _buildTextField(isDarkMode),
        ),
      ],
    );
  }

  Widget _buildTextField(bool isDarkMode) {
    return TextField(
      focusNode: _focusNode,
      maxLines: widget.maxLines,
      controller: widget.textEditingController,
      obscureText: widget.obscureText,
      cursorColor: ColorPalette.primary,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: _inputDecoration(isDarkMode),
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      enabled: widget.isEnabled,
    );
  }

  Widget _buildTextFormField(bool isDarkMode) {
    return TextFormField(
      focusNode: _focusNode,
      maxLines: widget.maxLines,
      validator: widget.validator,
      obscureText: widget.obscureText,
      controller: widget.textEditingController,
      cursorColor: ColorPalette.primary,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: _inputDecoration(isDarkMode),
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      enabled: widget.isEnabled,
    );
  }

  InputDecoration _inputDecoration(bool isDarkMode) {
    return InputDecoration(
      labelText: _isFocused ? null : widget.labelText,
      fillColor: isDarkMode ? ColorPalette.darkGrey : ColorPalette.extraLightGray,
      filled: true,
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorPalette.darkGrey, width: 0.0001),
          borderRadius: BorderRadius.circular(15)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorPalette.darkGrey, width: 0.0001),
          borderRadius: BorderRadius.circular(15)),
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.redAccent, width: 1), borderRadius: BorderRadius.circular(15)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.redAccent, width: 2), borderRadius: BorderRadius.circular(15)),
      contentPadding: const EdgeInsets.all(15.0),
      hintText: widget.hint,
      errorStyle: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.redAccent),
      hintStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
          color: isDarkMode ? ColorPalette.extraLightGray.withOpacity(0.9) : ColorPalette.darkGrey.withOpacity(0.9)),
      suffixIcon: widget.suffixIcon,
      prefixIcon: widget.prefixIcon,
    );
  }
}
