class RegistrationException implements Exception {
  const RegistrationException({required this.code, required this.userMessage});

  final String code;
  final String userMessage;

  @override
  String toString() => 'RegistrationException($code)';
}
