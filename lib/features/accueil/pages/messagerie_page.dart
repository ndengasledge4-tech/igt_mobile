import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';

import 'secretariat_page.dart';
import 'service_academique.dart';

class MessageriePage extends StatelessWidget {
  const MessageriePage({super.key});

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

                              // =============================================
                              // FLÈCHE DE RETOUR + TITRE
                              // =============================================

                              Row(
                                children: [

                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.15),
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    width: AppDimensions.sm,
                                  ),

                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [

                                      Text(
                                        'Messagerie',
                                        style:
                                        AppTextStyles.title.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),

                                      const SizedBox(
                                        height: AppDimensions.xs,
                                      ),

                                      Text(
                                        '2 messages non lus',
                                        style:
                                        AppTextStyles.caption.copyWith(
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // =================================================
                              // NOUVEAU MESSAGE
                              // =================================================

                              GestureDetector(
                                onTap: () {
                                  _nouveauMessage(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppDimensions.sm,
                                    vertical: AppDimensions.xs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(
                                      AppDimensions.radiusSmall,
                                    ),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.25),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [

                                      const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 15,
                                      ),

                                      const SizedBox(
                                        width: AppDimensions.xs,
                                      ),

                                      Text(
                                        'Nouveau',
                                        style:
                                        AppTextStyles.caption.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
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
                    // LISTE DES MESSAGES
                    // =====================================================

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.md,
                      ),
                      child: Column(
                        children: [

                          // =====================================================
                          // SECRÉTARIAT
                          // =====================================================

                          _messageItem(
                            context,
                            initials: 'S',
                            sender: 'Secrétariat',
                            subject: 'Demande de relevé de notes',
                            message:
                            'Votre document est prêt, vous pouvez...',
                            time: '10h30',
                            status: 'Traité',
                            unread: true,
                            unreadCount: '2',
                            statusColor: AppColors.success,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                  const SecretariatPage(),
                                ),
                              );
                            },
                          ),

                          // =====================================================
                          // SERVICE ACADÉMIQUE
                          // =====================================================

                          _messageItem(
                            context,
                            initials: 'SA',
                            sender: 'Service académique',
                            subject: 'Concernant mes notes de S3',
                            message:
                            'Nous avons bien reçu votre demande...',
                            time: 'Hier',
                            status: 'En cours',
                            unread: true,
                            unreadCount: '1',
                            statusColor: AppColors.warning,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                  const ServiceAcademiquePage(),
                                ),
                              );
                            },
                          ),

                          // =====================================================
                          // ADMINISTRATION
                          // =====================================================

                          _messageItem(
                            context,
                            initials: 'A',
                            sender: 'Administration',
                            subject: 'Question sur mon inscription',
                            message:
                            'Vous pouvez passer au bureau...',
                            time: 'Lun.',
                            status: 'Fermé',
                            unread: false,
                            unreadCount: '',
                            statusColor:
                            AppColors.secondaryText,
                            onTap: () {
                              _showMessage(
                                context,
                                'Conversation avec Administration',
                              );
                            },
                          ),

                          // =====================================================
                          // SUPPORT TECHNIQUE
                          // =====================================================

                          _messageItem(
                            context,
                            initials: 'ST',
                            sender: 'Support technique',
                            subject:
                            'Problème de connexion au portail',
                            message:
                            'Problème résolu de votre côté ?',
                            time: '12 Nov.',
                            status: 'Traité',
                            unread: false,
                            unreadCount: '',
                            statusColor: AppColors.success,
                            onTap: () {
                              _showMessage(
                                context,
                                'Conversation avec Support technique',
                              );
                            },
                          ),
                        ],
                      ),
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
  // MESSAGE
  // ===========================================================

  static Widget _messageItem(
      BuildContext context, {
        required String initials,
        required String sender,
        required String subject,
        required String message,
        required String time,
        required String status,
        required bool unread,
        required String unreadCount,
        required Color statusColor,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        AppDimensions.radiusMedium,
      ),
      child: Container(
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
          CrossAxisAlignment.center,
          children: [

            // =========================================================
            // AVATAR
            // =========================================================

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

            // =========================================================
            // CONTENU
            // =========================================================

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  // -----------------------------------------------------
                  // EXPÉDITEUR + HEURE
                  // -----------------------------------------------------

                  Row(
                    children: [

                      Expanded(
                        child: Text(
                          sender,
                          style:
                          AppTextStyles.title.copyWith(
                            fontSize: 15,
                          ),
                          maxLines: 1,
                          overflow:
                          TextOverflow.ellipsis,
                        ),
                      ),

                      const SizedBox(
                        width: AppDimensions.xs,
                      ),

                      Text(
                        time,
                        style:
                        AppTextStyles.caption,
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 2,
                  ),

                  // -----------------------------------------------------
                  // SUJET
                  // -----------------------------------------------------

                  Text(
                    subject,
                    style:
                    AppTextStyles.bodySmall.copyWith(
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,
                  ),

                  const SizedBox(
                    height: 2,
                  ),

                  // -----------------------------------------------------
                  // MESSAGE
                  // -----------------------------------------------------

                  Text(
                    message,
                    style:
                    AppTextStyles.bodySmall.copyWith(
                      color:
                      AppColors.secondaryText,
                    ),
                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,
                  ),

                  const SizedBox(
                    height: AppDimensions.xs,
                  ),

                  // -----------------------------------------------------
                  // STATUT + BADGE
                  // -----------------------------------------------------

                  Row(
                    children: [

                      Container(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: AppDimensions.xs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(
                            0.10,
                          ),
                          borderRadius:
                          BorderRadius.circular(
                            AppDimensions.radiusSmall,
                          ),
                        ),
                        child: Text(
                          status,
                          style:
                          AppTextStyles.caption.copyWith(
                            color: statusColor,
                            fontSize: 8,
                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),
                      ),

                      if (unread) ...[
                        const SizedBox(
                          width: AppDimensions.xs,
                        ),

                        Container(
                          width: 17,
                          height: 17,
                          decoration:
                          const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          alignment:
                          Alignment.center,
                          child: Text(
                            unreadCount,
                            style:
                            const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // -----------------------------------------------------
            // FLÈCHE
            // -----------------------------------------------------

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
  // NOUVEAU MESSAGE
  // ===========================================================

  static void _nouveauMessage(
      BuildContext context,
      ) {
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
          heightFactor: 0.80,
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

                  // =========================================================
                  // HEADER
                  // =========================================================

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [

                      Text(
                        'Nouvelle conversation',
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
                    height: AppDimensions.xs,
                  ),

                  // =========================================================
                  // ÉTAPE
                  // =========================================================

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
                      'Étape 1 sur 3 — Choisissez le service que vous souhaitez contacter.',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: AppDimensions.md,
                  ),

                  // =========================================================
                  // LISTE DES SERVICES
                  // =========================================================

                  _serviceItem(
                    context,
                    initials: 'S',
                    name: 'Secrétariat',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const SecretariatPage(),
                        ),
                      );
                    },
                  ),

                  _serviceItem(
                    context,
                    initials: 'SA',
                    name: 'Service académique',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const ServiceAcademiquePage(),
                        ),
                      );
                    },
                  ),

                  _serviceItem(
                    context,
                    initials: 'A',
                    name: 'Administration',
                    onTap: () {
                      Navigator.pop(context);
                      _showMessage(
                        context,
                        'Conversation avec Administration',
                      );
                    },
                  ),

                  _serviceItem(
                    context,
                    initials: 'SC',
                    name: 'Service communication',
                    onTap: () {
                      Navigator.pop(context);
                      _showMessage(
                        context,
                        'Conversation avec Service communication',
                      );
                    },
                  ),

                  _serviceItem(
                    context,
                    initials: 'ST',
                    name: 'Support / Admin.',
                    onTap: () {
                      Navigator.pop(context);
                      _showMessage(
                        context,
                        'Conversation avec Support technique',
                      );
                    },
                  ),

                  _serviceItem(
                    context,
                    initials: 'D',
                    name: 'Direction',
                    onTap: () {
                      Navigator.pop(context);
                      _showMessage(
                        context,
                        'Conversation avec Direction',
                      );
                    },
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
  // SERVICE ITEM
  // ===========================================================

  static Widget _serviceItem(
      BuildContext context, {
        required String initials,
        required String name,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        AppDimensions.radiusMedium,
      ),
      child: Container(
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
          children: [

            // =========================================================
            // AVATAR
            // =========================================================

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

            // =========================================================
            // NOM
            // =========================================================

            Expanded(
              child: Text(
                name,
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // =========================================================
            // FLÈCHE
            // =========================================================

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
  // MESSAGE SIMPLE
  // ===========================================================

  static void _showMessage(
      BuildContext context,
      String message,
      ) {
    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(
          seconds: 2,
        ),
      ),
    );
  }
}