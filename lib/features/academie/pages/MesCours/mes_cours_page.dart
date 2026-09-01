import 'package:flutter/material.dart';

import '../../../../app/routes/route_names.dart';
import '../../../../app/theme/semantic_colors.dart';
import '../../../../shared/widgets/premium_ui.dart';
import '../../academic_catalog.dart';
import '../../widgets/academic_components.dart';
import 'cours_contenu_page.dart';

class MesCoursPage extends StatefulWidget {
  const MesCoursPage({super.key});
  @override
  State<MesCoursPage> createState() => _MesCoursPageState();
}

class _MesCoursPageState extends State<MesCoursPage> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courses = AcademicCatalog.courses.where((course) {
      final query = _query.toLowerCase();
      return course.name.toLowerCase().contains(query) ||
          course.teacher.toLowerCase().contains(query);
    }).toList();
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: AppScreenHeader(
              eyebrow: 'Semestre 6 · 2025–2026',
              title: 'Mes cours',
              subtitle:
                  '${AcademicCatalog.courses.length} matières · 17 crédits',
              icon: Icons.menu_book_rounded,
              showBack: true,
            ),
          ),
          SliverToBoxAdapter(
            child: AppResponsiveContent(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    key: const Key('academic-period-selector'),
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteNames.semestre,
                      arguments: const {
                        'annee': '1ère année',
                        'semestres': ['Semestre 1', 'Semestre 2'],
                      },
                    ),
                    child: Ink(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest
                            .withValues(alpha: .65),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month_rounded,
                            size: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '1ère année',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextSpan(text: ' · Semestre 6'),
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            'Changer',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    key: const Key('course-search'),
                    controller: _searchController,
                    onChanged: (value) => setState(() => _query = value.trim()),
                    decoration: const InputDecoration(
                      hintText: 'Rechercher une matière ou un enseignant',
                      prefixIcon: Icon(Icons.search_rounded),
                      suffixIcon: Icon(Icons.tune_rounded),
                    ),
                  ),
                  const SizedBox(height: 26),
                  AppSectionHeading(
                    title: 'Matières du semestre',
                    subtitle:
                        '${courses.length} résultat${courses.length > 1 ? 's' : ''}',
                  ),
                  const SizedBox(height: 14),
                  if (courses.isEmpty)
                    AppSurface(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            children: [
                              Icon(
                                Icons.search_off_rounded,
                                size: 38,
                                color: context.semanticColors.textDisabled,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Aucun cours ne correspond à cette recherche.',
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    _CourseLayout(courses: courses),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CourseLayout extends StatelessWidget {
  final List<AcademicCourse> courses;
  const _CourseLayout({required this.courses});
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final width = constraints.maxWidth >= 680
          ? (constraints.maxWidth - 14) / 2
          : constraints.maxWidth;
      return Wrap(
        spacing: 14,
        runSpacing: 12,
        children: [
          for (final course in courses)
            SizedBox(
              width: width,
              child: AcademicCourseCard(
                course: course,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => CoursContenuPage(
                      imagePath: '',
                      nom: course.name,
                      professeur: course.teacher,
                      semestre: course.semester,
                      credits: course.credits,
                      coefficient: course.coefficient,
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    },
  );
}
