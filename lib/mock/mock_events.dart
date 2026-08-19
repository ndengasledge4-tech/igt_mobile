class MockEventItem {
  final String title;
  final String date;
  final String time;
  final String location;
  final bool registrationOpen;

  const MockEventItem({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.registrationOpen,
  });
}

abstract final class MockEventsData {
  const MockEventsData._();

  static const items = [
    MockEventItem(
      title: 'Conférence sur l’intelligence artificielle',
      date: '12 septembre 2025',
      time: '14h00',
      location: 'Amphithéâtre principal',
      registrationOpen: true,
    ),
  ];
}
