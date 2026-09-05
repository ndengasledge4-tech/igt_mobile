import 'package:flutter/material.dart';

import '../../../app/theme/semantic_colors.dart';
import '../../../shared/widgets/premium_ui.dart';
import '../../communication/communication_store.dart';
import 'actualite_detail_page.dart';
import 'evenements_page.dart';

class ActualitePage extends StatefulWidget {
  final int initialIndex;
  const ActualitePage({super.key, this.initialIndex = 0});
  @override
  State<ActualitePage> createState() => _ActualitePageState();
}

class _ActualitePageState extends State<ActualitePage> {
  String _query = '';
  String _category = 'Toutes';

  @override
  Widget build(BuildContext context) {
    final store = CommunicationStore.instance;
    return AnimatedBuilder(
      animation: store,
      builder: (context, _) {
        final categories = [
          'Toutes',
          ...{for (final item in store.articles) item.category},
        ];
        final filtered = store.articles
            .where(
              (item) =>
                  (_category == 'Toutes' || item.category == _category) &&
                  (item.title.toLowerCase().contains(_query.toLowerCase()) ||
                      item.excerpt.toLowerCase().contains(
                        _query.toLowerCase(),
                      )),
            )
            .toList();
        final featured = filtered.where((item) => item.featured).firstOrNull;
        final editorial = filtered
            .where((item) => item.id != featured?.id)
            .toList();
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AppScreenHeader(
                  eyebrow: 'Vie de l’IGT',
                  title: 'Actualités',
                  subtitle: 'Informations et annonces officielles',
                  icon: Icons.newspaper_rounded,
                  action: IconButton(
                    tooltip: 'Événements',
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const EvenementsPage(),
                      ),
                    ),
                    icon: const Icon(Icons.event_rounded),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: AppResponsiveContent(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        onChanged: (value) => setState(() => _query = value),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search_rounded),
                          hintText: 'Rechercher une actualité ou une annonce',
                          isDense: true,
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        height: 40,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          separatorBuilder: (_, _) => const SizedBox(width: 8),
                          itemBuilder: (_, index) => ChoiceChip(
                            label: Text(categories[index]),
                            selected: _category == categories[index],
                            showCheckmark: false,
                            onSelected: (_) =>
                                setState(() => _category = categories[index]),
                          ),
                        ),
                      ),
                      if (featured != null) ...[
                        const SizedBox(height: 24),
                        _FeaturedArticle(
                          article: featured,
                          onTap: () => _open(context, featured),
                        ),
                      ],
                      const SizedBox(height: 28),
                      AppSectionHeading(
                        title: 'À lire',
                        subtitle:
                            '${filtered.length} publication${filtered.length > 1 ? 's' : ''}',
                      ),
                      const SizedBox(height: 12),
                      if (editorial.isEmpty && featured == null)
                        const AppSurface(
                          child: Center(
                            child: Text('Aucun résultat pour cette recherche'),
                          ),
                        ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final width = constraints.maxWidth >= 700
                              ? (constraints.maxWidth - 12) / 2
                              : constraints.maxWidth;
                          return Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              for (final article in editorial)
                                SizedBox(
                                  width: width,
                                  child: _ArticleCard(
                                    article: article,
                                    onTap: () => _open(context, article),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _open(BuildContext context, CommunicationArticle article) =>
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => ActualiteDetailPage(article: article),
        ),
      );
}

class _FeaturedArticle extends StatelessWidget {
  final CommunicationArticle article;
  final VoidCallback onTap;
  const _FeaturedArticle({required this.article, required this.onTap});
  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Ink(
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          image: DecorationImage(
            image: AssetImage(article.imageAsset),
            fit: BoxFit.cover,
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0x08000000), Color(0xE60B2942)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    article.category.toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xFF143D5D),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  article.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${article.source} · ${_date(article.publishedAt)}',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: .72),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class _ArticleCard extends StatelessWidget {
  final CommunicationArticle article;
  final VoidCallback onTap;
  const _ArticleCard({required this.article, required this.onTap});
  @override
  Widget build(BuildContext context) => AppSurface(
    onTap: onTap,
    padding: const EdgeInsets.all(12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.asset(
            article.imageAsset,
            width: 88,
            height: 88,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.category.toUpperCase(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: .5,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                article.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 7),
              Text(
                '${article.source} · ${_date(article.publishedAt)}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 10,
                  color: context.semanticColors.textDisabled,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

String _date(DateTime value) =>
    '${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}/${value.year}';
