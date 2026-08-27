import 'package:flutter/material.dart';
import '../../../../shared/widgets/premium_ui.dart';
import '../../academic_catalog.dart';
import '../../widgets/academic_components.dart';
import 'cours_contenu_page.dart';

class CoursDetailPage extends StatelessWidget {
  final String semestre;
  const CoursDetailPage({super.key, required this.semestre});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: AppScreenHeader(
            eyebrow: 'Mes cours',
            title: semestre,
            subtitle: '${AcademicCatalog.courses.length} matières disponibles',
            icon: Icons.menu_book_rounded,
            showBack: true,
          ),
        ),
        SliverToBoxAdapter(
          child: AppResponsiveContent(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth >= 680
                    ? (constraints.maxWidth - 14) / 2
                    : constraints.maxWidth;
                return Wrap(
                  spacing: 14,
                  runSpacing: 12,
                  children: [
                    for (final source in AcademicCatalog.courses)
                      SizedBox(
                        width: width,
                        child: AcademicCourseCard(
                          course: AcademicCourse(
                            name: source.name,
                            teacher: source.teacher,
                            semester: semestre.replaceAll('Semestre ', 'S'),
                            credits: source.credits,
                            coefficient: source.coefficient,
                            progress: source.progress,
                            nextActivity: source.nextActivity,
                            icon: source.icon,
                            accent: source.accent,
                          ),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (_) => CoursContenuPage(
                                imagePath: '',
                                nom: source.name,
                                professeur: source.teacher,
                                semestre: semestre,
                                credits: source.credits,
                                coefficient: source.coefficient,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}
