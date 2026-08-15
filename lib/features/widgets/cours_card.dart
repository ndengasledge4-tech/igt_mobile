import 'package:flutter/material.dart';

class CoursCard extends StatelessWidget {
  final String imagePath;
  final String nom;
  final String professeur;
  final String semestre;
  final int credits;
  final int coefficient;
  final VoidCallback? onTap;

  const CoursCard({
    super.key,
    required this.imagePath,
    required this.nom,
    required this.professeur,
    required this.semestre,
    required this.credits,
    required this.coefficient,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE9EDF1),
            ),
          ),
          child: Row(
            children: [
              // IMAGE DU COURS
              Container(
                width: 48,
                height: 48,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF5FC),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(width: 12),

              // INFORMATIONS
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nom,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF202124),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      professeur,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF8A8F98),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        _InfoBadge(label: semestre),
                        const SizedBox(width: 6),
                        _InfoBadge(label: '$credits crédits'),
                        const SizedBox(width: 6),
                        _InfoBadge(label: 'Coef. $coefficient'),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              const Icon(
                Icons.chevron_right,
                color: Color(0xFF8A8F98),
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  final String label;

  const _InfoBadge({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF5FC),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w600,
          color: Color(0xFF2789C8),
        ),
      ),
    );
  }
}