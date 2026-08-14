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
  const AccueilPage({super.key});

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

              SectionHeader(
                title: 'Mes cours',
                onPressed: () {
                  // TODO: Naviguer vers MesCoursPage
                },
              ),

              const SizedBox(
                height: AppDimensions.sm,
              ),

              const CoursPreview(),

              const SizedBox(
                height: AppDimensions.lg,
              ),

              SectionHeader(
                title: 'Dernières notes',
                onPressed: () {
                  // TODO: Naviguer vers MesNotesPage
                },
              ),

              const SizedBox(
                height: AppDimensions.sm,
              ),

              const NotesPreview(),

              const SizedBox(
                height: AppDimensions.lg,
              ),

              SectionHeader(
                title: 'Résultats S3',
                onPressed: () {
                  // TODO: Naviguer vers ResultatsPage
                },
              ),

              const SizedBox(
                height: AppDimensions.sm,
              ),

              const ResultatsPreview(),

              const SizedBox(
                height: AppDimensions.lg,
              ),

              SectionHeader(
                title: 'Actualités',
                onPressed: () {
                  // TODO: Naviguer vers ActualitesPage
                },
              ),

              const SizedBox(
                height: AppDimensions.sm,
              ),

              ActualitesPreview(
                onFirstPressed: () {
                  // TODO: Naviguer vers InscriptionExamenPage
                },
                onSecondPressed: () {
                  // TODO: Naviguer vers JourneePortesOuvertesPage
                },
              ),

              const SizedBox(
                height: AppDimensions.lg,
              ),

              SectionHeader(
                title: 'Messages récents',
                onPressed: () {
                  // TODO: Naviguer vers MessageriePage
                },
              ),

              const SizedBox(
                height: AppDimensions.sm,
              ),

              MessagesPreview(
                onSecretariatPressed: () {
                  // TODO: Naviguer vers SecretariatPage
                },
                onAcademiquePressed: () {
                  // TODO: Naviguer vers ServiceAcademiquePage
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