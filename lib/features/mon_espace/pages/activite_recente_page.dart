import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';

class ActiviteRecentePage extends StatelessWidget {
  const ActiviteRecentePage({super.key});

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
          "Activité récente",
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
              "Consultez les appareils sur lesquels vous êtes connecté et l'historique de vos connexions.",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.secondaryText,
              ),
            ),
            const SizedBox(height: 24),
            
            _buildSectionHeader("APPAREIL ACTUEL"),
            _buildDeviceCard(
              deviceName: "iPhone 15 Pro (Cet appareil)",
              location: "Dakar, Sénégal",
              lastActive: "En ligne maintenant",
              icon: Icons.smartphone,
              isCurrent: true,
            ),
            const SizedBox(height: 24),

            _buildSectionHeader("APPAREILS CONNECTÉS"),
            _buildGroupedCard([
              _buildDeviceItem(
                deviceName: "MacBook Pro 16\"",
                location: "Dakar, Sénégal",
                lastActive: "Connecté le 12 Fév 2024",
                icon: Icons.laptop,
              ),
              _buildDeviceItem(
                deviceName: "Samsung Galaxy S23",
                location: "Saint-Louis, Sénégal",
                lastActive: "Connecté le 05 Fév 2024",
                icon: Icons.smartphone,
              ),
            ]),
            const SizedBox(height: 24),

            _buildSectionHeader("CONNEXIONS RÉCENTES"),
            _buildGroupedCard([
              _buildActivityItem(
                title: "Connexion réussie",
                subtitle: "Chrome sur Windows • Dakar",
                date: "Aujourd'hui à 09:41",
              ),
              _buildActivityItem(
                title: "Connexion réussie",
                subtitle: "App Mobile • iPhone 15 Pro",
                date: "Hier à 18:20",
              ),
              _buildActivityItem(
                title: "Nouvel appareil détecté",
                subtitle: "MacBook Pro • Dakar",
                date: "12 Fév 2024 à 14:05",
                isWarning: true,
              ),
            ]),
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
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.secondaryText,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildDeviceCard({
    required String deviceName,
    required String location,
    required String lastActive,
    required IconData icon,
    bool isCurrent = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isCurrent ? AppColors.primary.withOpacity(0.3) : AppColors.border.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.softBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deviceName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  "$location • $lastActive",
                  style: const TextStyle(fontSize: 12, color: AppColors.secondaryText),
                ),
              ],
            ),
          ),
          if (isCurrent)
            const Icon(Icons.check_circle, color: AppColors.success, size: 20),
        ],
      ),
    );
  }

  Widget _buildGroupedCard(List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          if (index == items.length - 1) return items[index];
          return Column(
            children: [
              items[index],
              const Divider(height: 1, indent: 60),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildDeviceItem({
    required String deviceName,
    required String location,
    required String lastActive,
    required IconData icon,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.softBlue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(deviceName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      subtitle: Text("$location • $lastActive", style: const TextStyle(fontSize: 11)),
      trailing: const Icon(Icons.chevron_right, size: 18, color: AppColors.hint),
    );
  }

  Widget _buildActivityItem({
    required String title,
    required String subtitle,
    required String date,
    bool isWarning = false,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isWarning ? const Color(0xFFFFEBEE) : AppColors.softBlue,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isWarning ? Icons.warning_amber_rounded : Icons.login_rounded,
          color: isWarning ? AppColors.error : AppColors.primary,
          size: 20,
        ),
      ),
      title: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isWarning ? AppColors.error : AppColors.text)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle, style: const TextStyle(fontSize: 11)),
          Text(date, style: const TextStyle(fontSize: 10, color: AppColors.hint)),
        ],
      ),
    );
  }
}
