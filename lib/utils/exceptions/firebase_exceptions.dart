import '../constants/text_values.dart';

/// Custom exception class to handle various Firebase-related errors.
class GFirebaseException implements Exception {
  /// The error code associated with the exception.
  final String code;

  /// Constructor that takes an error code.
  GFirebaseException(this.code);

  /// Get the corresponding error message based on the error code.
  String get message {
    switch (code) {
      case 'unknown':
        return TextValue.unknownError;
      case 'invalid-custom-token':
        return TextValue.invalidCustomToken;
      case 'custom-token-mismatch':
        return TextValue.customTokenMismatch;
      case 'user-disabled':
        return TextValue.userDisabled;
      case 'user-not-found':
        return TextValue.userNotFound;
      case 'invalid-email':
        return TextValue.invalidEmail;
      case 'email-already-in-use':
        return TextValue.emailAlreadyInUse;
      case 'wrong-password':
        return TextValue.wrongPassword;
      case 'weak-password':
        return TextValue.weakPassword;
      case 'provider-already-linked':
        return TextValue.providerAlreadyLinked;
      case 'operation-not-allowed':
        return TextValue.operationNotAllowed;
      case 'invalid-credential':
        return TextValue.invalidCredential;
      case 'invalid-verification-code':
        return TextValue.invalidVerificationCode;
      case 'invalid-verification-id':
        return TextValue.invalidVerificationId;
      case 'captcha-check-failed':
        return TextValue.captchaCheckFailed;
      case 'app-not-authorized':
        return TextValue.appNotAuthorized;
      case 'keychain-error':
        return TextValue.keychainError;
      case 'internal-error':
        return TextValue.internalError;
      case 'invalid-app-credential':
        return TextValue.invalidAppCredential;
      case 'user-mismatch':
        return TextValue.userMismatch;
      case 'requires-recent-login':
        return TextValue.requiresRecentLogin;
      case 'quota-exceeded':
        return TextValue.quotaExceeded;
      case 'account-exists-with-different-credential':
        return TextValue.accountExistsWithDifferentCredential;
      case 'missing-iframe-start':
        return TextValue.missingIframeStart;
      case 'missing-iframe-end':
        return TextValue.missingIframeEnd;
      case 'missing-iframe-src':
        return TextValue.missingIframeSrc;
      case 'auth-domain-config-required':
        return TextValue.authDomainConfigRequired;
      case 'missing-app-credential':
        return TextValue.missingAppCredential;
      case 'session-cookie-expired':
        return TextValue.sessionCookieExpired;
      case 'uid-already-exists':
        return TextValue.uidAlreadyExists;
      case 'web-storage-unsupported':
        return TextValue.webStorageUnsupported;
      case 'app-deleted':
        return TextValue.appDeleted;
      case 'user-token-mismatch':
        return TextValue.userTokenMismatch;
      case 'invalid-message-payload':
        return TextValue.invalidMessagePayload;
      case 'invalid-sender':
        return TextValue.invalidSender;
      case 'invalid-recipient-email':
        return TextValue.invalidRecipientEmail;
      case 'missing-action-code':
        return TextValue.missingActionCode;
      case 'user-token-expired':
        return TextValue.userTokenExpired;
      case 'INVALID_LOGIN_CREDENTIALS':
        return TextValue.invalidLoginCredentials;
      case 'expired-action-code':
        return TextValue.expiredActionCode;
      case 'invalid-action-code':
        return TextValue.invalidActionCode;
      case 'credential-already-in-use':
        return TextValue.credentialAlreadyInUse;
      default:
        return TextValue.unexpectedFirebaseError;
    }
  }
}
