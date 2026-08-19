import 'package:flutter/material.dart';

import 'chapitre_page.dart';
import 'videos_page.dart';
import 'exercices_page.dart';
import '../MesDocuments/mes_documents_page.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FB),
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Cours',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ==================================================
            // IMAGE DU COURS
            // ==================================================

            Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF5FC),
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            // ==================================================
            // NOM DU COURS
            // ==================================================

            Text(
              nom,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF202124),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              professeur,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF8A8F98),
              ),
            ),

            const SizedBox(height: 18),

            // ==================================================
            // INFORMATIONS
            // ==================================================

            Row(
              children: [
                _InfoBadge(
                  label: semestre,
                ),

                const SizedBox(width: 8),

                _InfoBadge(
                  label: '$credits crédits',
                ),

                const SizedBox(width: 8),

                _InfoBadge(
                  label: 'Coef. $coefficient',
                ),
              ],
            ),

            const SizedBox(height: 28),

            // ==================================================
            // PRÉSENTATION
            // ==================================================

            const Text(
              'Présentation du cours',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF202124),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Ce cours permet à l’étudiant d’acquérir les connaissances '
                  'et compétences fondamentales nécessaires dans le domaine '
                  'concerné. Il présente les notions essentielles du cours '
                  'et leur application dans des situations pratiques.',
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Color(0xFF666B73),
              ),
            ),

            const SizedBox(height: 28),

            // ==================================================
            // OBJECTIFS
            // ==================================================

            const Text(
              'Objectifs du cours',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF202124),
              ),
            ),

            const SizedBox(height: 12),

            _ObjectifItem(
              text: 'Comprendre les notions fondamentales du cours.',
            ),

            _ObjectifItem(
              text: 'Maîtriser les concepts essentiels.',
            ),

            _ObjectifItem(
              text: 'Être capable d’appliquer les connaissances acquises.',
            ),

            _ObjectifItem(
              text: 'Développer les compétences nécessaires pour les travaux pratiques.',
            ),

            const SizedBox(height: 28),

            // ==================================================
            // CHAPITRES
            // ==================================================

            const Text(
              'Chapitres du cours',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF202124),
              ),
            ),

            const SizedBox(height: 12),

            _ChapterCard(
              number: '01',
              title: 'Introduction',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChapitrePage(
                      numero: '01',
                      titre: 'Introduction',
                      contenu:
                      'L’informatique est la science du traitement automatique '
                          'de l’information à l’aide de systèmes informatiques. '
                          'Ce chapitre présente les notions générales permettant '
                          'de comprendre le fonctionnement et les domaines '
                          'd’application de l’informatique.',
                      objectifs: [
                        'Comprendre la définition de l’informatique.',
                        'Découvrir l’histoire et l’évolution de l’informatique.',
                        'Identifier les principaux domaines d’application.',
                        'Comprendre le rôle de l’informatique dans la société.',
                      ],
                    ),
                  ),
                );
              },
            ),

            _ChapterCard(
              number: '02',
              title: 'Notions fondamentales',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChapitrePage(
                      numero: '02',
                      titre: 'Notions fondamentales',
                      contenu:
                      'Ce chapitre présente les notions fondamentales de l’informatique, '
                          'notamment les composants d’un ordinateur, les logiciels, les systèmes '
                          'd’exploitation et les principales notions liées au traitement de l’information.',
                      objectifs: [
                        'Identifier les principaux composants d’un ordinateur.',
                        'Comprendre la différence entre matériel et logiciel.',
                        'Découvrir le rôle du système d’exploitation.',
                        'Comprendre les notions fondamentales du traitement de l’information.',
                      ],
                    ),
                  ),
                );
              },
            ),
            _ChapterCard(
              number: '03',
              title: 'Concepts avancés',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChapitrePage(
                      numero: '03',
                      titre: 'Concepts avancés',
                      contenu:
                      'Ce chapitre permet d’approfondir les notions étudiées '
                          'précédemment. Il présente des concepts plus avancés de '
                          'l’informatique et montre comment les utiliser dans des '
                          'situations concrètes.',
                      objectifs: [
                        'Approfondir les concepts informatiques étudiés.',
                        'Comprendre les mécanismes avancés liés au domaine.',
                        'Analyser des problèmes informatiques complexes.',
                        'Appliquer les connaissances à des situations pratiques.',
                      ],
                    ),
                  ),
                );
              },
            ),

            _ChapterCard(
              number: '04',
              title: 'Travaux pratiques',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChapitrePage(
                      numero: '04',
                      titre: 'Travaux pratiques',
                      contenu:
                      'Ce chapitre est consacré à la mise en pratique des '
                          'connaissances acquises durant le cours. L’étudiant réalise '
                          'des exercices et des activités pratiques afin de renforcer '
                          'sa compréhension et développer ses compétences.',
                      objectifs: [
                        'Mettre en pratique les connaissances acquises.',
                        'Résoudre des problèmes à travers des exercices.',
                        'Développer l’autonomie dans la réalisation des travaux.',
                        'Évaluer les compétences acquises durant le cours.',
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 28),

            // ==================================================
            // RESSOURCES
            // ==================================================

            const Text(
              'Ressources',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF202124),
              ),
            ),

            const SizedBox(height: 12),

            _ResourceCard(
              icon: Icons.picture_as_pdf_outlined,
              title: 'Supports de cours',
              subtitle: 'Documents PDF du cours',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MesDocumentsPage(
                      initialCategory: 3,
                    ),
                  ),
                );
              },
            ),

            _ResourceCard(
              icon: Icons.video_library_outlined,
              title: 'Vidéos',
              subtitle: 'Vidéos et explications du cours',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const VideosPage(),
                  ),
                );
              },
            ),

            _ResourceCard(
              icon: Icons.assignment_outlined,
              title: 'Exercices',
              subtitle: 'Exercices et travaux pratiques',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ExercicesPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// BADGE
// ============================================================

class _InfoBadge extends StatelessWidget {
  final String label;

  const _InfoBadge({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF5FC),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Color(0xFF2789C8),
        ),
      ),
    );
  }
}

// ============================================================
// OBJECTIF
// ============================================================

class _ObjectifItem extends StatelessWidget {
  final String text;

  const _ObjectifItem({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 20,
            color: Color(0xFF2789C8),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Color(0xFF666B73),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// CHAPITRE
// ============================================================

class _ChapterCard extends StatelessWidget {
  final String number;
  final String title;
  final VoidCallback onTap;

  const _ChapterCard({
    required this.number,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),

        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE9EDF1),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF5FC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              number,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2789C8),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF202124),
              ),
            ),
          ),

          const Icon(
            Icons.chevron_right,
            color: Color(0xFF8A8F98),
          ),
        ],
      ),
        ),
    );
  }
}

// ============================================================
// RESSOURCE
// ============================================================
class _ResourceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ResourceCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFE9EDF1),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF5FC),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF2789C8),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF202124),
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF8A8F98),
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF8A8F98),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}