class MockResultItem {
  final String subject;
  final String teacher;
  final String code;
  final double grade;
  final int credits;

  const MockResultItem({
    required this.subject,
    required this.teacher,
    required this.code,
    required this.grade,
    required this.credits,
  });
}

abstract final class MockResultsData {
  const MockResultsData._();

  static const average = 15.75;
  static const items = [
    MockResultItem(
      subject: 'Mathématiques avancées',
      teacher: 'Dr Salima Brahmi',
      code: 'MATH301',
      grade: 15.5,
      credits: 4,
    ),
    MockResultItem(
      subject: 'Algorithmique et structures de données',
      teacher: 'Dr Karim Mansouri',
      code: 'INFO201',
      grade: 17,
      credits: 5,
    ),
    MockResultItem(
      subject: 'Gestion de projet',
      teacher: 'Mme Nadia Trabelsi',
      code: 'MGT202',
      grade: 14,
      credits: 3,
    ),
    MockResultItem(
      subject: 'Bases de données',
      teacher: 'Mme Amina Belhaj',
      code: 'INFO202',
      grade: 16.5,
      credits: 4,
    ),
  ];
}
