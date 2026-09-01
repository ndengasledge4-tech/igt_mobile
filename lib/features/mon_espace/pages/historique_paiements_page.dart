import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/premium_ui.dart';
import '../widgets/paiement_card.dart';

class HistoriquePaiementsPage extends StatelessWidget {
  const HistoriquePaiementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader.secondary(
        title: 'Historique des paiements',
        subtitle: 'Transactions et références',
      ),
      body: ListView(
        children: [
          AppResponsiveContent(
            child: Column(
              children: const [
                PaiementCard(
                  title: "Scolarité - Échéance 3",
                  date: "15 Janvier 2024",
                  amount: "150.000 FCFA",
                  status: "Payé",
                  statusColor: AppColors.success,
                  reference: "PAY-2024-003",
                  method: "Espèces",
                ),
                PaiementCard(
                  title: "Scolarité - Échéance 2",
                  date: "15 Décembre 2023",
                  amount: "150.000 FCFA",
                  status: "Payé",
                  statusColor: AppColors.success,
                  reference: "PAY-2023-045",
                  method: "Chèque",
                ),
                PaiementCard(
                  title: "Scolarité - Échéance 1",
                  date: "15 Novembre 2023",
                  amount: "150.000 FCFA",
                  status: "Payé",
                  statusColor: AppColors.success,
                  reference: "PAY-2023-012",
                  method: "Virement",
                ),
                PaiementCard(
                  title: "Frais d'inscription",
                  date: "05 Octobre 2023",
                  amount: "50.000 FCFA",
                  status: "Payé",
                  statusColor: AppColors.success,
                  reference: "INS-2023-001",
                  method: "Espèces",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
