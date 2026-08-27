import 'package:flutter/material.dart';

import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';

class ProfilEtudiantCard extends StatelessWidget {
  const ProfilEtudiantCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.md),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _InfoItem(title: 'Matricule', value: '2024IG001'),
              ),
              Expanded(
                child: _InfoItem(title: 'Formation', value: 'Info. de Gestion'),
              ),
            ],
          ),

          SizedBox(height: AppDimensions.md),

          Row(
            children: [
              Expanded(
                child: _InfoItem(title: 'Niveau', value: '2ème année'),
              ),
              Expanded(
                child: _InfoItem(title: 'Classe', value: 'IG2'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String title;
  final String value;

  const _InfoItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.caption.copyWith(color: Colors.white70),
        ),
        const SizedBox(height: AppDimensions.xs),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
