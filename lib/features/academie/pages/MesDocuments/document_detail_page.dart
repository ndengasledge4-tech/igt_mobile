import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../app/theme/semantic_colors.dart';
import '../../../../shared/widgets/premium_ui.dart';

enum _DownloadState { idle, downloading, downloaded }

class DocumentDetailPage extends StatefulWidget {
  final String titre;
  final String type;
  final String date;
  final String taille;
  final String service;
  final String description;

  const DocumentDetailPage({
    super.key,
    required this.titre,
    required this.type,
    required this.date,
    required this.taille,
    this.service = 'Direction des études',
    this.description =
        'Document institutionnel mis à disposition des étudiants. Consultez les informations essentielles dans l’aperçu avant de lancer le téléchargement simulé.',
  });

  @override
  State<DocumentDetailPage> createState() => _DocumentDetailPageState();
}

class _DocumentDetailPageState extends State<DocumentDetailPage> {
  _DownloadState _state = _DownloadState.idle;
  double _progress = 0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _download() {
    if (_state != _DownloadState.idle) return;
    setState(() {
      _state = _DownloadState.downloading;
      _progress = 0;
    });
    _timer = Timer.periodic(const Duration(milliseconds: 180), (timer) {
      if (!mounted) return;
      setState(() {
        _progress = (_progress + .14).clamp(0, 1);
        if (_progress >= 1) {
          _state = _DownloadState.downloaded;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: AppScreenHeader(
            eyebrow: 'Bibliothèque',
            title: 'Document',
            subtitle: widget.service,
            icon: Icons.description_rounded,
            showBack: true,
          ),
        ),
        SliverToBoxAdapter(
          child: AppResponsiveContent(
            maxWidth: 760,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSurface(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 58,
                        height: 66,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.error.withValues(alpha: .09),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          widget.type == 'PDF'
                              ? Icons.picture_as_pdf_rounded
                              : Icons.article_rounded,
                          color: widget.type == 'PDF'
                              ? Theme.of(context).colorScheme.error
                              : Theme.of(context).colorScheme.primary,
                          size: 27,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.titre,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 7),
                            Text(
                              widget.service,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: context.semanticColors.textSecondary,
                                  ),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _Meta(label: widget.type),
                                _Meta(label: widget.taille),
                                _Meta(label: widget.date),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        tooltip: 'Ajouter aux favoris',
                        onPressed: () {},
                        icon: const Icon(Icons.star_border_rounded),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const AppSectionHeading(title: 'À propos'),
                const SizedBox(height: 10),
                Text(
                  widget.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                    color: context.semanticColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),
                const AppSectionHeading(title: 'Aperçu'),
                const SizedBox(height: 12),
                Container(
                  height: 260,
                  width: double.infinity,
                  padding: const EdgeInsets.all(26),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: context.semanticColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 84,
                        height: 9,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        width: 220,
                        height: 13,
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 170,
                        height: 9,
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                      ),
                      const SizedBox(height: 28),
                      for (var i = 0; i < 5; i++) ...[
                        Container(
                          width: double.infinity,
                          height: 7,
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest
                              .withValues(alpha: .75),
                        ),
                        const SizedBox(height: 9),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _DownloadButton(
                  state: _state,
                  progress: _progress,
                  onPressed: _download,
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'Simulation locale — aucun fichier n’est stocké',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: context.semanticColors.textDisabled,
                    ),
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

class _Meta extends StatelessWidget {
  final String label;
  const _Meta({required this.label});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(99),
    ),
    child: Text(
      label,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        fontSize: 10,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

class _DownloadButton extends StatelessWidget {
  final _DownloadState state;
  final double progress;
  final VoidCallback onPressed;
  const _DownloadButton({
    required this.state,
    required this.progress,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    final downloading = state == _DownloadState.downloading;
    final downloaded = state == _DownloadState.downloaded;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        key: const Key('document-download-button'),
        onPressed: downloading || downloaded ? null : onPressed,
        icon: downloaded
            ? const Icon(Icons.check_circle_rounded)
            : downloading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 2.4,
                ),
              )
            : const Icon(Icons.download_rounded),
        label: Text(
          downloaded
              ? 'Téléchargé'
              : downloading
              ? 'Téléchargement · ${(progress * 100).round()} %'
              : 'Télécharger',
        ),
      ),
    );
  }
}
