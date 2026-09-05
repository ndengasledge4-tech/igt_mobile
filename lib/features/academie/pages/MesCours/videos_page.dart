import 'package:flutter/material.dart';

import '../../../../shared/widgets/premium_ui.dart';
import '../../academic_catalog.dart';
import '../../widgets/academic_components.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({super.key});
  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  int? _playing;
  static const _videos = [
    ('Introduction et objectifs', '12:45', LearningStatus.completed),
    ('Patrons de conception', '18:20', LearningStatus.inProgress),
    ('Architecture en couches', '24:10', LearningStatus.notStarted),
    ('Systèmes distribués', '15:35', LearningStatus.locked),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: AppScreenHeader(
            eyebrow: 'Architecture logicielle',
            title: 'Vidéos',
            subtitle: '4 vidéos · 1 h 10 min',
            icon: Icons.play_circle_rounded,
            showBack: true,
          ),
        ),
        SliverToBoxAdapter(
          child: AppResponsiveContent(
            maxWidth: 760,
            child: Column(
              children: [
                if (_playing != null) ...[
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      key: const Key('mock-video-player'),
                      decoration: BoxDecoration(
                        color: const Color(0xFF091521),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Icon(
                            Icons.pause_circle_filled_rounded,
                            size: 58,
                            color: Colors.white,
                          ),
                          Positioned(
                            left: 16,
                            right: 16,
                            bottom: 14,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _videos[_playing!].$1,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 9),
                                const LinearProgressIndicator(
                                  value: .38,
                                  minHeight: 4,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                for (var i = 0; i < _videos.length; i++) ...[
                  AcademicResourceRow(
                    icon: Icons.play_arrow_rounded,
                    title: _videos[i].$1,
                    metadata: 'Vidéo · ${_videos[i].$2}',
                    status: _videos[i].$3,
                    onTap: () => setState(() => _playing = i),
                  ),
                  if (i != _videos.length - 1) const SizedBox(height: 10),
                ],
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
