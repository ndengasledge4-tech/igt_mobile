import 'package:flutter/material.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final videos = [
      {
        'titre': 'Introduction au cours',
        'description':
        'Découvrez les notions générales et les objectifs du cours.',
        'duree': '12:45',
      },
      {
        'titre': 'Notions fondamentales',
        'description':
        'Explication des concepts fondamentaux à connaître avant de continuer.',
        'duree': '18:20',
      },
      {
        'titre': 'Concepts avancés',
        'description':
        'Approfondissement des notions importantes du cours avec des exemples.',
        'duree': '24:10',
      },
      {
        'titre': 'Travaux pratiques',
        'description':
        'Démonstration pratique et explication des différentes étapes.',
        'duree': '15:35',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FB),
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Vidéos',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(
          16,
          8,
          16,
          24,
        ),
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];

          return _VideoCard(
            titre: video['titre']!,
            description: video['description']!,
            duree: video['duree']!,
            onTap: () {
              // La lecture vidéo sera ajoutée ici.
            },
          );
        },
      ),
    );
  }
}

// ============================================================
// CARTE VIDÉO
// ============================================================

class _VideoCard extends StatelessWidget {
  final String titre;
  final String description;
  final String duree;
  final VoidCallback onTap;

  const _VideoCard({
    required this.titre,
    required this.description,
    required this.duree,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),

      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE6EAF0),
          ),
        ),
        clipBehavior: Clip.antiAlias,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ==================================================
            // MINIATURE VIDÉO
            // ==================================================

            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 190,
                  color: const Color(0xFFEAF5FC),

                  child: const Center(
                    child: Icon(
                      Icons.play_circle_fill,
                      size: 64,
                      color: Color(0xFF1989D5),
                    ),
                  ),
                ),

                // Durée
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      duree,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ==================================================
            // INFORMATIONS
            // ==================================================

            Padding(
              padding: const EdgeInsets.all(14),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    titre,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF202124),
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.45,
                      color: Color(0xFF737981),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: const [
                      Icon(
                        Icons.play_arrow_outlined,
                        size: 17,
                        color: Color(0xFF1989D5),
                      ),

                      SizedBox(width: 5),

                      Text(
                        'Regarder la vidéo',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1989D5),
                        ),
                      ),
                    ],
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