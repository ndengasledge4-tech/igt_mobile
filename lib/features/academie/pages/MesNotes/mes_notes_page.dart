import 'package:flutter/material.dart';
import 'note_detail_page.dart';
import '../../../../app/theme/colors.dart';

class MesNotesPage extends StatelessWidget {
  const MesNotesPage({super.key});

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
      backgroundColor: const Color(0xFFF8F9FC),

      // ============================================================
      // APPBAR — MÊME COULEUR QUE L'ACADÉMIE
      // ============================================================

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        scrolledUnderElevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 19,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Mes notes',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        centerTitle: false,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20,
            22,
            20,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ======================================================
              // INTRODUCTION
              // ======================================================

              const Text(
                'Consultez vos notes par année académique.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Color(0xFF687080),
                ),
              ),

              const SizedBox(height: 22),

              // ======================================================
              // TITRE
              // ======================================================

              const Text(
                'Années académiques',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF172033),
                ),
              ),

              const SizedBox(height: 14),

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

  // ================================================================
  // CARTE ANNÉE
  // ================================================================

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
        borderRadius: BorderRadius.circular(18),

        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Material(
        color: Colors.transparent,

        child: InkWell(
          borderRadius: BorderRadius.circular(18),

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

                // ==================================================
                // IMAGE PNG
                // ==================================================

                Container(
                  width: 52,
                  height: 52,

                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(15),
                  ),

                  padding: const EdgeInsets.all(9),

                  child: Image.asset(
                    'assets/images/academie/mes_notes.png',
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(width: 15),

                // ==================================================
                // INFORMATIONS
                // ==================================================

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Text(
                        annee,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF172033),
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        semestres,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF687080),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [

                          Container(
                            width: 7,
                            height: 7,

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: hasNotes
                                  ? const Color(0xFF4CAF50)
                                  : const Color(0xFF9CA3AF),
                            ),
                          ),

                          const SizedBox(width: 7),

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
                    ],
                  ),
                ),

                // ==================================================
                // FLÈCHE
                // ==================================================

                Container(
                  width: 34,
                  height: 34,

                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),

                  child: Icon(
                    Icons.chevron_right,
                    color: AppColors.primary,
                    size: 21,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}