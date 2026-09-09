enum StudentAccountStatus {
  pending('pending'),

  active('active');

  const StudentAccountStatus(this.firestoreValue);
  final String firestoreValue;
}
