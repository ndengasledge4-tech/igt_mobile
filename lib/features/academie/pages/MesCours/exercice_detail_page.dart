import 'package:flutter/material.dart';

import '../../../../app/theme/semantic_colors.dart';
import '../../../../shared/widgets/premium_ui.dart';

class ExerciceDetailPage extends StatefulWidget {
  final String numero;
  final String titre;
  final String description;
  final String niveau;
  const ExerciceDetailPage({
    super.key,
    required this.numero,
    required this.titre,
    required this.description,
    required this.niveau,
  });
  @override
  State<ExerciceDetailPage> createState() => _ExerciceDetailPageState();
}

class _ExerciceDetailPageState extends State<ExerciceDetailPage> {
  bool _started = false;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: AppScreenHeader(
            eyebrow: 'Exercice ${widget.numero}',
            title: widget.titre,
            subtitle: widget.niveau,
            icon: Icons.assignment_rounded,
            showBack: true,
          ),
        ),
        SliverToBoxAdapter(
          child: AppResponsiveContent(
            maxWidth: 720,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSurface(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.description,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(height: 1.55),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule_rounded,
                            size: 18,
                            color: context.semanticColors.textSecondary,
                          ),
                          const SizedBox(width: 7),
                          const Text('Durée estimée : 30 min'),
                          const Spacer(),
                          const Text(
                            '10 points',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const AppSectionHeading(title: 'Consigne'),
                const SizedBox(height: 10),
                Text(
                  'Analysez la situation proposée, choisissez une approche adaptée et justifiez brièvement vos décisions. Cette interaction est une simulation sans envoi au serveur.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                    color: context.semanticColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 22),
                if (_started)
                  AppSurface(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Votre réponse mock',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          maxLines: 5,
                          decoration: const InputDecoration(
                            hintText: 'Rédigez votre réponse…',
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () =>
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Réponse enregistrée localement (simulation).',
                                    ),
                                  ),
                                ),
                            icon: const Icon(Icons.save_outlined),
                            label: const Text('Enregistrer le brouillon'),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      key: const Key('start-exercise'),
                      onPressed: () => setState(() => _started = true),
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: const Text('Commencer l’exercice'),
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
