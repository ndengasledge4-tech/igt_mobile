import '../core/constants/assets.dart';

class MockNewsItem {
  final String title;
  final String excerpt;
  final String category;
  final String date;
  final String time;
  final String imageAsset;
  final int likes;
  final int comments;

  const MockNewsItem({
    required this.title,
    required this.excerpt,
    required this.category,
    required this.date,
    required this.time,
    required this.imageAsset,
    required this.likes,
    required this.comments,
  });
}

abstract final class MockNewsData {
  const MockNewsData._();

  static const featured = MockNewsItem(
    title: 'Cérémonie de remise de diplômes — Promotion 2025',
    excerpt:
        'La cérémonie de remise des diplômes aura lieu dans l’amphithéâtre principal de l’IGT.',
    category: 'Événement',
    date: '28 juillet 2025',
    time: '10h00',
    imageAsset: AppAssets.newsPrimary,
    likes: 148,
    comments: 34,
  );

  static const announcement = MockNewsItem(
    title: 'Calendrier des examens du premier semestre',
    excerpt:
        'Le calendrier officiel est disponible avec les dates et les salles de chaque filière.',
    category: 'Annonce',
    date: '20 juillet 2025',
    time: '08h30',
    imageAsset: AppAssets.newsSecondary,
    likes: 82,
    comments: 12,
  );

  static const items = [featured, announcement];
}
