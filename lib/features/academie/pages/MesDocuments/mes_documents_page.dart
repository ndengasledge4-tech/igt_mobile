import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';
import '../../../../app/theme/semantic_colors.dart';
import '../../../../shared/widgets/premium_ui.dart';
import 'document_detail_page.dart';

class MesDocumentsPage extends StatefulWidget {
  final int initialCategory;
  final bool embedded;

  const MesDocumentsPage({
    super.key,
    this.initialCategory = 0,
    this.embedded = false,
  });

  @override
  State<MesDocumentsPage> createState() => _MesDocumentsPageState();
}

class _MesDocumentsPageState extends State<MesDocumentsPage> {
  final _searchController = TextEditingController();
  int _selectedCategory = 0;
  String _query = '';

  static const _categories = [
    'Tous',
    'Favoris',
    'Admin',
    'Académique',
    'Cours',
    'Formulaires',
  ];
  static const _documents = [
    _DocumentData(
      'PDF',
      'Règlement intérieur 2025',
      '01/09/2025',
      '1.2 MB',
      'Admin',
      true,
    ),
    _DocumentData(
      'PDF',
      'Programme S6 – L3',
      '05/08/2026',
      '890 KB',
      'Académique',
      false,
    ),
    _DocumentData(
      'PDF',
      'Architecture logicielle – Chap. 3',
      '15/08/2026',
      '4.1 MB',
      'Cours',
      true,
    ),
    _DocumentData(
      'DOCX',
      'Formulaire de demande académique',
      '12/08/2026',
      '240 KB',
      'Formulaires',
      false,
    ),
    _DocumentData(
      'PDF',
      'Calendrier des examens',
      '18/08/2026',
      '350 KB',
      'Admin',
      false,
    ),
    _DocumentData(
      'PDF',
      'Sécurité réseau – Travaux dirigés',
      '19/08/2026',
      '1.8 MB',
      'Cours',
      false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory.clamp(0, _categories.length - 1);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_DocumentData> get _visibleDocuments {
    final category = _categories[_selectedCategory];
    return _documents.where((document) {
      final matchesCategory =
          category == 'Tous' ||
          (category == 'Favoris' && document.favorite) ||
          document.category == category;
      final matchesQuery =
          _query.isEmpty ||
          document.title.toLowerCase().contains(_query.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: AppScreenHeader(
              eyebrow: 'Bibliothèque',
              title: 'Documents',
              subtitle: '${_visibleDocuments.length} ressources disponibles',
              icon: Icons.description_rounded,
              action: widget.embedded
                  ? null
                  : IconButton.filledTonal(
                      onPressed: () => Navigator.maybePop(context),
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: AppResponsiveContent(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _searchController,
                    onChanged: (value) => setState(() => _query = value.trim()),
                    decoration: const InputDecoration(
                      hintText: 'Rechercher un document',
                      prefixIcon: Icon(Icons.search_rounded),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final selected = index == _selectedCategory;
                        return ChoiceChip(
                          label: Text(_categories[index]),
                          selected: selected,
                          showCheckmark: false,
                          onSelected: (_) =>
                              setState(() => _selectedCategory = index),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 26),
                  const AppSectionHeading(
                    title: 'Récents et favoris',
                    subtitle: 'Cours, formulaires et informations officielles',
                  ),
                  const SizedBox(height: 14),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    child: _visibleDocuments.isEmpty
                        ? const _EmptyDocuments(key: ValueKey('empty'))
                        : _DocumentList(
                            key: ValueKey('list-$_selectedCategory-$_query'),
                            documents: _visibleDocuments,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentList extends StatelessWidget {
  final List<_DocumentData> documents;

  const _DocumentList({super.key, required this.documents});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 700) {
      return LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = (constraints.maxWidth - 14) / 2;
          return Wrap(
            spacing: 14,
            runSpacing: 12,
            children: [
              for (final document in documents)
                SizedBox(
                  width: itemWidth,
                  child: _DocumentCard(document: document),
                ),
            ],
          );
        },
      );
    }
    return Column(
      children: [
        for (var i = 0; i < documents.length; i++) ...[
          _DocumentCard(document: documents[i]),
          if (i != documents.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _DocumentCard extends StatelessWidget {
  final _DocumentData document;

  const _DocumentCard({required this.document});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPdf = document.type == 'PDF';
    final accent = isPdf ? const Color(0xFF9A645D) : AppColors.primaryLight;
    return AppSurface(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (_) => DocumentDetailPage(
            titre: document.title,
            type: document.type,
            date: document.date,
            taille: document.size,
          ),
        ),
      ),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 52,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.11),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              isPdf ? Icons.picture_as_pdf_rounded : Icons.article_rounded,
              color: accent,
              size: 23,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  document.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall,
                ),
                const SizedBox(height: 6),
                Text(
                  '${document.category}  ·  ${document.size}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: context.semanticColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (document.favorite)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                Icons.star_rounded,
                size: 19,
                color: theme.colorScheme.tertiary,
              ),
            ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
            color: context.semanticColors.textDisabled,
          ),
        ],
      ),
    );
  }
}

class _EmptyDocuments extends StatelessWidget {
  const _EmptyDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSurface(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 42,
              color: context.semanticColors.textDisabled,
            ),
            const SizedBox(height: 12),
            Text(
              'Aucun document trouvé',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _DocumentData {
  final String type;
  final String title;
  final String date;
  final String size;
  final String category;
  final bool favorite;

  const _DocumentData(
    this.type,
    this.title,
    this.date,
    this.size,
    this.category,
    this.favorite,
  );
}
