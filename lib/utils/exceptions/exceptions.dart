import '../constants/text_values.dart';

/// Classe d'exception pour gérer diverses erreurs.
class GExceptions implements Exception {
  /// Le message d'erreur associé.
  final String message;

  /// Constructeur par défaut avec un message d'erreur générique.
  const GExceptions([this.message = 'Une erreur inattendue s’est produite, veuillez réessayer.']);

  /// Crée une exception d'authentification à partir d'un code d'exception d'authentification Firebase.
  factory GExceptions.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const GExceptions(TextValue.emailAlreadyInUse);
      case 'invalid-email':
        return const GExceptions(TextValue.invalidEmail);
      case 'weak-password':
        return const GExceptions(TextValue.weakPassword);
      case 'user-disabled':
        return const GExceptions(TextValue.userDisabled);
      case 'user-not-found':
        return const GExceptions(TextValue.userNotFound);
      case 'wrong-password':
        return const GExceptions(TextValue.wrongPassword);
      case 'INVALID_LOGIN_CREDENTIALS':
        return const GExceptions(TextValue.invalidLoginCredentials);
      case 'too-many-requests':
        return const GExceptions(TextValue.tooManyRequests);
      case 'invalid-argument':
        return const GExceptions(TextValue.invalidArgument);
      case 'invalid-password':
        return const GExceptions(TextValue.invalidPassword);
      case 'invalid-phone-number':
        return const GExceptions(TextValue.invalidPhoneNumber);
      case 'operation-not-allowed':
        return const GExceptions(TextValue.operationNotAllowed);
      case 'session-cookie-expired':
        return const GExceptions(TextValue.sessionCookieExpired);
      case 'uid-already-exists':
        return const GExceptions(TextValue.uidAlreadyExists);
      case 'sign_in_failed':
        return const GExceptions(TextValue.signInFailed);
      case 'network-request-failed':
        return const GExceptions(TextValue.networkRequestFailed);
      case 'internal-error':
        return const GExceptions(TextValue.internalError);
      case 'invalid-verification-code':
        return const GExceptions(TextValue.invalidVerificationCode);
      case 'invalid-verification-id':
        return const GExceptions(TextValue.invalidVerificationId);
      case 'quota-exceeded':
        return const GExceptions(TextValue.quotaExceeded);
      default:
        return const GExceptions();
    }
  }
}
