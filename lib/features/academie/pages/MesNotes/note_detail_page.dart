import 'package:flutter/material.dart';
import '../MesResultats/resultat_detail_page.dart';

/// Alias de compatibilité vers le détail canonique d’une matière.
class NoteDetailPage extends StatelessWidget {
  final String titre;
  final String niveau;
  const NoteDetailPage({super.key, required this.titre, required this.niveau});
  @override
  Widget build(BuildContext context) => ResultatDetailPage(semestre: niveau);
}
