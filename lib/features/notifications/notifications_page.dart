import 'package:flutter/material.dart';

import '../../app/theme/colors.dart';
import 'widgets/notification_app_bar.dart';
import 'widgets/notification_tile.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  static const notifications = [
    {
      "title": "Résultats disponibles",
      "subtitle":
          "Les notes du contrôle continu N°2 sont maintenant disponibles.",
      "time": "2h",
      "color": Color(0xFF4CAF50),
      "icon": Icons.monitor_heart_outlined,
      "unread": true,
    },
    {
      "title": "Nouveau document",
      "subtitle": "Le polycopié d'Algorithmique chapitre 6 a été mis en ligne.",
      "time": "5h",
      "color": Color(0xFF4285F4),
      "icon": Icons.description_outlined,
      "unread": false,
    },
    {
      "title": "Nouvelle actualité",
      "subtitle": "Conférence internationale sur l'IA — Inscriptions ouvertes.",
      "time": "Hier, 14:30",
      "color": Color(0xFF9C27B0),
      "icon": Icons.campaign_outlined,
      "unread": false,
    },
    {
      "title": "Modification de cours",
      "subtitle": "Le cours de Mathématiques du lundi 28 juillet est reporté.",
      "time": "Hier, 09:15",
      "color": Color(0xFFFF9800),
      "icon": Icons.event_outlined,
      "unread": false,
    },
    {
      "title": "Rappel important",
      "subtitle":
          "La date limite de paiement des frais de scolarité est le 31 juillet 2025.",
      "time": "25 Juil. 2025",
      "color": Color(0xFFE53935),
      "icon": Icons.error_outline,
      "unread": false,
    },
    {
      "title": "Document ajouté",
      "subtitle":
          "Le calendrier des examens S2 2025 est disponible en téléchargement.",
      "time": "24 Juil. 2025",
      "color": Color(0xFF4285F4),
      "icon": Icons.insert_drive_file_outlined,
      "unread": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          children: [
            const NotificationAppBar(),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 20),
                itemCount: notifications.length,
                separatorBuilder: (_, __) =>
                    const Divider(height: 1, color: AppColors.divider),
                itemBuilder: (context, index) {
                  final item = notifications[index];

                  return NotificationTile(
                    title: item["title"] as String,
                    subtitle: item["subtitle"] as String,
                    time: item["time"] as String,
                    icon: item["icon"] as IconData,
                    color: item["color"] as Color,
                    unread: item["unread"] as bool,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
