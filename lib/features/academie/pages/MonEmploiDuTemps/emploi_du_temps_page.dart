import 'package:flutter/material.dart';
import '../../../../app/theme/colors.dart';
import '../../../../app/theme/semantic_colors.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../widgets/emploi_du_temps_card.dart';
import 'emploi_du_temps_detail.dart';

class EmploiDuTempsPage extends StatefulWidget {
  const EmploiDuTempsPage({super.key});

  @override
  State<EmploiDuTempsPage> createState() => _EmploiDuTempsPageState();
}

class _EmploiDuTempsPageState extends State<EmploiDuTempsPage> {
  int selectedView = 0;

  final Color bleu = AppColors.primary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader.secondary(
        title: 'Mon emploi du temps',
        subtitle: 'Cours et salles de la semaine',
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 880),
          child: Column(
            children: [
              // ============================================================
              // ONGLETS JOUR / SEMAINE / MOIS
              // ============================================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: context.semanticColors.border),
                  ),
                  child: Row(
                    children: [
                      _buildTab('Jour', 0),
                      _buildTab('Semaine', 1),
                      _buildTab('Mois', 2),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Expanded(
                child: IndexedStack(
                  index: selectedView,
                  children: [_buildJour(), _buildSemaine(), _buildMois()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ONGLET
  // ============================================================

  Widget _buildTab(String title, int index) {
    final bool selected = selectedView == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedView = index;
          });
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? bleu.withValues(alpha: 0.08) : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: selected ? bleu : context.semanticColors.textSecondary,
              fontSize: 14,
              fontWeight: selected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // VUE JOUR
  // ============================================================

  Widget _buildJour() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lundi 17 novembre 2025',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 18),

          EmploiDuTempsCard(
            heure: '08:00\n10:00',
            matiere: 'Algorithmique avancée',
            details: 'Salle A204 · Prof. Coulibaly',
            couleur: AppColors.primary,
            onTap: () => _ouvrirDetail(
              'Algorithmique avancée',
              '08:00 - 10:00',
              'Salle A204',
              'Prof. Coulibaly',
            ),
          ),

          EmploiDuTempsCard(
            heure: '10:30\n12:30',
            matiere: 'Bases de données',
            details: 'Salle B102 · Prof. Diallo',
            couleur: const Color(0xFF4CAF50),
            onTap: () => _ouvrirDetail(
              'Bases de données',
              '10:30 - 12:30',
              'Salle B102',
              'Prof. Diallo',
            ),
          ),

          EmploiDuTempsCard(
            heure: '14:00\n16:00',
            matiere: 'Réseaux informatiques',
            details: 'Labo Info · Prof. Traoré',
            couleur: const Color(0xFFFFA000),
            onTap: () => _ouvrirDetail(
              'Réseaux informatiques',
              '14:00 - 16:00',
              'Labo Info',
              'Prof. Traoré',
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // VUE SEMAINE
  // ============================================================

  Widget _buildSemaine() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Semaine du 17 au 21 novembre',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 14),

          _buildDay('Lun', '17', true, ['Algo 08h-10h', 'BDD 10h30-12h30']),

          _buildDay('Mar', '18', false, ['Réseaux 08h-10h', 'Génie 14h-16h']),

          _buildDay('Mer', '19', false, ['SE 08h-10h']),

          _buildDay('Jeu', '20', false, ['Pas de cours']),

          _buildDay('Ven', '21', false, ['Maths 08h-10h', 'Algo 14h-16h']),
        ],
      ),
    );
  }

  Widget _buildDay(
    String jour,
    String date,
    bool selected,
    List<String> cours,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 70,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: selected ? bleu : Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: selected ? bleu : context.semanticColors.border,
              ),
            ),
            child: Column(
              children: [
                Text(
                  jour,
                  style: TextStyle(
                    color: selected
                        ? Colors.white
                        : context.semanticColors.textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(
                    color: selected
                        ? Colors.white
                        : context.semanticColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              children: cours.map((cours) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 7),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    cours,
                    style: TextStyle(
                      color: bleu,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // VUE MOIS
  // ============================================================

  Widget _buildMois() {
    final jours = [
      '',
      '',
      '',
      '',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22',
      '23',
      '24',
      '25',
      '26',
      '27',
      '28',
      '29',
      '30',
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Novembre 2025',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: context.semanticColors.border),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text('L'),
                    Text('M'),
                    Text('M'),
                    Text('J'),
                    Text('V'),
                    Text('S'),
                    Text('D'),
                  ],
                ),

                const SizedBox(height: 12),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: jours.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 4,
                  ),
                  itemBuilder: (context, index) {
                    final jour = jours[index];

                    if (jour.isEmpty) {
                      return const SizedBox();
                    }

                    final selected = jour == '17';

                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected ? bleu : Colors.transparent,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Text(
                        jour,
                        style: TextStyle(
                          color: selected
                              ? Colors.white
                              : context.semanticColors.textPrimary,
                          fontWeight: selected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DÉTAIL D'UN COURS
  // ============================================================

  void _ouvrirDetail(
    String matiere,
    String horaire,
    String salle,
    String professeur,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EmploiDuTempsDetail(
          matiere: matiere,
          horaire: horaire,
          salle: salle,
          professeur: professeur,
        ),
      ),
    );
  }
}
