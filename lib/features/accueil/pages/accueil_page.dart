import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';

import '../widgets/accueil_header.dart';
import '../widgets/actualites_preview.dart';
import '../widgets/cours_preview.dart';
import '../widgets/messages_preview.dart';
import '../widgets/notes_preview.dart';
import '../widgets/prochain_cours_card.dart';
import '../widgets/resultats_preview.dart';
import '../widgets/section_header.dart';

class AccueilPage extends StatelessWidget {
  final ValueChanged<int>? onNavigate;

  const AccueilPage({
    super.key,
    this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AccueilHeader(),

              const SizedBox(
                height: AppDimensions.lg,
              ),

              const ProchainCoursCard(),

              const SizedBox(
                height: AppDimensions.lg,
              ),

              // =====================================================
              // MES COURS
              // =====================================================

              SectionHeader(
                title: 'Mes cours',
                onPressed: () {
                  // Académie
                  onNavigate?.call(1);
                },
              ),

              const SizedBox(
                height: AppDimensions.sm,
              ),

              const CoursPreview(),

              const SizedBox(
                height: AppDimensions.lg,
              ),

              // =====================================================
              // MES NOTES
              // =====================================================

              SectionHeader(
                title: 'Dernières notes',
                onPressed: () {
                  // Académie
                  onNavigate?.call(1);
                },
              ),

              const SizedBox(
                height: AppDimensions.sm,
              ),

              const NotesPreview(),

              const SizedBox(
                height: AppDimensions.lg,
              ),

              // =====================================================
              // RÉSULTATS
              // =====================================================

              SectionHeader(
                title: 'Résultats S3',
                onPressed: () {
                  // Académie
                  onNavigate?.call(1);
                },
              ),

              const SizedBox(
                height: AppDimensions.sm,
              ),

              const ResultatsPreview(),

              const SizedBox(
                height: AppDimensions.lg,
              ),

              // =====================================================
              // ACTUALITÉS
              // =====================================================

              SectionHeader(
                title: 'Actualités',
                onPressed: () {
                  // Actualité
                  onNavigate?.call(2);
                },
              ),

              const SizedBox(
                height: AppDimensions.sm,
              ),

              ActualitesPreview(
                onFirstPressed: () {
                  onNavigate?.call(2);
                },
                onSecondPressed: () {
                  onNavigate?.call(2);
                },
              ),

              const SizedBox(
                height: AppDimensions.lg,
              ),

              // =====================================================
              // MESSAGES
              // =====================================================

              SectionHeader(
                title: 'Messages récents',
                onPressed: () {
                  // Messagerie
                  onNavigate?.call(3);
                },
              ),

              const SizedBox(
                height: AppDimensions.sm,
              ),

              MessagesPreview(
                onSecretariatPressed: () {
                  onNavigate?.call(3);
                },
                onAcademiquePressed: () {
                  onNavigate?.call(3);
                },
              ),

              const SizedBox(
                height: AppDimensions.xl,
              ),
            ],
          ),
        ),
      ),
    );
  }
}