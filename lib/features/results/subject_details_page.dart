import 'package:flutter/material.dart';

import 'widgets/detail_header.dart';
import 'widgets/grade_card.dart';
import 'widgets/info_tile.dart';

class SubjectDetailsPage extends StatelessWidget {
  const SubjectDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      body: SafeArea(
        child: ListView(
          children: const [
            DetailHeader(),

            SizedBox(height: 20),

            GradeCard(),

            SizedBox(height: 20),

            InfoTile(
              icon: Icons.person,
              title: "Enseignant",
              value: "Dr. Salima Brahmi",
            ),

            InfoTile(
              icon: Icons.assignment,
              title: "Contrôle Continu",
              value: "16 /20",
            ),

            InfoTile(
              icon: Icons.description,
              title: "Examen Final",
              value: "15 /20",
            ),

            InfoTile(
              icon: Icons.bar_chart,
              title: "Moyenne",
              value: "15.5 /20",
            ),

            InfoTile(
              icon: Icons.workspace_premium,
              title: "Crédits",
              value: "4 Crédits",
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
