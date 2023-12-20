/// Classe d'exception pour gérer diverses erreurs.
class TExceptions implements Exception {
  /// Le message d'erreur associé.
  final String message;

  /// Constructeur par défaut avec un message d'erreur générique.
  const TExceptions(
      [this.message =
          'Une erreur inattendue s’est produite, veuillez réessayer.']);

  /// Crée une exception d'authentification à partir d'un code d'exception d'authentification Firebase.
  factory TExceptions.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const TExceptions(
            'L’adresse e-mail est déjà enregistrée. Veuillez utiliser une autre adresse e-mail.');
      case 'invalid-email':
        return const TExceptions(
            'L’adresse e-mail fournie est invalide. Veuillez entrer une adresse e-mail valide.');
      case 'weak-password':
        return const TExceptions(
            'Le mot de passe est trop faible. Veuillez choisir un mot de passe plus fort.');
      case 'user-disabled':
        return const TExceptions(
            'Ce compte utilisateur a été désactivé. Veuillez contacter l’assistance pour obtenir de l’aide.');
      case 'user-not-found':
        return const TExceptions(
            'Détails de connexion non valides. Utilisateur introuvable.');
      case 'wrong-password':
        return const TExceptions(
            'Mot de passe incorrect. Veuillez vérifier votre mot de passe et réessayer.');
      case 'INVALID_LOGIN_CREDENTIALS':
        return const TExceptions(
            'Identifiants de connexion non valides. Veuillez vérifier vos informations.');
      case 'too-many-requests':
        return const TExceptions(
            'Trop de demandes. Veuillez réessayer plus tard.');
      case 'invalid-argument':
        return const TExceptions(
            'Argument invalide fourni à la méthode d\'authentification.');
      case 'invalid-password':
        return const TExceptions('Mot de passe incorrect. Veuillez réessayer.');
      case 'invalid-phone-number':
        return const TExceptions('Le numéro de téléphone fourni est invalide.');
      case 'operation-not-allowed':
        return const TExceptions(
            'Le fournisseur de connexion est désactivé pour votre projet Firebase.');
      case 'session-cookie-expired':
        return const TExceptions(
            'Le cookie de session Firebase a expiré. Veuillez vous reconnecter.');
      case 'uid-already-exists':
        return const TExceptions(
            'L’ID utilisateur fourni est déjà utilisé par un autre utilisateur.');
      case 'sign_in_failed':
        return const TExceptions('La connexion a échoué. Veuillez réessayer.');
      case 'network-request-failed':
        return const TExceptions(
            'La demande réseau a échoué. Veuillez vérifier votre connexion internet.');
      case 'internal-error':
        return const TExceptions(
            'Erreur interne. Veuillez réessayer plus tard.');
      case 'invalid-verification-code':
        return const TExceptions(
            'Code de vérification invalide. Veuillez entrer un code valide.');
      case 'invalid-verification-id':
        return const TExceptions(
            'ID de vérification invalide. Veuillez demander un nouveau code de vérification.');
      case 'quota-exceeded':
        return const TExceptions(
            'Quota dépassé. Veuillez réessayer plus tard.');
      default:
        return const TExceptions();
    }
  }
}
