import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';
import '../widgets/paiement_card.dart';

class HistoriquePaiementsPage extends StatelessWidget {
  const HistoriquePaiementsPage({super.key});

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
          "Historique des paiements",
          style: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
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
    );
  }
}
