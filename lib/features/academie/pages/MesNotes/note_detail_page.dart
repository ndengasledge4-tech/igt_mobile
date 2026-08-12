import 'package:flutter/material.dart';
import '../../../widgets/note_card.dart';

class NoteDetailPage extends StatelessWidget {
  final String titre;
  final String niveau;

  const NoteDetailPage({
    super.key,
    required this.titre,
    required this.niveau,
  });

  static const Color primaryBlue = Color(0xFF1494D2);

  @override
  Widget build(BuildContext context) {
    if (titre == '1ère année') {
      return _buildSemestresPage(
        context,
        titre: 'Semestre 1',
        semestres: [
          _Semestre(
            nom: 'Semestre 1',
            code: 'S1',
            informations: '5 matière(s) · 15 crédits',
            hasNotes: true,
          ),
          _Semestre(
            nom: 'Semestre 2',
            code: 'S2',
            informations: '5 matière(s) · 16 crédits',
            hasNotes: true,
          ),
        ],
      );
    }

    if (titre == '2ème année') {
      return _buildSemestresPage(
        context,
        titre: 'Semestre 2',
        semestres: [
          _Semestre(
            nom: 'Semestre 3',
            code: 'S3',
            informations: '6 matière(s) · 21 crédits',
            hasNotes: true,
          ),
          _Semestre(
            nom: 'Semestre 4',
            code: 'S4',
            informations: 'Aucune note disponible',
            hasNotes: false,
          ),
        ],
      );
    }

    return _buildSemestresPage(
      context,
      titre: 'Semestre 3',
      semestres: [
        _Semestre(
          nom: 'Semestre 5',
          code: 'S5',
          informations: 'Aucune note disponible',
          hasNotes: false,
        ),
        _Semestre(
          nom: 'Semestre 6',
          code: 'S6',
          informations: 'Aucune note disponible',
          hasNotes: false,
        ),
      ],
    );
  }

  Widget _buildSemestresPage(
      BuildContext context, {
        required String titre,
        required List<_Semestre> semestres,
      }) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Color(0xFF555555),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          titre,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF202020),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choisissez un semestre pour consulter vos notes.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF777777),
                ),
              ),

              const SizedBox(height: 20),

              ...semestres.map(
                    (semestre) => _buildSemestreCard(
                  context,
                  semestre,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSemestreCard(
      BuildContext context,
      _Semestre semestre,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE7E7E7),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => _SemesterNotesPage(
                  semestre: semestre.nom,
                  hasNotes: semestre.hasNotes,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F8FC),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    semestre.code,
                    style: const TextStyle(
                      color: primaryBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        semestre.nom,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF252525),
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        semestre.informations,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF777777),
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF888888),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SemesterNotesPage extends StatelessWidget {
  final String semestre;
  final bool hasNotes;

  const _SemesterNotesPage({
    required this.semestre,
    required this.hasNotes,
  });

  @override
  Widget build(BuildContext context) {
    if (!hasNotes) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 18,
              color: Color(0xFF555555),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            semestre,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF202020),
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/academie/notes.png',
                  width: 52,
                  height: 52,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Aucune note',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Aucune note disponible pour le $semestre.',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF888888),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    final notes = _getNotes(semestre);

    final moyenne = semestre == 'Semestre 1'
        ? '13.95'
        : semestre == 'Semestre 2'
        ? '13.95'
        : '14.73';

    final credits = semestre == 'Semestre 1'
        ? '15'
        : semestre == 'Semestre 2'
        ? '16'
        : '21';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Color(0xFF555555),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          semestre,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF202020),
          ),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            _buildMoyenneCard(
              moyenne: moyenne,
              credits: credits,
            ),

            const SizedBox(height: 12),

            ...notes.map(
                  (note) => NoteCard(
                nom: note.nom,
                note: note.note,
                coefficient: note.coefficient,
                credits: note.credits,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoyenneCard({
    required String moyenne,
    required String credits,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 17,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1494D2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Moyenne Semestre',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$moyenne /20',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Crédits',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                credits,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<_Note> _getNotes(String semestre) {
    if (semestre == 'Semestre 1') {
      return [
        _Note(
          nom: 'Introduction à l’informatique',
          note: '15',
          coefficient: '3',
          credits: '4',
        ),
        _Note(
          nom: 'Algorithmique I',
          note: '13.5',
          coefficient: '3',
          credits: '4',
        ),
        _Note(
          nom: 'Mathématiques I',
          note: '12',
          coefficient: '2',
          credits: '3',
        ),
        _Note(
          nom: 'Anglais I',
          note: '16',
          coefficient: '1',
          credits: '2',
        ),
        _Note(
          nom: 'Expression française',
          note: '14',
          coefficient: '1',
          credits: '2',
        ),
      ];
    }

    if (semestre == 'Semestre 2') {
      return [
        _Note(
          nom: 'Algorithmique II',
          note: '14',
          coefficient: '3',
          credits: '4',
        ),
        _Note(
          nom: 'Programmation orientée objet',
          note: '15.5',
          coefficient: '3',
          credits: '4',
        ),
        _Note(
          nom: 'Mathématiques II',
          note: '11',
          coefficient: '2',
          credits: '3',
        ),
        _Note(
          nom: 'Systèmes d’information',
          note: '13',
          coefficient: '2',
          credits: '3',
        ),
        _Note(
          nom: 'Anglais II',
          note: '17',
          coefficient: '1',
          credits: '2',
        ),
      ];
    }

    return [
      _Note(
        nom: 'Algorithmique avancée',
        note: '16.5',
        coefficient: '3',
        credits: '4',
      ),
      _Note(
        nom: 'Bases de données',
        note: '12',
        coefficient: '2',
        credits: '3',
      ),
      _Note(
        nom: 'Réseaux informatiques',
        note: '18',
        coefficient: '3',
        credits: '4',
      ),
      _Note(
        nom: 'Génie logiciel',
        note: '14.5',
        coefficient: '2',
        credits: '3',
      ),
      _Note(
        nom: 'Systèmes d’exploitation',
        note: '11',
        coefficient: '3',
        credits: '4',
      ),
      _Note(
        nom: 'Mathématiques',
        note: '15.75',
        coefficient: '2',
        credits: '3',
      ),
    ];
  }
}

class _Semestre {
  final String nom;
  final String code;
  final String informations;
  final bool hasNotes;

  const _Semestre({
    required this.nom,
    required this.code,
    required this.informations,
    required this.hasNotes,
  });
}

class _Note {
  final String nom;
  final String note;
  final String coefficient;
  final String credits;

  const _Note({
    required this.nom,
    required this.note,
    required this.coefficient,
    required this.credits,
  });
}