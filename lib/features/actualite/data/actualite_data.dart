import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../widgets/actualite_card.dart';

abstract final class ActualiteData {
  const ActualiteData._();

  static const List<ActualiteItem> actualites = [
    ActualiteItem(
      title: "L'IGT lance son nouveau programme de formation en IA",
      date: '17 Nov. 2025',
      detailDate: '17 novembre 2025',
      excerpt:
          "L'IGT enrichit son offre pédagogique avec un nouveau module d'intelligence artificielle.",
      content:
          "L'Institut de Gestion et de Technologie enrichit son offre pédagogique avec un nouveau module d'intelligence artificielle intégré à plusieurs formations à partir du Semestre 4.\n\nCe programme couvre les fondamentaux du machine learning, le traitement du langage naturel et les applications pratiques de l'IA dans le domaine de la gestion.",
      category: ActualiteCategory.actualite,
      icon: Icons.smart_toy_outlined,
      iconBackground: AppColors.primary,
      emoji: '🤖',
      subtitle: 'Direction pédagogique',
      objective:
          'Préparer les étudiants aux métiers du numérique en leur offrant des compétences en IA appliquée.',
      emphasisPhrases: ["nouveau module d'intelligence artificielle"],
    ),
    ActualiteItem(
      title: 'Résultats des examens de rattrapage publiés',
      date: '12 Nov. 2025',
      detailDate: '12 novembre 2025',
      excerpt:
          'Les résultats sont accessibles dans la rubrique Académie > Mes résultats.',
      content:
          "Les résultats des examens de rattrapage sont disponibles dans la rubrique Académie > Mes résultats. Chaque étudiant peut consulter ses notes et vérifier la validation du semestre concerné.\n\nLes demandes de vérification sont reçues par le service académique pendant la période indiquée.",
      category: ActualiteCategory.actualite,
      icon: Icons.bar_chart_rounded,
      iconBackground: AppColors.primaryLight,
      emoji: '📊',
      subtitle: 'Service académique',
      emphasisPhrases: ['Académie > Mes résultats'],
    ),
    ActualiteItem(
      title: 'Bienvenue aux nouveaux étudiants 2025/2026',
      date: '05 Sep. 2025',
      detailDate: '05 septembre 2025',
      excerpt:
          "L'IGT accueille sa nouvelle promotion avec 300 nouveaux étudiants.",
      content:
          "L'IGT accueille sa nouvelle promotion 2025/2026 avec 300 nouveaux étudiants. Les journées d'orientation permettent de découvrir les services, les équipes pédagogiques et les démarches essentielles.\n\nDes séances d'intégration sont prévues pour accompagner les étudiants dans leurs premières semaines de cours.",
      category: ActualiteCategory.actualite,
      icon: Icons.celebration_outlined,
      iconBackground: AppColors.success,
      emoji: '🎉',
      subtitle: 'Direction des études',
      emphasisPhrases: ['300 nouveaux étudiants'],
    ),
  ];

