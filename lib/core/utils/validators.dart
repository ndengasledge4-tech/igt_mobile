class Validators {
  Validators._();

  static String? requiredField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ce champ est obligatoire';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'L\'email est obligatoire';
    }

    final emailRegex = RegExp(
      r'^[\w\.-]+@[\w\.-]+\.\w+$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Entrez une adresse email valide';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le mot de passe est obligatoire';
    }

    if (value.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Le numéro de téléphone est obligatoire';
    }

    if (value.trim().length < 8) {
      return 'Entrez un numéro de téléphone valide';
    }

    return null;
  }
}
