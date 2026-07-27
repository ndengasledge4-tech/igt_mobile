class FormationModel {
  final String name;
  final String description;
  final String campusId;
  final String status;

  const FormationModel({
    required this.name,
    required this.description,
    required this.campusId,
    required this.status,
  });

  Map<String, dynamic> toMap({required String uid}) {
    return {
      'uid': uid,
      'name': name.trim(),
      'description': description.trim(),
      'campusId': campusId,
      'status': status,
    };
  }
}