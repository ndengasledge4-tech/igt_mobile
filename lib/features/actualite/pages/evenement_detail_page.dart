import 'package:flutter/material.dart';

import '../../../app/theme/semantic_colors.dart';
import '../../../shared/widgets/premium_ui.dart';
import '../../../shared/widgets/app_header.dart';
import '../../communication/communication_store.dart';

class EvenementDetailPage extends StatelessWidget {
  final UniversityEvent event;
  const EvenementDetailPage({super.key, required this.event});
  @override
  Widget build(BuildContext context) {
    final store = CommunicationStore.instance;
    return AnimatedBuilder(
      animation: store,
      builder: (context, _) {
        final current = store.eventById(event.id);
        final upcoming = current.startsAt.isAfter(DateTime.now());
        return Scaffold(
          appBar: const AppHeader.secondary(
            title: 'Détail de l’événement',
            subtitle: 'Informations et participation',
          ),
          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 880),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: MediaQuery.sizeOf(context).width >= 700
                            ? 2.6
                            : 1.6,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(current.imageAsset, fit: BoxFit.cover),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withValues(alpha: .65),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              right: 20,
                              bottom: 18,
                              child: Text(
                                current.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppResponsiveContent(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 10,
                              runSpacing: 8,
                              children: [
                                _Info(
                                  icon: Icons.calendar_month_rounded,
                                  label: _date(current.startsAt),
                                ),
                                _Info(
                                  icon: Icons.schedule_rounded,
                                  label:
                                      '${current.startsAt.hour.toString().padLeft(2, '0')}:${current.startsAt.minute.toString().padLeft(2, '0')}',
                                ),
                                _Info(
                                  icon: Icons.location_on_outlined,
                                  label: current.location,
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Text(
                              current.description,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.copyWith(height: 1.6),
                            ),
                            const SizedBox(height: 26),
                            const AppSectionHeading(title: 'Programme'),
                            const SizedBox(height: 10),
                            AppSurface(
                              child: Column(
                                children: [
                                  for (
                                    var i = 0;
                                    i < current.program.length;
                                    i++
                                  )
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: i == current.program.length - 1
                                            ? 0
                                            : 14,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 54,
                                            child: Text(
                                              current.program[i].$1,
                                              style: TextStyle(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(current.program[i].$2),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            AppSurface(
                              child: Row(
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withValues(alpha: .1),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Icon(
                                      Icons.account_balance_rounded,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Organisateur',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: context
                                                    .semanticColors
                                                    .textSecondary,
                                              ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          current.organizer,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (upcoming) ...[
                              const SizedBox(height: 22),
                              SizedBox(
                                width: double.infinity,
                                child: FilledButton.icon(
                                  key: const Key('toggle-event-participation'),
                                  onPressed: () {
                                    store.toggleParticipation(current.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          current.participating
                                              ? 'Participation annulée'
                                              : 'Participation confirmée',
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    current.participating
                                        ? Icons.check_circle_rounded
                                        : Icons.event_available_rounded,
                                  ),
                                  label: Text(
                                    current.participating
                                        ? 'Je participe'
                                        : 'Confirmer ma participation',
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
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
}

class _Info extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Info({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) => Container(
    constraints: BoxConstraints(
      maxWidth: MediaQuery.sizeOf(context).width - 40,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}

String _date(DateTime value) =>
    '${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}/${value.year}';
