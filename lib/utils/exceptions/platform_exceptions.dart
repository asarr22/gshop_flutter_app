import '../constants/text_values.dart';

/// Exception class for handling various platform-related errors.
class GPlatformException implements Exception {
  final String code;

  GPlatformException(this.code);

  String get message {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return TextValue.invalidLoginCredentials;
      case 'too-many-requests':
        return TextValue.tooManyRequests;
      case 'invalid-argument':
        return TextValue.invalidArgument;
      case 'invalid-password':
        return TextValue.incorrectPassword;
      case 'invalid-phone-number':
        return TextValue.invalidPhoneNumber;
      case 'operation-not-allowed':
        return TextValue.operationNotAllowed;
      case 'session-cookie-expired':
        return TextValue.sessionCookieExpired;
      case 'uid-already-exists':
        return TextValue.uidAlreadyExists;
      case 'sign_in_failed':
        return TextValue.signInFailed;
      case 'network-request-failed':
        return TextValue.networkRequestFailed;
      case 'internal-error':
        return TextValue.internalError;
      case 'invalid-verification-code':
        return TextValue.invalidVerificationCode;
      case 'invalid-verification-id':
        return TextValue.invalidVerificationId;
      case 'quota-exceeded':
        return TextValue.quotaExceeded;
      default:
        return TextValue.unexpectedPlatformError;
    }
  }
}
