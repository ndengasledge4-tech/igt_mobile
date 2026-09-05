class MockDocumentItem {
  final String title;
  final String category;
  final String fileType;
  final String size;
  final String updatedAt;

  const MockDocumentItem({
    required this.title,
    required this.category,
    required this.fileType,
    required this.size,
    required this.updatedAt,
  });
}

abstract final class MockDocumentsData {
  const MockDocumentsData._();

  static const items = [
    MockDocumentItem(
      title: 'Calendrier académique 2025–2026',
      category: 'Administration',
      fileType: 'PDF',
      size: '1,2 Mo',
      updatedAt: '24 juillet 2025',
    ),
    MockDocumentItem(
      title: 'Polycopié d’algorithmique — Chapitre 6',
      category: 'Cours',
      fileType: 'PDF',
      size: '3,8 Mo',
      updatedAt: '22 juillet 2025',
    ),
  ];
}
