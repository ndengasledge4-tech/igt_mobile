import 'package:flutter/material.dart';

class EmploiDuTempsCard extends StatelessWidget {
  final String heure;
  final String matiere;
  final String details;
  final Color couleur;
  final VoidCallback? onTap;

  const EmploiDuTempsCard({
    super.key,
    required this.heure,
    required this.matiere,
    required this.details,
    required this.couleur,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 68,
              child: Text(
                heure,
                style: const TextStyle(
                  color: Color(0xFF687080),
                  fontSize: 13,
                  height: 1.35,
                ),
              ),
            ),

            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(
                  14,
                  12,
                  12,
                  12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border(
                    left: BorderSide(
                      color: couleur,
                      width: 4,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      matiere,
                      style: const TextStyle(
                        color: Color(0xFF172033),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      details,
                      style: const TextStyle(
                        color: Color(0xFF687080),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}