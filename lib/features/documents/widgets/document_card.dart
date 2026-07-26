import 'package:flutter/material.dart';

class DocumentCard extends StatelessWidget {
  final String type;
  final String title;
  final String size;
  final String date;

  const DocumentCard({
    super.key,
    required this.type,
    required this.title,
    required this.size,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPdf = type.toUpperCase() == "PDF";

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          // Ouvrir le document
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: isPdf
                      ? const Color(0xFFFFF2F2)
                      : const Color(0xFFFFF6E5),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    type,
                    style: TextStyle(
                      color: isPdf
                          ? Colors.red
                          : Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Text(
                          size,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),

                        const SizedBox(width: 10),

                        const Text(
                          "•",
                          style: TextStyle(color: Colors.grey),
                        ),

                        const SizedBox(width: 10),

                        Text(
                          date,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  // Télécharger
                },
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF2FF),
                    borderRadius: BorderRadius.circular(21),
                  ),
                  child: const Icon(
                    Icons.download_rounded,
                    color: Color(0xFF2563EB),
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}