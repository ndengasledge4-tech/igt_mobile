class CampusModel {
  final String name;
  final String address;
  final String city;
  final String status;

  const CampusModel({
    required this.name,
    required this.address,
    required this.city,
    required this.status,
  });

  Map<String, dynamic> toMap({required String uid}) {
    return {
      'uid': uid,
      'name': name.trim(),
      'address': address.trim(),
      'city': city.trim(),
      'status': status,
    };
  }
}
