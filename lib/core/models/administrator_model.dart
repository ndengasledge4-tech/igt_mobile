class AdministratorModel {
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String? campusId;
  final String status;

  const AdministratorModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    this.campusId,
    required this.status,
  });

  Map<String, dynamic> toMap({required String uid}) {
    return {
      'uid': uid,
      'firstName': firstName.trim(),
      'lastName': lastName.trim(),
      'fullName': '${firstName.trim()} ${lastName.trim()}',
      'email': email.trim().toLowerCase(),
      'role': role,
      'campusId': campusId,
      'status': status,
    };
  }
}