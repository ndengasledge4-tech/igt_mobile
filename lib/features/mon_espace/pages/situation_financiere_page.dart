import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';
import '../widgets/paiement_card.dart';

class SituationFinancierePage extends StatelessWidget {
  const SituationFinancierePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Center(
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.softBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          "Situation financière",
          style: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 2. CARTE DE SYNTHÈSE FINANCIÈRE
            _buildSynthesisCard(),
            const SizedBox(height: 24),

            // 4. FRAIS LIÉS À LA FORMATION
            const Text(
              "Détails des frais",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 12),
            _buildFeesCard(),
            const SizedBox(height: 24),

            // 5. HISTORIQUE DES PAIEMENTS
            const Text(
              "Historique des paiements",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
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
    );
  }

  Widget _buildSynthesisCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "État global",
                style: TextStyle(color: AppColors.secondaryText, fontSize: 14),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
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
              _buildSynthesisItem("Total à payer", "900.000", AppColors.text),
              Container(width: 1, height: 40, color: AppColors.divider),
              _buildSynthesisItem("Montant payé", "450.000", AppColors.success),
              Container(width: 1, height: 40, color: AppColors.divider),
              _buildSynthesisItem(
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

  Widget _buildSynthesisItem(String label, String amount, Color amountColor) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.secondaryText,
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
          const Text(
            "FCFA",
            style: TextStyle(color: AppColors.secondaryText, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _buildFeesCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _buildFeeRow("Frais d'inscription", "50.000 FCFA"),
          const Divider(height: 24, color: AppColors.divider),
          _buildFeeRow("Scolarité annuelle", "850.000 FCFA"),
          const Divider(height: 24, color: AppColors.divider),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Total formation",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
              Text(
                "900.000 FCFA",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeeRow(String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 14),
        ),
        Text(
          amount,
          style: const TextStyle(
            color: AppColors.text,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
