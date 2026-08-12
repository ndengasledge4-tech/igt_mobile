import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';

import 'inscription_examen_page.dart';
import 'journée_portes_ouvertes.dart';
import 'secretariat_page.dart';
import 'service_academique.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});

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
                        16,
                        8,
                        16,
                        14,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(22),
                          bottomRight: Radius.circular(22),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // Bonjour + notification
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [

                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Bonjour 👋",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),

                                  SizedBox(height: 2),

                                  Text(
                                    "Jean DUPONT",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.notifications_none,
                                  color: Colors.white,
                                  size: 21,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          // =================================================
                          // CARTE PROFIL
                          // =================================================

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.25),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _infoItem(
                                    "Matricule",
                                    "2024IG001",
                                  ),
                                ),

                                Expanded(
                                  child: _infoItem(
                                    "Formation",
                                    "Info. de Gestion",
                                  ),
                                ),

                                Expanded(
                                  child: _infoItem(
                                    "Niveau",
                                    "2ème année",
                                  ),
                                ),

                                Expanded(
                                  child: _infoItem(
                                    "Classe",
                                    "IG2",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // =====================================================
                    // PROCHAIN COURS
                    // =====================================================

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [

                            Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.08),
                                borderRadius:
                                BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.calendar_today_outlined,
                                color: AppColors.primary,
                                size: 18,
                              ),
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: const [

                                  Text(
                                    "PROCHAIN COURS - Aujourd'hui",
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),

                                  SizedBox(height: 2),

                                  Text(
                                    "Algorithmique avancée",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(height: 5),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 11,
                                        color: Colors.grey,
                                      ),

                                      SizedBox(width: 3),

                                      Text(
                                        "08h00 – 10h00",
                                        style: TextStyle(
                                          fontSize: 9,
                                          color: Colors.grey,
                                        ),
                                      ),

                                      SizedBox(width: 8),

                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 11,
                                        color: Colors.grey,
                                      ),

                                      SizedBox(width: 2),

                                      Text(
                                        "Salle A204",
                                        style: TextStyle(
                                          fontSize: 9,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 3),

                                  Text(
                                    "Prof. Mahamadou COULIBALY",
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 13),

                    // =====================================================
                    // MES COURS
                    // =====================================================

                    _sectionTitle(
                      "Mes cours",
                      "Voir plus",
                    ),

                    const SizedBox(height: 7),

                    SizedBox(
                      height: 88,
                      child: ListView(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10),
                        scrollDirection: Axis.horizontal,
                        children: [
                          _courseCard(
                            "Algorithmique",
                            "M. Coulibaly",
                            "S3",
                            "4 crédits",
                          ),
                          _courseCard(
                            "Bases de données",
                            "M. Diallo",
                            "S3",
                            "3 crédits",
                          ),
                          _courseCard(
                            "Réseaux",
                            "M. Traoré",
                            "S3",
                            "3 crédits",
                          ),
                          _courseCard(
                            "Génie logiciel",
                            "M. Koné",
                            "S3",
                            "4 crédits",
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // =====================================================
                    // DERNIÈRES NOTES
                    // =====================================================

                    _sectionTitle(
                      "Dernières notes",
                      "Voir plus",
                    ),

                    const SizedBox(height: 6),

                    _noteItem(
                      "Algorithmique",
                      "16.5 / 20",
                      true,
                    ),

                    _noteItem(
                      "Bases de données",
                      "12 / 20",
                      false,
                    ),

                    _noteItem(
                      "Réseaux",
                      "18 / 20",
                      true,
                    ),

                    const SizedBox(height: 18),

                    // =====================================================
                    // RÉSULTATS S3
                    // =====================================================

                    _sectionTitle(
                      "Résultats S3",
                      "Voir plus",
                    ),

                    const SizedBox(height: 7),

                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          _resultCard(
                            "15.2/20",
                            "Moyenne",
                          ),
                          _resultCard(
                            "28/30",
                            "Crédits",
                          ),
                          _resultCard(
                            "Bien",
                            "Mention",
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // =====================================================
                    // ACTUALITÉS
                    // =====================================================

                    _sectionTitle(
                      "Actualités",
                      "Voir plus",
                    ),

                    const SizedBox(height: 7),

                    // INSCRIPTION EXAMENS
                    _newsItem(
                      context,
                      Icons.article_outlined,
                      "Inscription aux examens",
                      "Académique",
                      "Il y a 2h",
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

                    // JOURNÉE PORTES OUVERTES
                    _newsItem(
                      context,
                      Icons.event_available_outlined,
                      "Journée portes ouvertes",
                      "Événement",
                      "Hier",
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

                    const SizedBox(height: 16),

                    // =====================================================
                    // MESSAGES RÉCENTS
                    // =====================================================

                    _sectionTitle(
                      "Messages récents",
                      "Voir plus",
                    ),

                    const SizedBox(height: 7),

                    // SECRÉTARIAT
                    _messageItem(
                      context,
                      "S",
                      "Secrétariat",
                      "Votre dossier est prêt",
                      "10h30",
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

                    // SERVICE ACADÉMIQUE
                    _messageItem(
                      context,
                      "SA",
                      "Service académique",
                      "Nouvelle information disponible",
                      "Hier",
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

                    const SizedBox(height: 20),
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
  // INFORMATIONS ÉTUDIANT
  // ===========================================================

  static Widget _infoItem(
      String title,
      String value,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 7,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  // ===========================================================
  // TITRE DE SECTION
  // ===========================================================

  static Widget _sectionTitle(
      String title,
      String action,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            action,
            style: TextStyle(
              fontSize: 9,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
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
      width: 104,
      margin: const EdgeInsets.only(right: 7),
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 4),

          Text(
            professor,
            style: const TextStyle(
              fontSize: 7,
              color: Colors.grey,
            ),
          ),

          const Spacer(),

          Row(
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius:
                  BorderRadius.circular(4),
                ),
                child: Text(
                  semester,
                  style: const TextStyle(
                    fontSize: 7,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(width: 4),

              Text(
                credits,
                style: const TextStyle(
                  fontSize: 7,
                  color: Colors.grey,
                ),
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
        horizontal: 10,
        vertical: 3,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Text(
            subject,
            style: const TextStyle(
              fontSize: 9,
            ),
          ),
          Text(
            note,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: good
                  ? Colors.green.shade700
                  : Colors.orange.shade700,
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
        height: 68,
        margin:
        const EdgeInsets.only(right: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(9),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              label,
              style: const TextStyle(
                fontSize: 8,
                color: Colors.grey,
              ),
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
      borderRadius: BorderRadius.circular(9),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 4,
        ),
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius:
                BorderRadius.circular(7),
              ),
              child: Icon(
                icon,
                size: 18,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(width: 9),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Row(
                    children: [
                      Text(
                        category,
                        style: TextStyle(
                          fontSize: 7,
                          color: AppColors.primary,
                        ),
                      ),

                      const SizedBox(width: 5),

                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 7,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right,
              size: 18,
              color: Colors.grey,
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
      borderRadius: BorderRadius.circular(9),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 4,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 9,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color:
                AppColors.primary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                initials,
                style: TextStyle(
                  fontSize: 9,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 9),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    sender,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 8,
                      color: Colors.grey,
                    ),
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
                  style: const TextStyle(
                    fontSize: 7,
                    color: Colors.grey,
                  ),
                ),

                if (unread) ...[
                  const SizedBox(height: 4),

                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "3",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 7,
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