import 'package:flutter/material.dart';

/// ============================================================
/// WIDGET : CARTE ANNÉE / MES COURS
/// ============================================================

class SemestreCard extends StatelessWidget {
  final String imagePath;
  final String titre;
  final String sousTitre;
  final String nombreCours;
  final String statut;
  final VoidCallback? onTap;

  const SemestreCard({
    super.key,
    required this.imagePath,
    required this.titre,
    required this.sousTitre,
    required this.nombreCours,
    required this.statut,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool aucunCours = nombreCours == 'Pas encore de cours';

    return InkWell(
      onTap: aucunCours ? null : onTap,
      borderRadius: BorderRadius.circular(18),

      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: aucunCours ? const Color(0xFFF5F6F7) : Colors.white,

          borderRadius: BorderRadius.circular(18),

          border: Border.all(
            color: aucunCours
                ? const Color(0xFFE1E3E6)
                : const Color(0xFFE8EAED),
          ),
        ),

        child: Row(
          children: [
            // ==================================================
            // IMAGE
            // ==================================================
            Container(
              width: 58,
              height: 58,

              decoration: BoxDecoration(
                color: aucunCours
                    ? const Color(0xFFE9EBED)
                    : const Color(0xFFF1F6F9),

                borderRadius: BorderRadius.circular(16),
              ),

              padding: const EdgeInsets.all(10),

              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,

                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.school_rounded,
                    size: 30,
                    color: aucunCours ? Colors.grey : const Color(0xFF4CAF50),
                  );
                },
              ),
            ),

            const SizedBox(width: 14),

            // ==================================================
            // INFORMATIONS
            // ==================================================
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titre,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: aucunCours ? Colors.black54 : Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    sousTitre,
                    style: TextStyle(
                      fontSize: 13,
                      color: aucunCours
                          ? Colors.grey.shade500
                          : Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    nombreCours,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,

                      color: aucunCours
                          ? Colors.grey.shade500
                          : const Color(0xFF6BA66F),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // ==================================================
            // STATUT + FLÈCHE
            // ==================================================
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  statut,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,

                    color: statut == 'En cours'
                        ? const Color(0xFFD8893D)
                        : Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 10),

                Icon(
                  Icons.chevron_right_rounded,
                  size: 22,
                  color: aucunCours ? Colors.grey.shade400 : Colors.black54,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