  static const List<ActualiteItem> annonces = [
    ActualiteItem(
      title: 'Inscription aux examens du S3 — Important',
      detailTitle: 'Inscription aux examens du Semestre 3',
      date: '17 Nov. 2025',
      detailDate: '17 novembre 2025',
      excerpt:
          "Les inscriptions aux examens du Semestre 3 sont ouvertes jusqu'au 25 novembre.",
      content:
          'Les inscriptions aux examens du Semestre 3 sont ouvertes du 18 au 25 novembre 2025. Tous les étudiants de 2ème année sont concernés.',
      category: ActualiteCategory.annonce,
      icon: Icons.description_outlined,
      iconBackground: AppColors.warning,
      emoji: '📋',
      subtitle: 'Service académique',
      badge: 'Important',
      topNotice: '⚠ Publication importante',
      alertTitle: '⚠ Date limite',
      alertText:
          'Tout étudiant non inscrit avant le 25 novembre ne pourra pas passer les examens.',
      documents: [
        'Carte étudiant valide',
        'Reçu de paiement S3',
        "Photo d'identité récente",
      ],
      emphasisPhrases: [
        '18 au 25 novembre 2025',
        'Tous les étudiants de 2ème année sont concernés.',
      ],
    ),
    ActualiteItem(
      title: 'Fermeture exceptionnelle le vendredi 22 novembre',
      date: '10 Nov. 2025',
      detailDate: '10 novembre 2025',
      excerpt:
          "L'établissement sera fermé le 22 novembre 2025 pour travaux de maintenance.",
      content:
          "L'établissement sera exceptionnellement fermé le vendredi 22 novembre 2025. Les services administratifs, les salles de cours et les espaces étudiants ne seront pas accessibles durant cette journée.",
      category: ActualiteCategory.annonce,
      icon: Icons.lock_outline_rounded,
      iconBackground: AppColors.primaryLight,
      emoji: '🔒',
      subtitle: 'Direction administrative',
      alertTitle: '⚠ Reprise des activités',
      alertText:
          'Les cours et services reprendront normalement le lundi suivant.',
      documents: [
        'Consulter les messages de son responsable',
        'Reporter les rendez-vous administratifs',
      ],
      emphasisPhrases: ['vendredi 22 novembre 2025'],
    ),
    ActualiteItem(
      title: 'Stage obligatoire — Guide et procédures',
      detailTitle: 'Stage obligatoire - Guide et procédures',
      date: '08 Nov. 2025',
      detailDate: '08 novembre 2025',
      excerpt:
          'Consultez le guide du stage de fin d’année disponible en téléchargement.',
      content:
          "Le guide du stage obligatoire précise les étapes de dépôt, les délais et les pièces attendues. Les étudiants concernés doivent préparer leur dossier avant transmission au service pédagogique.",
      category: ActualiteCategory.annonce,
      icon: Icons.folder_open_outlined,
      iconBackground: AppColors.warning,
      emoji: '🗂️',
      subtitle: 'Service pédagogique',
      alertTitle: '⚠ Dépôt obligatoire',
      alertText: 'Tout dossier incomplet sera retourné pour correction.',
      documents: ['Convention de stage', 'Fiche de suivi', 'CV à jour'],
      emphasisPhrases: ['dépôt', 'pièces attendues'],
    ),
  ];

  static const List<ActualiteItem> evenements = [
    ActualiteItem(
      title: 'Journée portes ouvertes IGT 2025',
      date: '15 Nov. 2025',
      detailDate: '15 novembre 2025',
      time: '09h00 – 17h00',
      location: 'Campus principal',
      excerpt:
          "Venez découvrir l'IGT lors de notre journée portes ouvertes annuelle.",
      content:
          "L'IGT vous ouvre ses portes pour une journée exceptionnelle de découverte. Venez rencontrer nos équipes, visiter nos laboratoires et en apprendre plus sur nos formations.",
      category: ActualiteCategory.evenement,
      icon: Icons.home_work_outlined,
      iconBackground: AppColors.success,
      emoji: '🏫',
      subtitle: 'Campus principal IGT',
      program: [
        ProgramStep(
          time: '09h00',
          description: "Accueil et présentation de l'IGT",
        ),
        ProgramStep(time: '10h00', description: 'Visite guidée du campus'),
        ProgramStep(time: '12h00', description: 'Pause déjeuner'),
        ProgramStep(time: '14h00', description: 'Tables rondes par formation'),
        ProgramStep(time: '16h00', description: 'Questions / Réponses'),
        ProgramStep(time: '17h00', description: 'Clôture'),
      ],
    ),
    ActualiteItem(
      title: 'Conférence : Numérique & Emploi en Afrique',
      date: '25 Nov. 2025',
      detailDate: '25 novembre 2025',
      time: '14h00 – 17h00',
      location: 'Amphi A',
      excerpt:
          "Intervenants de haut niveau pour discuter du marché de l'emploi numérique.",
      content:
          "Cette conférence réunit des intervenants du secteur numérique pour présenter les métiers émergents, les compétences attendues et les opportunités professionnelles en Afrique.",
      category: ActualiteCategory.evenement,
      icon: Icons.mic_external_on_outlined,
      iconBackground: AppColors.primaryLight,
      emoji: '🎤',
      subtitle: 'Amphi A',
      program: [
        ProgramStep(time: '14h00', description: 'Accueil des participants'),
        ProgramStep(time: '14h30', description: 'Panel des intervenants'),
        ProgramStep(time: '16h00', description: 'Questions du public'),
        ProgramStep(time: '17h00', description: 'Clôture'),
      ],
    ),
    ActualiteItem(
      title: 'Remise des diplômes — Promotion 2025',
      detailTitle: 'Remise des diplômes - Promotion 2025',
      date: '10 Déc. 2025',
      detailDate: '10 décembre 2025',
      time: '10h00',
      location: 'Salle des fêtes',
      excerpt:
          'Cérémonie officielle de remise des diplômes de la promotion 2025.',
      content:
          "La cérémonie officielle de remise des diplômes célébrera les lauréats de la promotion 2025 en présence des familles, de l'administration et des partenaires de l'institut.",
      category: ActualiteCategory.evenement,
      icon: Icons.school_outlined,
      iconBackground: AppColors.primaryLight,
      emoji: '🎓',
      subtitle: 'Salle des fêtes',
      program: [
        ProgramStep(time: '10h00', description: 'Accueil des invités'),
        ProgramStep(time: '11h00', description: 'Discours officiels'),
        ProgramStep(time: '11h30', description: 'Remise des diplômes'),
        ProgramStep(time: '12h30', description: 'Photos officielles'),
      ],
    ),
  ];

