class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String role;
  final String status;

  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.role,
    required this.status,
  });

  Map<String, dynamic> toMap({required String uid}) {
    return {
      'uid': uid,
      'firstName': firstName.trim(),
      'lastName': lastName.trim(),
      'fullName': '${firstName.trim()} ${lastName.trim()}',
      'email': email.trim().toLowerCase(),
      'phone': phone.trim(),
      'role': role,
      'status': status,
    };
  }
}
