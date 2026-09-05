import 'package:flutter/material.dart';

enum LearningStatus { completed, inProgress, notStarted, locked }

class AcademicCourse {
  final String name;
  final String teacher;
  final String semester;
  final int credits;
  final int coefficient;
  final double progress;
  final String nextActivity;
  final IconData icon;
  final Color accent;

  const AcademicCourse({
    required this.name,
    required this.teacher,
    required this.semester,
    required this.credits,
    required this.coefficient,
    required this.progress,
    required this.nextActivity,
    required this.icon,
    required this.accent,
  });
}

class AcademicChapter {
  final String number;
  final String title;
  final double progress;
  final int resources;
  final LearningStatus status;

  const AcademicChapter({
    required this.number,
    required this.title,
    required this.progress,
    required this.resources,
    required this.status,
  });
}

class AcademicGrade {
  final String subject;
  final String teacher;
  final double continuous;
  final double practical;
  final double exam;
  final double average;
  final int coefficient;
  final int credits;
  final String comment;

  const AcademicGrade({
    required this.subject,
    required this.teacher,
    required this.continuous,
    required this.practical,
    required this.exam,
    required this.average,
    required this.coefficient,
    required this.credits,
    required this.comment,
  });
}

abstract final class AcademicCatalog {
  const AcademicCatalog._();

  static const courses = [
    AcademicCourse(
      name: 'Architecture logicielle',
      teacher: 'Pr Diane Bamba',
      semester: 'S6',
      credits: 5,
      coefficient: 3,
      progress: .72,
      nextActivity: 'Quiz du chapitre 4 · vendredi',
      icon: Icons.account_tree_rounded,
      accent: Color(0xFF2F7D78),
    ),
    AcademicCourse(
      name: 'Développement mobile',
      teacher: 'Dr Moussa Coulibaly',
      semester: 'S6',
      credits: 5,
      coefficient: 3,
      progress: .58,
      nextActivity: 'TP interfaces · demain, 10:00',
      icon: Icons.phone_android_rounded,
      accent: Color(0xFF3478A8),
    ),
    AcademicCourse(
      name: 'Sécurité des réseaux',
      teacher: 'Mme Aminata Koné',
      semester: 'S6',
      credits: 4,
      coefficient: 2,
      progress: .86,
      nextActivity: 'Vidéo : cryptographie appliquée',
      icon: Icons.security_rounded,
      accent: Color(0xFF7766A6),
    ),
    AcademicCourse(
      name: 'Gestion de projet',
      teacher: 'M. Karim Mansouri',
      semester: 'S6',
      credits: 3,
      coefficient: 2,
      progress: .41,
      nextActivity: 'Dossier de cadrage · 2 septembre',
      icon: Icons.view_kanban_rounded,
      accent: Color(0xFFB87512),
    ),
  ];

  static const chapters = [
    AcademicChapter(
      number: '01',
      title: 'Principes et vocabulaire',
      progress: 1,
      resources: 4,
      status: LearningStatus.completed,
    ),
    AcademicChapter(
      number: '02',
      title: 'Patrons de conception',
      progress: .65,
      resources: 6,
      status: LearningStatus.inProgress,
    ),
    AcademicChapter(
      number: '03',
      title: 'Architecture en couches',
      progress: 0,
      resources: 5,
      status: LearningStatus.notStarted,
    ),
    AcademicChapter(
      number: '04',
      title: 'Systèmes distribués',
      progress: 0,
      resources: 3,
      status: LearningStatus.locked,
    ),
  ];

  static const grades = [
    AcademicGrade(
      subject: 'Architecture logicielle',
      teacher: 'Pr Diane Bamba',
      continuous: 15.5,
      practical: 17,
      exam: 14.5,
      average: 15.3,
      coefficient: 3,
      credits: 5,
      comment:
          'Très bonne maîtrise des principes. Poursuivez l’effort sur les diagrammes.',
    ),
    AcademicGrade(
      subject: 'Développement mobile',
      teacher: 'Dr Moussa Coulibaly',
      continuous: 17,
      practical: 18,
      exam: 15,
      average: 16.4,
      coefficient: 3,
      credits: 5,
      comment: 'Travail régulier et livrables soignés.',
    ),
    AcademicGrade(
      subject: 'Sécurité des réseaux',
      teacher: 'Mme Aminata Koné',
      continuous: 13,
      practical: 14.5,
      exam: 12,
      average: 12.8,
      coefficient: 2,
      credits: 4,
      comment:
          'Les fondamentaux sont acquis. Renforcez la partie cryptographie.',
    ),
    AcademicGrade(
      subject: 'Gestion de projet',
      teacher: 'M. Karim Mansouri',
      continuous: 10,
      practical: 12,
      exam: 8.5,
      average: 9.8,
      coefficient: 2,
      credits: 3,
      comment: 'Un rattrapage ciblé est recommandé.',
    ),
  ];
}
