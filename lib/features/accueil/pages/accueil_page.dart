import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';

import 'inscription_examen_page.dart';
import 'journée_portes_ouvertes.dart';
import 'secretariat_page.dart';
import 'service_academique.dart';

// Pages ouvertes par "Voir plus"
import 'mes_cours_page.dart';
import 'mes_notes_page.dart';
import 'actualites_page.dart';
import 'resultats_page.dart';
import 'messagerie_page.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  // Variable pour simuler le statut de l'étudiant
  bool _isStudentInGoodStanding = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // =====================================================
                    // HEADER
                    // =====================================================

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(
                        AppDimensions.md,
                        AppDimensions.sm,
                        AppDimensions.md,
                        AppDimensions.md,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            AppDimensions.radiusLarge,
                          ),
                          bottomRight: Radius.circular(
                            AppDimensions.radiusLarge,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [

                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    'Bonjour 👋',
                                    style:
                                    AppTextStyles.caption.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: AppDimensions.xs,
                                  ),

                                  Text(
                                    'Jean DUPONT',
                                    style:
                                    AppTextStyles.title.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),

                              // =================================================
                              // NOTIFICATION
                              // =================================================

                              GestureDetector(
                                onTap: () {
                                  _showNotifications(context);
                                },
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [

                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color:
                                        Colors.white.withOpacity(0.15),
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.notifications_none,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),

                                    // Badge
                                    Positioned(
                                      top: -3,
                                      right: -3,
                                      child: Container(
                                        width: 15,
                                        height: 15,
                                        decoration:
                                        const BoxDecoration(
                                          color: AppColors.error,
                                          shape: BoxShape.circle,
                                        ),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          '3',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: AppDimensions.md,
                          ),

                          // =====================================================
                          // CARTE PROFIL
                          // =====================================================

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(
                              AppDimensions.md,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusMedium,
                              ),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.25),
                              ),
                            ),
                            child: Row(
                              children: [

                                Expanded(
                                  child: _infoItem(
                                    'Matricule',
                                    '2024IG001',
                                  ),
                                ),

                                Expanded(
                                  child: _infoItem(
                                    'Formation',
                                    'Info. de Gestion',
                                  ),
                                ),

                                Expanded(
                                  child: _infoItem(
                                    'Niveau',
                                    '2ème année',
                                  ),
                                ),

                                Expanded(
                                  child: _infoItem(
                                    'Classe',
                                    'IG2',
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: AppDimensions.xs),

                          // =====================================================
                          // STATUT ÉTUDIANT
                          // =====================================================

                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppDimensions.sm,
                                  vertical: AppDimensions.xs,
                                ),
                                decoration: BoxDecoration(
                                  color: _isStudentInGoodStanding
                                      ? Colors.green.withOpacity(0.20)
                                      : Colors.red.withOpacity(0.20),
                                  borderRadius: BorderRadius.circular(
                                    AppDimensions.radiusSmall,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _isStudentInGoodStanding
                                          ? Icons.check_circle_outline
                                          : Icons.warning_amber_outlined,
                                      color: _isStudentInGoodStanding
                                          ? Colors.green
                                          : Colors.red,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _isStudentInGoodStanding
                                          ? '✅ En règle'
                                          : '⚠️ Non en règle',
                                      style: AppTextStyles.caption.copyWith(
                                        color: _isStudentInGoodStanding
                                            ? Colors.green
                                            : Colors.red,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Bouton pour basculer le statut (UI simple)
                              const SizedBox(width: AppDimensions.sm),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isStudentInGoodStanding = !_isStudentInGoodStanding;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppDimensions.sm,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(
                                      AppDimensions.radiusSmall,
                                    ),
                                  ),
                                  child: Text(
                                    _isStudentInGoodStanding ? '🔓' : '🔒',
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: AppDimensions.md,
                    ),

                    // =====================================================
                    // PROCHAIN COURS
                    // =====================================================

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.md,
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(
                          AppDimensions.md,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusMedium,
                          ),
                          border: Border.all(
                            color: AppColors.border,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [

                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.softBlue,
                                borderRadius:
                                BorderRadius.circular(
                                  AppDimensions.radiusSmall,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.calendar_today_outlined,
                                color: AppColors.primary,
                                size: AppDimensions.iconSmall,
                              ),
                            ),

                            const SizedBox(
                              width: AppDimensions.sm,
                            ),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    "PROCHAIN COURS - Aujourd'hui",
                                    style:
                                    AppTextStyles.caption.copyWith(
                                      color:
                                      AppColors.secondaryText,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: AppDimensions.xs,
                                  ),

                                  Text(
                                    'Algorithmique avancée',
                                    style: AppTextStyles.title,
                                  ),

                                  const SizedBox(
                                    height: AppDimensions.xs,
                                  ),

                                  Row(
                                    children: [

                                      const Icon(
                                        Icons.access_time,
                                        size:
                                        AppDimensions.iconSmall,
                                        color:
                                        AppColors.secondaryText,
                                      ),

                                      const SizedBox(
                                        width: AppDimensions.xs,
                                      ),

                                      Text(
                                        '08h00 – 10h00',
                                        style:
                                        AppTextStyles.caption,
                                      ),

                                      const SizedBox(
                                        width: AppDimensions.sm,
                                      ),

                                      const Icon(
                                        Icons.location_on_outlined,
                                        size:
                                        AppDimensions.iconSmall,
                                        color:
                                        AppColors.secondaryText,
                                      ),

                                      const SizedBox(
                                        width: AppDimensions.xs,
                                      ),

                                      Expanded(
                                        child: Text(
                                          'Salle A204',
                                          style:
                                          AppTextStyles.caption,
                                          overflow:
                                          TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: AppDimensions.xs,
                                  ),

                                  Text(
                                    'Prof. Mahamadou COULIBALY',
                                    style:
                                    AppTextStyles.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: AppDimensions.lg,
                    ),

                    // =====================================================
                    // MES COURS
                    // =====================================================

                    _sectionTitle(
                      context,
                      'Mes cours',
                      'Voir plus',
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const MesCoursPage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                      height: AppDimensions.sm,
                    ),

                    SizedBox(
                      height: 110,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.md,
                        ),
                        scrollDirection: Axis.horizontal,
                        children: [

                          _courseCard(
                            'Algorithmique',
                            'M. Coulibaly',
                            'S3',
                            '4 crédits',
                          ),

                          _courseCard(
                            'Bases de données',
                            'M. Diallo',
                            'S3',
                            '3 crédits',
                          ),

                          _courseCard(
                            'Réseaux',
                            'M. Traoré',
                            'S3',
                            '3 crédits',
                          ),

                          _courseCard(
                            'Génie logiciel',
                            'M. Koné',
                            'S3',
                            '4 crédits',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: AppDimensions.lg,
                    ),

                    // =====================================================
                    // DERNIÈRES NOTES
                    // =====================================================

                    _sectionTitle(
                      context,
                      'Dernières notes',
                      'Voir plus',
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const MesNotesPage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                      height: AppDimensions.sm,
                    ),

                    _noteItem(
                      'Algorithmique',
                      '16.5 / 20',
                      true,
                    ),

                    _noteItem(
                      'Bases de données',
                      '12 / 20',
                      false,
                    ),

                    _noteItem(
                      'Réseaux',
                      '18 / 20',
                      true,
                    ),

                    const SizedBox(
                      height: AppDimensions.lg,
                    ),

                    // =====================================================
                    // RÉSULTATS S3 (conditionnel)
                    // =====================================================

                    if (_isStudentInGoodStanding) ...[
                      _sectionTitle(
                        context,
                        'Résultats S3',
                        'Voir plus',
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const ResultatsPage(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(
                        height: AppDimensions.sm,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.md,
                        ),
                        child: Row(
                          children: [

                            _resultCard(
                              '15.2/20',
                              'Moyenne',
                            ),

                            _resultCard(
                              '28/30',
                              'Crédits',
                            ),

                            _resultCard(
                              'Bien',
                              'Mention',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: AppDimensions.lg,
                      ),
                    ] else ...[
                      // =====================================================
                      // MESSAGE SI NON EN RÈGLE
                      // =====================================================

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.md,
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(
                            AppDimensions.md,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusMedium,
                            ),
                            border: Border.all(
                              color: AppColors.warning.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            children: [

                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.warning.withOpacity(0.10),
                                  borderRadius: BorderRadius.circular(
                                    AppDimensions.radiusSmall,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.lock_outline,
                                  color: AppColors.warning,
                                  size: AppDimensions.iconMedium,
                                ),
                              ),

                              const SizedBox(
                                width: AppDimensions.sm,
                              ),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      'Résultats indisponibles',
                                      style: AppTextStyles.title.copyWith(
                                        fontSize: 15,
                                      ),
                                    ),

                                    const SizedBox(
                                      height: AppDimensions.xs,
                                    ),

                                    Text(
                                      'Veuillez régulariser votre situation auprès du service académique pour accéder à vos résultats.',
                                      style: AppTextStyles.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: AppDimensions.lg,
                      ),
                    ],

                    // =====================================================
                    // ACTUALITÉS
                    // =====================================================

                    _sectionTitle(
                      context,
                      'Actualités',
                      'Voir plus',
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const ActualitesPage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                      height: AppDimensions.sm,
                    ),

                    _newsItem(
                      context,
                      Icons.article_outlined,
                      'Inscription aux examens',
                      'Académique',
                      'Il y a 2h',
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const InscriptionExamenPage(),
                          ),
                        );
                      },
                    ),

                    _newsItem(
                      context,
                      Icons.event_available_outlined,
                      'Journée portes ouvertes',
                      'Événement',
                      'Hier',
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const JourneePortesOuvertesPage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                      height: AppDimensions.lg,
                    ),

                    // =====================================================
                    // MESSAGES RÉCENTS
                    // =====================================================

                    _sectionTitle(
                      context,
                      'Messages récents',
                      'Voir plus',
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const MessageriePage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                      height: AppDimensions.sm,
                    ),

                    _messageItem(
                      context,
                      'S',
                      'Secrétariat',
                      'Votre dossier est prêt',
                      '10h30',
                      true,
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const SecretariatPage(),
                          ),
                        );
                      },
                    ),

                    _messageItem(
                      context,
                      'SA',
                      'Service académique',
                      'Nouvelle information disponible',
                      'Hier',
                      false,
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const ServiceAcademiquePage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                      height: AppDimensions.xl,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // NOTIFICATIONS
  // ===========================================================

  static void _showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            AppDimensions.radiusLarge,
          ),
          topRight: Radius.circular(
            AppDimensions.radiusLarge,
          ),
        ),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.75,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.lg,
                AppDimensions.md,
                AppDimensions.lg,
                AppDimensions.lg,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [

                      Text(
                        'Notifications',
                        style:
                        AppTextStyles.headline3,
                      ),

                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color:
                          AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: AppDimensions.sm,
                  ),

                  _notificationItem(
                    Icons.article_outlined,
                    'Inscription aux examens',
                    'Les inscriptions sont ouvertes.',
                    'Il y a 2h',
                  ),

                  _notificationItem(
                    Icons.event_available_outlined,
                    'Journée portes ouvertes',
                    'La journée portes ouvertes aura lieu le 29 août.',
                    'Hier',
                  ),

                  _notificationItem(
                    Icons.school_outlined,
                    'Service académique',
                    'Une nouvelle information est disponible.',
                    'Hier',
                  ),

                  const SizedBox(
                    height: AppDimensions.sm,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ===========================================================
  // ÉLÉMENT NOTIFICATION
  // ===========================================================

  static Widget _notificationItem(
      IconData icon,
      String title,
      String message,
      String time,
      ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        bottom: AppDimensions.sm,
      ),
      padding: const EdgeInsets.all(
        AppDimensions.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusMedium,
        ),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.softBlue,
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall,
              ),
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              color: AppColors.primary,
              size: AppDimensions.iconMedium,
            ),
          ),

          const SizedBox(
            width: AppDimensions.sm,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: AppTextStyles.title.copyWith(
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(
                  height: AppDimensions.xs,
                ),

                Text(
                  message,
                  style: AppTextStyles.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(
                  height: AppDimensions.xs,
                ),

                Text(
                  time,
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // INFORMATIONS ÉTUDIANT
  // ===========================================================

  static Widget _infoItem(
      String title,
      String value,
      ) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [

        Text(
          title,
          style: AppTextStyles.caption.copyWith(
            color: Colors.white70,
          ),
        ),

        const SizedBox(
          height: AppDimensions.xs,
        ),

        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  // ===========================================================
  // TITRE DE SECTION + VOIR PLUS
  // ===========================================================

  static Widget _sectionTitle(
      BuildContext context,
      String title,
      String action,
      VoidCallback onTap,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.md,
      ),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [

          Text(
            title,
            style: AppTextStyles.headline3,
          ),

          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(
              AppDimensions.radiusSmall,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.xs,
                vertical: AppDimensions.xs,
              ),
              child: Text(
                action,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // CARTE COURS
  // ===========================================================

  static Widget _courseCard(
      String title,
      String professor,
      String semester,
      String credits,
      ) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(
        right: AppDimensions.sm,
      ),
      padding: const EdgeInsets.all(
        AppDimensions.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusMedium,
        ),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style: AppTextStyles.title.copyWith(
              fontSize: 15,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(
            height: AppDimensions.xs,
          ),

          Text(
            professor,
            style: AppTextStyles.bodySmall,
          ),

          const Spacer(),

          Row(
            children: [

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.sm,
                  vertical: AppDimensions.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.softBlue,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusSmall,
                  ),
                ),
                child: Text(
                  semester,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(
                width: AppDimensions.sm,
              ),

              Text(
                credits,
                style: AppTextStyles.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // NOTES
  // ===========================================================

  static Widget _noteItem(
      String subject,
      String note,
      bool good,
      ) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.md,
        vertical: AppDimensions.xs,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.md,
        vertical: AppDimensions.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusSmall,
        ),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [

          Text(
            subject,
            style: AppTextStyles.body,
          ),

          Text(
            note,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: good
                  ? AppColors.success
                  : AppColors.warning,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // RÉSULTATS
  // ===========================================================

  static Widget _resultCard(
      String value,
      String label,
      ) {
    return Expanded(
      child: Container(
        height: 80,
        margin: const EdgeInsets.only(
          right: AppDimensions.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(
            AppDimensions.radiusMedium,
          ),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [

            Text(
              value,
              style: AppTextStyles.title.copyWith(
                color: AppColors.primary,
              ),
            ),

            const SizedBox(
              height: AppDimensions.xs,
            ),

            Text(
              label,
              style: AppTextStyles.caption,
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // ACTUALITÉ CLIQUABLE
  // ===========================================================

  static Widget _newsItem(
      BuildContext context,
      IconData icon,
      String title,
      String category,
      String date,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        AppDimensions.radiusMedium,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppDimensions.md,
          vertical: AppDimensions.xs,
        ),
        padding: const EdgeInsets.all(
          AppDimensions.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(
            AppDimensions.radiusMedium,
          ),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Row(
          children: [

            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.softBlue,
                borderRadius: BorderRadius.circular(
                  AppDimensions.radiusSmall,
                ),
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: AppDimensions.iconMedium,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(
              width: AppDimensions.sm,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: AppTextStyles.title.copyWith(
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(
                    height: AppDimensions.xs,
                  ),

                  Row(
                    children: [

                      Text(
                        category,
                        style:
                        AppTextStyles.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(
                        width: AppDimensions.sm,
                      ),

                      Text(
                        date,
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right,
              size: AppDimensions.iconMedium,
              color: AppColors.hint,
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // MESSAGE CLIQUABLE
  // ===========================================================

  static Widget _messageItem(
      BuildContext context,
      String initials,
      String sender,
      String message,
      String time,
      bool unread,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        AppDimensions.radiusMedium,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppDimensions.md,
          vertical: AppDimensions.xs,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.md,
          vertical: AppDimensions.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(
            AppDimensions.radiusMedium,
          ),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Row(
          children: [

            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: AppColors.softBlue,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                initials,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(
              width: AppDimensions.sm,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text(
                    sender,
                    style: AppTextStyles.title.copyWith(
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(
                    height: AppDimensions.xs,
                  ),

                  Text(
                    message,
                    style: AppTextStyles.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment:
              CrossAxisAlignment.end,
              children: [

                Text(
                  time,
                  style: AppTextStyles.caption,
                ),

                if (unread) ...[
                  const SizedBox(
                    height: AppDimensions.xs,
                  ),

                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}