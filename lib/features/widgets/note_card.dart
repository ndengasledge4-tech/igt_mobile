import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final String nom;
  final String note;
  final String coefficient;
  final String credits;

  const NoteCard({
    super.key,
    required this.nom,
    required this.note,
    required this.coefficient,
    required this.credits,
  });

  @override
  Widget build(BuildContext context) {
    final double valeur = double.tryParse(note) ?? 0;
    final double progression = (valeur / 20).clamp(0.0, 1.0);

    Color noteColor;
    Color progressColor;

    if (valeur >= 15) {
      noteColor = const Color(0xFF3B9250);
      progressColor = const Color(0xFF3B9250);
    } else if (valeur < 12) {
      noteColor = const Color(0xFFD88B00);
      progressColor = const Color(0xFFD88B00);
    } else {
      noteColor = const Color(0xFF147DB8);
      progressColor = const Color(0xFF147DB8);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFE8E8E8),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nom,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF292929),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      'Coeff. $coefficient · $credits crédits',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF858585),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    note,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: noteColor,
                    ),
                  ),

                  const Text(
                    '/ 20',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF888888),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 9),

          Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: progression,
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: progressColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}