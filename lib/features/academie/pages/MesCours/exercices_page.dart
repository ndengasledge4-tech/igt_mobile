import 'package:flutter/material.dart';

import '../../../../shared/widgets/premium_ui.dart';
import '../../academic_catalog.dart';
import '../../widgets/academic_components.dart';
import 'exercice_detail_page.dart';

class ExercicesPage extends StatelessWidget {
  const ExercicesPage({super.key});
  static const _items = [
    (
      '01',
      'Quiz de compréhension',
      '10 questions · 15 min',
      'Facile',
      LearningStatus.completed,
    ),
    (
      '02',
      'Étude de cas : e-commerce',
      'À rendre le 2 septembre',
      'Intermédiaire',
      LearningStatus.inProgress,
    ),
    (
      '03',
      'Modélisation d’une architecture',
      'Document à déposer · 45 min',
      'Avancé',
      LearningStatus.notStarted,
    ),
    (
      '04',
      'Projet de synthèse',
      'Disponible après le chapitre 4',
      'Projet',
      LearningStatus.locked,
    ),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: AppScreenHeader(
            eyebrow: 'Architecture logicielle',
            title: 'Exercices',
            subtitle: '4 activités · 1 à rendre',
            icon: Icons.assignment_rounded,
            showBack: true,
          ),
        ),
        SliverToBoxAdapter(
          child: AppResponsiveContent(
            maxWidth: 760,
            child: Column(
              children: [
                for (var i = 0; i < _items.length; i++) ...[
                  AcademicResourceRow(
                    icon: Icons.edit_note_rounded,
                    title: '${_items[i].$1} · ${_items[i].$2}',
                    metadata: '${_items[i].$3} · ${_items[i].$4}',
                    status: _items[i].$5,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => ExerciceDetailPage(
                          numero: _items[i].$1,
                          titre: _items[i].$2,
                          description: _items[i].$3,
                          niveau: _items[i].$4,
                        ),
                      ),
                    ),
                  ),
                  if (i != _items.length - 1) const SizedBox(height: 10),
                ],
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
