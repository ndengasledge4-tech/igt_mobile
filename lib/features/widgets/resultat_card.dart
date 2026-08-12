import 'package:flutter/material.dart';

class ResultatCard extends StatelessWidget {
  final String semestre;
  final String moyenne;
  final String credits;
  final String mention;
  final String statut;

  const ResultatCard({
    super.key,
    required this.semestre,
    required this.moyenne,
    required this.credits,
    required this.mention,
    required this.statut,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ligne contenant le semestre et le statut de validation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                semestre,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF172033),
                ),
              ),

              // Badge "Validé"
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Validé',
                  style: TextStyle(
                    color: Color(0xFF4CAF50),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Cartes Moyenne / Crédits / Mention
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _ResultatInfo(
                  valeur: moyenne,
                  label: 'Moyenne',
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: _ResultatInfo(
                  valeur: credits,
                  label: 'Crédits',
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: _ResultatInfo(
                  valeur: mention,
                  label: 'Mention',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ResultatInfo extends StatelessWidget {
  final String valeur;
  final String label;

  const _ResultatInfo({
    required this.valeur,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 82,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        // Gris clair comme dans la maquette
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Valeur : moyenne, crédits ou mention
          Text(
            valeur,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF172033),
            ),
          ),

          const SizedBox(height: 5),

          // Libellé
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}