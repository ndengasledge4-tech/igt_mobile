abstract final class Validators {
  const Validators._();

  static String? requiredText(String? value, {required String fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName est obligatoire.';
    }

    return null;
  }

  static String? name(String? value, {required String fieldName}) {
    final requiredError = requiredText(value, fieldName: fieldName);

    if (requiredError != null) {
      return requiredError;
    }

    if (value!.trim().length < 2) {
      return '$fieldName doit contenir au moins 2 caractères.';
    }

    return null;
  }

  static String? email(String? value) {
    final requiredError = requiredText(value, fieldName: 'L’email');

    if (requiredError != null) {
      return requiredError;
    }

    final pattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

    if (!pattern.hasMatch(value!.trim())) {
      return 'Saisissez une adresse email valide.';
    }

    return null;
  }

  static String? phone(String? value) {
    final requiredError = requiredText(value, fieldName: 'Le téléphone');

    if (requiredError != null) {
      return requiredError;
    }

    final compact = value!.replaceAll(RegExp(r'[\s().-]'), '');

    if (!RegExp(r'^\+?[0-9]{8,15}$').hasMatch(compact)) {
      return 'Saisissez un numéro de téléphone valide.';
    }

    return null;
  }

  static String? matricule(String? value) {
    final requiredError = requiredText(
      value,
      fieldName: 'L’identifiant étudiant',
    );

    if (requiredError != null) {
      return requiredError;
    }

    if (!RegExp(r'^[A-Za-z0-9-]{4,30}$').hasMatch(value!.trim())) {
      return 'Utilisez 4 à 30 lettres, chiffres ou tirets.';
    }

    return null;
  }

  static String? password(String? value) {
    final requiredError = requiredText(value, fieldName: 'Le mot de passe');

    if (requiredError != null) {
      return requiredError;
    }

    final password = value!;

    if (password.length < 8) {
      return 'Utilisez au moins 8 caractères.';
    }

    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Ajoutez au moins une lettre majuscule.';
    }

    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Ajoutez au moins une lettre minuscule.';
    }

    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Ajoutez au moins un chiffre.';
    }

    return null;
  }

  static String? passwordConfirmation(String? value, String password) {
    final requiredError = requiredText(value, fieldName: 'La confirmation');

    if (requiredError != null) {
      return requiredError;
    }

    if (value != password) {
      return 'Les mots de passe ne correspondent pas.';
    }

    return null;
  }
}
