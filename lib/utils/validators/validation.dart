import 'package:gshopp_flutter/utils/constants/text_values.dart';

class PValidator {
  ///EmptyValidator
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return TextValue.isRequiredField;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return TextValue.emailIsRequired;
    }
// Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return TextValue.invalidEmail;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return TextValue.passwordIsRequired;
    }

    // Check for minimum password length
    if (value.length < 6) {
      return TextValue.passwordMorethan6;
    }
    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return TextValue.passwordMustContainOneUppercase;
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return TextValue.passwordMustContainOneNumber;
    }
    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(), .? ":{}|<>]'))) {
      return TextValue.passwordMustContainOneSpecialCharacter;
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return TextValue.phoneNumberIsRequired;
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r'^\d{9}$');

    if (!phoneRegExp.hasMatch(value)) {
      return TextValue.invalidPhoneNumber;
    }
    return null;
  }

  // Validate VISACard
  static String? validateVisaCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'Numéro de carte de crédit est nessesaire.';
    }

    RegExp visaRegex = RegExp(r'^4[0-9]{12}(?:[0-9]{3})?$');
    if (!visaRegex.hasMatch(value)) {
      return "Invalid Visa card number";
    }
    int sum = 0;
    for (int i = 0; i < value.length; i++) {
      int digit = int.parse(value[i]);
      if (i % 2 == 0) {
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }
      sum += digit;
    }
    if (sum % 10 != 0) {
      return "Invalid Visa card number";
    }

    return null;
  }

  // Validate CVV
  static validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return 'CVV est nessesaire.';
    }

    RegExp visaRegex = RegExp(r'^[0-9]{3,4}$');
    if (!visaRegex.hasMatch(value)) {
      return "Invalid CVV";
    }

    return null;
  }

  // Validate Expiry Date in form of MM/YY
  static validateCardExpiryDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date d\'expiration est nessesaire.';
    }

    RegExp visaRegex = RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{4}|[0-9]{2})$');
    if (!visaRegex.hasMatch(value)) {
      return "Invalid Expiry Date";
    }

    return null;
  }
}
