import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';

class SessionsActivesPage extends StatelessWidget {
  const SessionsActivesPage({super.key});

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
          "Sessions actives",
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
            const Text(
              "Gérez les appareils connectés à votre compte et déconnectez-vous si nécessaire.",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.secondaryText,
              ),
            ),
            const SizedBox(height: 24),
            
            _buildSectionHeader("Ma session actuelle"),
            _buildCurrentSessionCard(),
            const SizedBox(height: 24),

            _buildSectionHeader("Autres sessions actives"),
            _buildOtherSessionItem(
              device: "Windows • Chrome",
              details: "Windows 11 • Navigateur Chrome",
              time: "Hier à 18:32",
              location: "Brazzaville, Congo",
              ip: "197.210.54.12",
              icon: Icons.laptop,
            ),
            _buildOtherSessionItem(
              device: "Samsung Galaxy A54",
              details: "Application mobile • Android 14",
              time: "12 mai 2025 à 21:15",
              location: "Pointe-Noire, Congo",
              ip: "41.216.98.76",
              icon: Icons.smartphone,
            ),
            _buildOtherSessionItem(
              device: "MacBook Air • Safari",
              details: "macOS Sonoma • Navigateur Safari",
              time: "8 mai 2025 à 14:20",
              location: "Paris, France",
              ip: "102.54.12.89",
              icon: Icons.laptop,
            ),
            
            const SizedBox(height: 16),
            _buildLogoutAllCard(),
            
            const SizedBox(height: 24),
            _buildInfoCard(
              icon: Icons.info_outline,
              text: "Besoin d'aide ?",
              subtext: "Si vous voyez une activité suspecte ou un appareil que vous ne reconnaissez pas, déconnectez-le immédiatement et modifiez votre mot de passe.",
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppColors.text,
        ),
      ),
    );
  }

  Widget _buildCurrentSessionCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.softBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.smartphone, color: AppColors.primary, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "iPhone 13",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            "Actuelle",
                            style: TextStyle(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "Application mobile • iOS 17.4",
                      style: TextStyle(fontSize: 13, color: AppColors.secondaryText),
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(Icons.access_time, "Connexion :", "Aujourd'hui à 09:41"),
                    _buildDetailRow(Icons.location_on_outlined, "Lieu :", "Brazzaville, Congo"),
                    _buildDetailRow(Icons.shield_outlined, "Adresse IP :", "197.210.54.23"),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.softBlue.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: const [
                Icon(Icons.info_outline, color: AppColors.primary, size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "C'est votre session actuelle. Elle ne peut pas être déconnectée.",
                    style: TextStyle(fontSize: 11, color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherSessionItem({
    required String device,
    required String details,
    required String time,
    required String location,
    required String ip,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.softBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.primary, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      device,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      details,
                      style: const TextStyle(fontSize: 12, color: AppColors.secondaryText),
                    ),
                    const SizedBox(height: 8),
                    _buildDetailRow(Icons.access_time, "Dernière activité :", time),
                    _buildDetailRow(Icons.location_on_outlined, "Lieu :", location),
                    _buildDetailRow(Icons.shield_outlined, "IP :", ip),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout, size: 14),
                label: const Text("Déconnecter", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.error,
                  backgroundColor: AppColors.error.withOpacity(0.05),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.hint),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.secondaryText)),
          const SizedBox(width: 4),
          Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildLogoutAllCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.error.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.delete_outline, color: AppColors.error, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Déconnecter toutes les autres sessions",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.error),
                ),
                Text(
                  "Vous serez déconnecté de tous vos appareils sauf celui que vous utilisez actuellement.",
                  style: TextStyle(fontSize: 11, color: AppColors.secondaryText),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.error, size: 20),
        ],
      ),
    );
  }

  Widget _buildInfoCard({required IconData icon, required String text, required String subtext}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtext,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
