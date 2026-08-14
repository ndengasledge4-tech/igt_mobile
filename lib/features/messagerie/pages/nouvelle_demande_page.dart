import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';

Widget nouvelleDemandePage() {
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  final services = const [
    'Secrétariat',
    'Service académique',
    'Administration',
    'Service communication',
    'Support / Admin.',
    'Direction',
  ];

  final subjects = const [
    'Problème d’inscription',
    'Problème concernant le dossier',
    'Problème concernant les notes',
    'Question générale',
    'Problème de communication',
    'Problème technique',
    'Demande adressée à la direction',
    'Autre demande',
  ];

  // ============================================================
  // ÉTAT DE LA PAGE
  // IMPORTANT :
  // Ces variables sont en dehors du StatefulBuilder afin
  // qu'elles ne soient pas réinitialisées à chaque setState().
  // ============================================================

  int step = 0;
  String? selectedService;
  String? selectedSubject;
  bool isLoading = false;
  bool isSuccess = false;

  return StatefulBuilder(
    builder: (context, setState) {
      // ============================================================
      // RETOUR
      // ============================================================

      void goBack() {
        if (step == 0) {
          Navigator.of(context).pop();
          return;
        }

        setState(() {
          step -= 1;
          isSuccess = false;
        });
      }

      // ============================================================
      // ÉTAPE SUIVANTE
      // ============================================================

      void continueStep() {
        if (step < 2) {
          setState(() {
            step += 1;
            isSuccess = false;
          });
        }
      }

      // ============================================================
      // ENVOI
      // ============================================================

      Future<void> submit() async {
        setState(() {
          isLoading = true;
          isSuccess = false;
        });

        // Simulation d'un envoi
        await Future<void>.delayed(const Duration(milliseconds: 650));

        if (!context.mounted) {
          return;
        }

        setState(() {
          isLoading = false;
          isSuccess = true;
        });
      }

      // ============================================================
      // TEXTE D'INFORMATION
      // ============================================================

      String noticeText() {
        switch (step) {
          case 0:
            return 'Étape 1 sur 3 — Choisissez le service que vous souhaitez contacter.';
          case 1:
            return 'Étape 2 sur 3 — Choisissez le sujet de votre demande.';
          default:
            return 'Étape 3 sur 3 — Rédigez votre message.';
        }
      }

      return Scaffold(
        backgroundColor: AppColors.background,

        // ============================================================
        // CONTENU PRINCIPAL
        // ============================================================
        body: SafeArea(
          child: Column(
            children: [
              // ========================================================
              // BARRE DU HAUT
              // ========================================================
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  border: Border(bottom: BorderSide(color: AppColors.border)),
                ),
                child: Row(
                  children: [
                    SizedBox.square(
                      dimension: 32,
                      child: IconButton(
                        onPressed: goBack,
                        icon: const Icon(Icons.arrow_back_rounded, size: 16),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.softBlue,
                          foregroundColor: AppColors.primary,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        'Nouvelle conversation',
                        style: AppTextStyles.subtitle.copyWith(
                          color: AppColors.text,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ========================================================
              // CONTENU
              // ========================================================
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // ====================================================
                    // INFORMATIONS
                    // ====================================================
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.softBlue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.info_outline_rounded,
                            color: AppColors.primary,
                            size: 16,
                          ),

                          const SizedBox(width: 8),

                          Expanded(
                            child: Text(
                              noticeText(),
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.primary,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ====================================================
                    // ÉTAPE 1 : SERVICE
                    // ====================================================
                    if (step == 0)
                      Column(
                        children: services.map((value) {
                          final isSelected = selectedService == value;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Material(
                              color: isSelected
                                  ? AppColors.softBlue
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(12),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedService = value;
                                  });
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primary
                                          : AppColors.border,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          value,
                                          style: AppTextStyles.bodySmall
                                              .copyWith(
                                                color: AppColors.text,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),

                                      if (isSelected)
                                        const Icon(
                                          Icons.check_rounded,
                                          color: AppColors.primary,
                                          size: 16,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    // ====================================================
                    // ÉTAPE 2 : SUJET
                    // ====================================================
                    else if (step == 1)
                      Column(
                        children: subjects.map((value) {
                          final isSelected = selectedSubject == value;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Material(
                              color: isSelected
                                  ? AppColors.softBlue
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(12),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedSubject = value;
                                  });
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primary
                                          : AppColors.border,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          value,
                                          style: AppTextStyles.bodySmall
                                              .copyWith(
                                                color: AppColors.text,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),

                                      if (isSelected)
                                        const Icon(
                                          Icons.check_rounded,
                                          color: AppColors.primary,
                                          size: 16,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    // ====================================================
                    // ÉTAPE 3 : MESSAGE
                    // ====================================================
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ==============================================
                          // SUJET
                          // ==============================================
                          Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sujet',
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.text,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                TextField(
                                  controller: subjectController,
                                  minLines: 1,
                                  maxLines: 1,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.text,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Résumé de votre demande',
                                    hintStyle: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.hint,
                                    ),
                                    filled: true,
                                    fillColor: AppColors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 11,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: AppColors.border,
                                        width: 1.5,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: AppColors.primary,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // ==============================================
                          // MESSAGE
                          // ==============================================
                          Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Message',
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.text,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                TextField(
                                  controller: messageController,
                                  minLines: 6,
                                  maxLines: 6,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.text,
                                  ),
                                  decoration: InputDecoration(
                                    hintText:
                                        'Décrivez votre demande en détail...',
                                    hintStyle: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.hint,
                                    ),
                                    filled: true,
                                    fillColor: AppColors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 11,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: AppColors.border,
                                        width: 1.5,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: AppColors.primary,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // ==============================================
                          // PIÈCE JOINTE
                          // ==============================================
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pièce jointe (optionnel)',
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.text,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: AppColors.border,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Text(
                                    '+ Ajouter un fichier',
                                    style: AppTextStyles.caption.copyWith(
                                      color: AppColors.secondaryText,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // ==============================================
                          // SUCCÈS
                          // ==============================================
                          if (isSuccess) ...[
                            const SizedBox(height: 8),

                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.success.withValues(
                                  alpha: 0.12,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle_outline,
                                    color: AppColors.success,
                                    size: 18,
                                  ),

                                  const SizedBox(width: 8),

                                  Expanded(
                                    child: Text(
                                      'Votre demande a été envoyée avec succès.',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: AppColors.success,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                  ],
                ),
              ),

              // ============================================================
              // BOUTON DU BAS
              // ============================================================
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  border: Border(top: BorderSide(color: AppColors.border)),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    // Le bouton est toujours actif.
                    // Il est désactivé uniquement pendant l'envoi.
                    onPressed: isLoading
                        ? null
                        : step == 2
                        ? submit
                        : continueStep,

                    icon: isLoading
                        ? const SizedBox.square(
                            dimension: 16,
                            child: CircularProgressIndicator(
                              color: AppColors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Icon(
                            step == 2 ? Icons.send_rounded : null,
                            size: step == 2 ? 15 : 0,
                          ),

                    label: Text(
                      isLoading
                          ? 'Envoi...'
                          : step == 2
                          ? 'Envoyer'
                          : 'Continuer',
                    ),

                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      disabledBackgroundColor: AppColors.primaryLight,
                      disabledForegroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: AppTextStyles.button.copyWith(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
