class MockAcademicSummary {
  final String program;
  final String level;
  final String semester;
  final String academicYear;
  final int earnedCredits;
  final int totalCredits;

  const MockAcademicSummary({
    required this.program,
    required this.level,
    required this.semester,
    required this.academicYear,
    required this.earnedCredits,
    required this.totalCredits,
  });
}

abstract final class MockAcademicData {
  const MockAcademicData._();

  static const current = MockAcademicSummary(
    program: 'Licence en Informatique de Gestion',
    level: 'Licence 2',
    semester: 'Semestre 2',
    academicYear: '2025–2026',
    earnedCredits: 21,
    totalCredits: 30,
  );
}
