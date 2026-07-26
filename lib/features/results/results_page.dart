import 'package:flutter/material.dart';

import 'widgets/results_header.dart';
import 'widgets/results_summary_card.dart';
import 'widgets/subject_card.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: Column(
          children: [
            const ResultsHeader(),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: const [
                  ResultsSummaryCard(),

                  SizedBox(height: 24),

                  Text(
                    "DÉTAIL PAR MATIÈRE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),

                  SizedBox(height: 18),

                  SubjectCard(
                    subject: "Mathématiques Avancées",
                    teacher: "Dr. Salima Brahmi",
                    code: "MATH301",
                    grade: 15.5,
                    credits: 4,
                  ),

                  SizedBox(height: 14),

                  SubjectCard(
                    subject: "Algorithmique & Structures de Données",
                    teacher: "Dr. Karim Mansouri",
                    code: "INFO201",
                    grade: 17,
                    credits: 5,
                  ),

                  SizedBox(height: 14),

                  SubjectCard(
                    subject: "Gestion de Projet",
                    teacher: "Mme. Nadia Trabelsi",
                    code: "MGT202",
                    grade: 14,
                    credits: 3,
                  ),

                  SizedBox(height: 14),

                  SubjectCard(
                    subject: "Base de Données",
                    teacher: "M. Amina Belhaj",
                    code: "INFO202",
                    grade: 16.5,
                    credits: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}