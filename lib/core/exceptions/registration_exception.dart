class RegistrationException implements Exception {
  final String message;

  const RegistrationException(this.message);

  @override
  String toString() => message;
}