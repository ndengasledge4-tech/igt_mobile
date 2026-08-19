import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';
import '../../../app/routes/route_names.dart';
import '../widgets/menu_espace_item.dart';

class MonEspacePage extends StatelessWidget {
  const MonEspacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // 1. En-tête bleu
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Row(
              children: [
                // Avatar carré aux coins fortement arrondis
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "JD",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Informations de l'étudiant
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Jean DUPONT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "2024IG001 · IG2",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Badge Étudiant actif
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: const Text(
                          "Étudiant actif",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. Corps de l'écran
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              children: [
                // Carte 1 : Profil
                MenuEspaceItem(
                  icon: Icons.person_outline,
                  title: "Profil",
                  subtitle: "Informations personnelles",
                  iconBgColor: const Color(0xFFE3F2FD),
                  iconColor: const Color(0xFF1976D2),
                  onTap: () => Navigator.pushNamed(context, RouteNames.profil),
                ),
                // Carte 2 : Situation financière
                MenuEspaceItem(
                  icon: Icons.credit_card_outlined,
                  title: "Situation financière",
                  subtitle: "Frais et paiements",
                  iconBgColor: const Color(0xFFE8F5E9),
                  iconColor: const Color(0xFF388E3C),
                  onTap: () => Navigator.pushNamed(
                    context,
                    RouteNames.situationFinanciere,
                  ),
                ),
                // Carte 3 : Historique des paiements
                MenuEspaceItem(
                  icon: Icons.history,
                  title: "Historique des paiements",
                  subtitle: "Tous vos paiements",
                  iconBgColor: const Color(0xFFFFF3E0),
                  iconColor: const Color(0xFFF57C00),
                  onTap: () => Navigator.pushNamed(
                    context,
                    RouteNames.historiquePaiements,
                  ),
                ),
                // Carte 4 : Paramètres
                MenuEspaceItem(
                  icon: Icons.settings_outlined,
                  title: "Paramètres",
                  subtitle: "Compte et préférences",
                  iconBgColor: const Color(0xFFF3E5F5),
                  iconColor: const Color(0xFF7B1FA2),
                  onTap: () =>
                      Navigator.pushNamed(context, RouteNames.parametres),
                ),
                const SizedBox(height: 24),
                // 3. Carte Déconnexion (séparée)
                MenuEspaceItem(
                  icon: Icons.logout,
                  title: "Déconnexion",
                  iconColor: AppColors.error,
                  iconBgColor: const Color(0xFFFFEBEE),
                  textColor: AppColors.error,
                  chevronColor: AppColors.error,
                  onTap: () {
                    // La navigation vers la déconnexion sera implémentée ultérieurement
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteNames.connexion,
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}