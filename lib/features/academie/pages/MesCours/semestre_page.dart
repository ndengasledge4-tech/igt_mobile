import 'package:flutter/material.dart';
import '../../../../shared/widgets/premium_ui.dart';
import 'cours_detail_page.dart';

class SemestrePage extends StatelessWidget {
  final String annee;
  final List<String> semestres;
  const SemestrePage({super.key, required this.annee, required this.semestres});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: AppScreenHeader(
            eyebrow: 'Parcours',
            title: annee,
            subtitle: 'Choisissez un semestre',
            icon: Icons.calendar_view_month_rounded,
            showBack: true,
          ),
        ),
        SliverToBoxAdapter(
          child: AppResponsiveContent(
            child: Column(
              children: [
                for (var i = 0; i < semestres.length; i++) ...[
                  AppSurface(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => CoursDetailPage(semestre: semestres[i]),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            'S${i + 1}',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                semestres[i],
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                i == 0
                                    ? '5 matières · 15 crédits'
                                    : '5 matières · 16 crédits',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded),
                      ],
                    ),
                  ),
                  if (i != semestres.length - 1) const SizedBox(height: 12),
                ],
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
