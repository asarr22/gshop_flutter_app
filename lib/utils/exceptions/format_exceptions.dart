import '../constants/text_values.dart';

/// Custom exception class to handle various format-related errors.
class GFormatException implements Exception {
  /// The associated error message.
  final String message;

  /// Default constructor with a generic error message.
  const GFormatException([this.message = 'An unexpected format error occurred. Please check your input.']);

  /// Create a format exception from a specific error message.
  factory GFormatException.fromMessage(String message) {
    return GFormatException(message);
  }

  /// Get the corresponding error message.
  String get formattedMessage => message;

  /// Create a format exception from a specific error code.
  factory GFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const GFormatException(TextValue.invalidEmailFormat);
      case 'invalid-phone-number-format':
        return const GFormatException(TextValue.invalidPhoneNumberFormat);
      case 'invalid-date-format':
        return const GFormatException(TextValue.invalidDateFormat);
      case 'invalid-url-format':
        return const GFormatException(TextValue.invalidUrlFormat);
      case 'invalid-credit-card-format':
        return const GFormatException(TextValue.invalidCreditCardFormat);
      case 'invalid-numeric-format':
        return const GFormatException(TextValue.invalidNumericFormat);
      default:
        return const GFormatException();
    }
  }
}
