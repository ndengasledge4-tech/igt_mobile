import 'package:flutter/material.dart';

import 'lesson_card.dart';

class DailyTimetable extends StatelessWidget {
  const DailyTimetable({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: const [
        LessonCard(
          subject: "Algorithmique",
          time: "08:00 - 10:00",
          room: "Salle 12",
          teacher: "Dr. Karim Mansouri",
          color: Color(0xFF2563EB),
        ),

        LessonCard(
          subject: "Mathématiques Avancées",
          time: "10:15 - 12:15",
          room: "Amphi A",
          teacher: "Dr. Salima Brahmi",
          color: Color(0xFF16A34A),
        ),

        LessonCard(
          subject: "Base de Données",
          time: "14:00 - 16:00",
          room: "Laboratoire Info 2",
          teacher: "M. Amina Belhaj",
          color: Color(0xFFF59E0B),
        ),

        LessonCard(
          subject: "Gestion de Projet",
          time: "16:15 - 18:00",
          room: "Salle B5",
          teacher: "Mme. Nadia Trabelsi",
          color: Color(0xFF8B5CF6),
        ),
      ],
    );
  }
}