  static const List<ActualiteItem> infos = [
    ActualiteItem(
      title: "Horaires d'ouverture du secrétariat",
      date: '01 Sep. 2025',
      detailDate: '01/09/2025',
      excerpt: 'Lundi–Vendredi : 8h–16h. Samedi : 9h–12h. Fermé le dimanche.',
      content:
          "Le secrétariat accueille les étudiants pour les démarches administratives et le suivi des documents officiels.",
      category: ActualiteCategory.info,
      icon: Icons.schedule_outlined,
      iconBackground: AppColors.primaryLight,
      emoji: '🕘',
      subtitle: 'Info pratique',
      infoRows: [
        InfoRow(label: 'Lundi – Vendredi', value: '08h00 – 16h00'),
        InfoRow(label: 'Samedi', value: '09h00 – 12h00'),
        InfoRow(label: 'Dimanche', value: 'Fermé'),
      ],
      contacts: [
        ContactInfo(
          icon: Icons.phone_outlined,
          label: 'Téléphone',
          value: '+225 27 XX XX XX XX',
        ),
        ContactInfo(
          icon: Icons.email_outlined,
          label: 'Email',
          value: 'secretariat@igt.edu',
        ),
        ContactInfo(
          icon: Icons.location_on_outlined,
          label: 'Bureau',
          value: 'Bâtiment A, Bureau 105',
        ),
      ],
    ),
    ActualiteItem(
      title: 'Calendrier académique 2025/2026',
      date: '01 Sep. 2025',
      detailDate: '01/09/2025',
      excerpt:
          "Dates des cours, examens, congés et événements de l'année académique.",
      content:
          "Le calendrier académique 2025/2026 regroupe les périodes de cours, les semaines de révision, les sessions d'examens et les congés officiels.",
      category: ActualiteCategory.info,
      icon: Icons.calendar_month_outlined,
      iconBackground: AppColors.primaryLight,
      emoji: '🗓️',
      subtitle: 'Info académique',
      infoRows: [
        InfoRow(label: 'Rentrée', value: '15 septembre 2025'),
        InfoRow(label: 'Examens S1', value: '12 au 20 janvier 2026'),
        InfoRow(label: 'Congés', value: 'Selon calendrier officiel'),
      ],
    ),
    ActualiteItem(
      title: 'Règlement intérieur — Mise à jour 2025',
      detailTitle: 'Règlement intérieur - Mise à jour 2025',
      date: '01 Sep. 2025',
      detailDate: '01/09/2025',
      excerpt:
          "Consultez le règlement intérieur mis à jour pour l'année 2025/2026.",
      content:
          "Le règlement intérieur mis à jour précise les règles applicables aux étudiants dans les salles de cours, les espaces communs et les services administratifs.",
      category: ActualiteCategory.info,
      icon: Icons.article_outlined,
      iconBackground: AppColors.warning,
      emoji: '📜',
      subtitle: 'Info administrative',
      infoRows: [
        InfoRow(label: 'Présence', value: 'Assiduité obligatoire'),
        InfoRow(label: 'Document', value: 'Carte étudiant demandée'),
        InfoRow(label: 'Application', value: 'Année 2025/2026'),
      ],
    ),
  ];
}
