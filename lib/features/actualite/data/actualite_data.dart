import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';

abstract final class ActualiteData {
  const ActualiteData._();

  static const List<Map<String, dynamic>> actualites = [
    {
      'category': 'actualite',
      'title': 'Rentrée académique 2026-2027',
      'date': '14 août 2026',
      'excerpt':
          'Découvrez les informations importantes concernant la prochaine rentrée académique.',
      'detailTitle': 'Rentrée académique 2026-2027',
      'content':
          'La rentrée académique 2026-2027 approche. Retrouvez toutes les informations utiles pour préparer votre rentrée dans les meilleures conditions.',
      'icon': Icons.school_outlined,
      'iconBackground': AppColors.primary,
    },
    {
      'category': 'actualite',
      'title': 'Nouvelles ressources disponibles',
      'date': '12 août 2026',
      'excerpt':
          'De nouvelles ressources pédagogiques sont désormais accessibles.',
      'detailTitle': 'Nouvelles ressources pédagogiques',
      'content':
          'De nouvelles ressources pédagogiques sont maintenant disponibles sur votre espace étudiant.',
      'icon': Icons.menu_book_outlined,
      'iconBackground': AppColors.primary,
    },
  ];

  static const List<Map<String, dynamic>> annonces = [
    {
      'category': 'annonce',
      'title': 'Dépôt des dossiers administratifs',
      'date': '14 août 2026',
      'excerpt':
          'Les étudiants concernés sont invités à déposer leurs dossiers administratifs.',
      'detailTitle': 'Dépôt des dossiers administratifs',
      'content':
          'Les étudiants concernés doivent déposer leur dossier administratif complet auprès du service concerné.',
      'badge': 'Important',
      'topNotice': 'À ne pas manquer',
      'icon': Icons.campaign_outlined,
      'iconBackground': AppColors.error,
      'alertTitle': 'Attention',
      'alertText':
          'Assurez-vous que toutes les pièces demandées sont présentes dans votre dossier.',
      'documents': [
        'Copie de la pièce d’identité',
        'Certificat de scolarité',
        'Photo d’identité',
      ],
    },
  ];

  static const List<Map<String, dynamic>> evenements = [
    {
      'category': 'evenement',
      'title': 'Journée d’intégration',
      'date': '20 août 2026',
      'time': '09:00',
      'location': 'Campus principal',
      'subtitle': 'Campus principal',
      'excerpt':
          'Participez à la journée d’intégration destinée aux nouveaux étudiants.',
      'detailTitle': 'Journée d’intégration des étudiants',
      'content':
          'Une journée d’intégration est organisée afin de permettre aux nouveaux étudiants de découvrir leur environnement académique.',
      'icon': Icons.event_outlined,
      'iconBackground': AppColors.success,
      'program': [
        {'time': '09:00', 'description': 'Accueil des participants'},
        {'time': '10:00', 'description': 'Présentation de l’établissement'},
        {'time': '11:30', 'description': 'Visite du campus'},
        {'time': '13:00', 'description': 'Pause déjeuner'},
      ],
    },
  ];

  static const List<Map<String, dynamic>> infos = [
    {
      'category': 'info',
      'title': 'Horaires du service scolarité',
      'date': 'En vigueur',
      'subtitle': 'Info pratique',
      'excerpt': 'Retrouvez les horaires habituels du service de scolarité.',
      'detailTitle': 'Horaires du service de scolarité',
      'detailDate': '1er août 2026',
      'icon': Icons.info_outline_rounded,
      'iconBackground': AppColors.primaryDark,
      'infoRows': [
        {'label': 'Lundi - Vendredi', 'value': '08:00 - 16:00'},
        {'label': 'Samedi', 'value': '08:00 - 12:00'},
      ],
      'contacts': [
        {'label': 'Téléphone', 'value': '+242 00 000 00 00'},
        {'label': 'Email', 'value': 'scolarite@universite.cg'},
      ],
    },
  ];
}
