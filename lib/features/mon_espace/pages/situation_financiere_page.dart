import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/semantic_colors.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/premium_ui.dart';
import '../widgets/paiement_card.dart';

class SituationFinancierePage extends StatelessWidget {
  const SituationFinancierePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader.secondary(
        title: 'Situation financière',
        subtitle: 'Frais, règlements et échéances',
      ),
      body: SingleChildScrollView(
        child: AppResponsiveContent(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 2. CARTE DE SYNTHÈSE FINANCIÈRE
              _buildSynthesisCard(context),
              const SizedBox(height: 24),

              // 4. FRAIS LIÉS À LA FORMATION
              Text(
                "Détails des frais",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              _buildFeesCard(context),
              const SizedBox(height: 24),

              // 5. HISTORIQUE DES PAIEMENTS
              Text(
                "Historique des paiements",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              const PaiementCard(
                title: "Scolarité - Échéance 3 (Espèces)",
                date: "15 Janvier 2024",
                amount: "150.000 FCFA",
                status: "Payé",
                statusColor: AppColors.success,
              ),
              const PaiementCard(
                title: "Scolarité - Échéance 2 (Chèque)",
                date: "15 Décembre 2023",
                amount: "150.000 FCFA",
                status: "Payé",
                statusColor: AppColors.success,
              ),
              const PaiementCard(
                title: "Frais d'inscription (Espèces)",
                date: "05 Octobre 2023",
                amount: "50.000 FCFA",
                status: "Payé",
                statusColor: AppColors.success,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSynthesisCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.semanticColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "État global",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: context.semanticColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "À jour",
                  style: TextStyle(
                    color: AppColors.success,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildSynthesisItem(
                context,
                "Total à payer",
                "900.000",
                context.semanticColors.textPrimary,
              ),
              Container(
                width: 1,
                height: 40,
                color: context.semanticColors.border,
              ),
              _buildSynthesisItem(
                context,
                "Montant payé",
                "450.000",
                context.semanticColors.success,
              ),
              Container(
                width: 1,
                height: 40,
                color: context.semanticColors.border,
              ),
              _buildSynthesisItem(
                context,
                "Montant restant",
                "450.000",
                AppColors.error,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSynthesisItem(
    BuildContext context,
    String label,
    String amount,
    Color amountColor,
  ) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: context.semanticColors.textSecondary,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: TextStyle(
              color: amountColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "FCFA",
            style: TextStyle(
              color: context.semanticColors.textSecondary,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeesCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: Column(
        children: [
          _buildFeeRow(context, "Frais d'inscription", "50.000 FCFA"),
          Divider(height: 24, color: context.semanticColors.border),
          _buildFeeRow(context, "Scolarité annuelle", "850.000 FCFA"),
          Divider(height: 24, color: context.semanticColors.border),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Total formation",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "900.000 FCFA",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeeRow(BuildContext context, String label, String amount) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: context.semanticColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          amount,
          style: TextStyle(
            color: context.semanticColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
