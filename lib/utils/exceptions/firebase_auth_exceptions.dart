import '../constants/text_values.dart';

class GFirebaseAuthException implements Exception {
  /// The error code associated with the exception.
  final String code;

  /// Constructor that takes an error code.
  GFirebaseAuthException(this.code);

  /// Get the corresponding error message based on the error code.
  String get message {
    switch (code) {
      case 'email-already-in-use':
        return TextValue.emailAlreadyExists;
      case 'invalid-email':
        return TextValue.invalidEmail;
      case 'weak-password':
        return TextValue.weakPassword;
      case 'user-disabled':
        return TextValue.userDisabled;
      case 'user-not-found':
        return TextValue.userNotFound;
      case 'wrong-password':
        return TextValue.wrongPassword;
      case 'invalid-verification-code':
        return TextValue.invalidVerificationCode;
      case 'invalid-verification-id':
        return TextValue.invalidVerificationId;
      case 'quota-exceeded':
        return TextValue.quotaExceeded;
      case 'provider-already-linked':
        return TextValue.providerAlreadyLinked;
      case 'requires-recent-login':
        return TextValue.requiresRecentLogin;
      case 'credential-already-in-use':
        return TextValue.credentialAlreadyInUse;
      case 'user-mismatch':
        return TextValue.userMismatch;
      case 'account-exists-with-different-credential':
        return TextValue.accountExistsWithDifferentCredential;
      case 'operation-not-allowed':
        return TextValue.operationNotAllowed;
      case 'expired-action-code':
        return TextValue.expiredActionCode;
      case 'invalid-action-code':
        return TextValue.invalidActionCode;
      case 'missing-action-code':
        return TextValue.missingActionCode;
      case 'user-token-expired':
        return TextValue.userTokenExpired;
      case 'invalid-credential':
        return TextValue.invalidCredential;
      case 'user-token-revoked':
        return TextValue.userTokenRevoked;
      case 'invalid-message-payload':
        return TextValue.invalidMessagePayload;
      case 'invalid-sender':
        return TextValue.invalidSender;
      case 'invalid-recipient-email':
        return TextValue.invalidRecipientEmail;
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
      case 'invalid-app-credential':
        return TextValue.invalidAppCredential;
      case 'session-cookie-expired':
        return TextValue.sessionCookieExpired;
      case 'uid-already-exists':
        return TextValue.uidAlreadyExists;
      case 'invalid-cordova-configuration':
        return TextValue.invalidCordovaConfiguration;
      case 'app-deleted':
        return TextValue.appDeleted;
      case 'user-token-mismatch':
        return TextValue.userTokenMismatch;
      case 'web-storage-unsupported':
        return TextValue.webStorageUnsupported;
      case 'app-not-authorized':
        return TextValue.appNotAuthorized;
      case 'keychain-error':
        return TextValue.keychainError;
      case 'internal-error':
        return TextValue.internalError;
      case 'INVALID_LOGIN_CREDENTIALS':
        return TextValue.invalidLoginCredentials;
      default:
        return TextValue.unexpectedAuthenticationError;
    }
  }
}
