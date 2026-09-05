import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';
import '../../../../app/theme/semantic_colors.dart';
import '../../../../shared/widgets/premium_ui.dart';
import '../../academic_catalog.dart';
import '../../widgets/academic_components.dart';
import '../MesDocuments/mes_documents_page.dart';
import 'chapitre_page.dart';
import 'exercices_page.dart';
import 'videos_page.dart';

class CoursContenuPage extends StatelessWidget {
  final String imagePath;
  final String nom;
  final String professeur;
  final String semestre;
  final int credits;
  final int coefficient;

  const CoursContenuPage({
    super.key,
    required this.imagePath,
    required this.nom,
    required this.professeur,
    required this.semestre,
    required this.credits,
    required this.coefficient,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SliverToBoxAdapter(
          child: AppScreenHeader(
            eyebrow: 'Espace d’apprentissage',
            title: 'Détail du cours',
            subtitle: 'Contenus, activités et progression',
            icon: Icons.school_rounded,
            showBack: true,
          ),
        ),
        SliverToBoxAdapter(
          child: AppResponsiveContent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CourseHero(
                  name: nom,
                  teacher: professeur,
                  semester: semestre,
                  credits: credits,
                  coefficient: coefficient,
                ),
                const SizedBox(height: 28),
                const AppSectionHeading(
                  title: 'Chapitres',
                  subtitle: '4 chapitres · 18 ressources',
                ),
                const SizedBox(height: 14),
                for (var i = 0; i < AcademicCatalog.chapters.length; i++) ...[
                  _ChapterRow(
                    chapter: AcademicCatalog.chapters[i],
                    onTap:
                        AcademicCatalog.chapters[i].status ==
                            LearningStatus.locked
                        ? null
                        : () => Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (_) => ChapitrePage(
                                numero: AcademicCatalog.chapters[i].number,
                                titre: AcademicCatalog.chapters[i].title,
                                contenu:
                                    'Ce chapitre présente les concepts essentiels, leur mise en pratique et les points à retenir pour progresser dans le cours.',
                                objectifs: const [
                                  'Identifier les concepts fondamentaux.',
                                  'Appliquer la méthode sur un cas concret.',
                                  'Valider les acquis avec l’exercice associé.',
                                ],
                              ),
                            ),
                          ),
                  ),
                  if (i != AcademicCatalog.chapters.length - 1)
                    const SizedBox(height: 10),
                ],
                const SizedBox(height: 28),
                const AppSectionHeading(
                  title: 'Ressources et activités',
                  subtitle: 'Une même lecture pour tous les formats',
                ),
                const SizedBox(height: 14),
                AcademicResourceRow(
                  icon: Icons.picture_as_pdf_rounded,
                  title: 'Support complet du cours',
                  metadata: 'PDF · 4,1 Mo · mis à jour hier',
                  status: LearningStatus.inProgress,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (_) =>
                          const MesDocumentsPage(initialCategory: 3),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                AcademicResourceRow(
                  icon: Icons.play_circle_rounded,
                  title: 'Vidéos du cours',
                  metadata: '4 vidéos · 1 h 10 min',
                  status: LearningStatus.inProgress,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(builder: (_) => const VideosPage()),
                  ),
                ),
                const SizedBox(height: 10),
                AcademicResourceRow(
                  icon: Icons.assignment_rounded,
                  title: 'Exercices et travaux pratiques',
                  metadata: '4 activités · 1 à rendre',
                  status: LearningStatus.notStarted,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (_) => const ExercicesPage(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _CourseHero extends StatelessWidget {
  final String name, teacher, semester;
  final int credits, coefficient;
  const _CourseHero({
    required this.name,
    required this.teacher,
    required this.semester,
    required this.credits,
    required this.coefficient,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: dark
              ? const [Color(0xFF10243A), Color(0xFF163B4E)]
              : const [AppColors.primaryStrong, Color(0xFF215B77)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.account_tree_rounded,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  semester,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            name,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            teacher,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: .72),
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              _Metric(value: '$credits', label: 'Crédits'),
              const SizedBox(width: 12),
              _Metric(value: '$coefficient', label: 'Coefficient'),
              const SizedBox(width: 12),
              const _Metric(value: '72 %', label: 'Progression'),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: .72,
              minHeight: 7,
              color: AppColors.accent,
              backgroundColor: Colors.white.withValues(alpha: .15),
            ),
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String value, label;
  const _Metric({required this.value, required this.label});
  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .09),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            style: TextStyle(
              color: Colors.white.withValues(alpha: .65),
              fontSize: 10,
            ),
          ),
        ],
      ),
    ),
  );
}

class _ChapterRow extends StatelessWidget {
  final AcademicChapter chapter;
  final VoidCallback? onTap;
  const _ChapterRow({required this.chapter, this.onTap});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppSurface(
      onTap: onTap,
      padding: const EdgeInsets.all(14),
      radius: 16,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: .09),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Text(
              chapter.number,
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        chapter.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    AcademicStatusBadge(status: chapter.status),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: LinearProgressIndicator(
                          value: chapter.progress,
                          minHeight: 5,
                          backgroundColor:
                              theme.colorScheme.surfaceContainerHighest,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${chapter.resources} ressources',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: context.semanticColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
