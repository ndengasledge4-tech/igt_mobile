import 'package:flutter/material.dart';
import 'note_detail_page.dart';

class MesNotesPage extends StatelessWidget {
  const MesNotesPage({super.key});

  static const Color primaryBlue = Color(0xFF1494D2);

  @override
  Widget build(BuildContext context) {
    final annees = [
      {
        'annee': '1ère année',
        'semestres': 'Semestre 1 — Semestre 2',
        'notes': '10 note(s) disponible(s)',
        'hasNotes': true,
      },
      {
        'annee': '2ème année',
        'semestres': 'Semestre 3 — Semestre 4',
        'notes': '6 note(s) disponible(s)',
        'hasNotes': true,
      },
      {
        'annee': '3ème année',
        'semestres': 'Semestre 5 — Semestre 6',
        'notes': 'Pas encore de notes',
        'hasNotes': false,
      },
    ];

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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Mes notes',
          style: TextStyle(
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
                'Sélectionnez une année académique pour consulter\nvos notes.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Color(0xFF777777),
                ),
              ),

              const SizedBox(height: 20),

              ...annees.map(
                    (annee) => _buildAnneeCard(
                  context,
                  annee: annee['annee'] as String,
                  semestres: annee['semestres'] as String,
                  notes: annee['notes'] as String,
                  hasNotes: annee['hasNotes'] as bool,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnneeCard(
      BuildContext context, {
        required String annee,
        required String semestres,
        required String notes,
        required bool hasNotes,
      }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE8E8E8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => NoteDetailPage(
                  titre: annee,
                  niveau: annee,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F8FC),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Image.asset(
                    'assets/images/academie/notes.png',
                    width: 35,
                    height: 35,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        annee,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF242424),
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        semestres,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF777777),
                        ),
                      ),

                      const SizedBox(height: 7),

                      Text(
                        notes,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: hasNotes
                              ? const Color(0xFF4C9A5B)
                              : const Color(0xFF777777),
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF888888),
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}