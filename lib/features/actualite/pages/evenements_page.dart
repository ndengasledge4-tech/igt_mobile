import 'package:flutter/material.dart';

import '../../../app/theme/semantic_colors.dart';
import '../../../shared/widgets/premium_ui.dart';
import '../../communication/communication_store.dart';
import 'evenement_detail_page.dart';

class EvenementsPage extends StatefulWidget {
  const EvenementsPage({super.key});
  @override
  State<EvenementsPage> createState() => _EvenementsPageState();
}

class _EvenementsPageState extends State<EvenementsPage> {
  bool _upcoming = true;
  @override
  Widget build(BuildContext context) {
    final store = CommunicationStore.instance;
    return AnimatedBuilder(
      animation: store,
      builder: (context, _) {
        final events =
            store.events
                .where(
                  (item) => _upcoming
                      ? item.startsAt.isAfter(DateTime.now())
                      : item.startsAt.isBefore(DateTime.now()),
                )
                .toList()
              ..sort(
                (a, b) => _upcoming
                    ? a.startsAt.compareTo(b.startsAt)
                    : b.startsAt.compareTo(a.startsAt),
              );
        return Scaffold(
          appBar: AppBar(title: const Text('Événements')),
          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              AppResponsiveContent(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SegmentedButton<bool>(
                      segments: const [
                        ButtonSegment(
                          value: true,
                          label: Text('À venir'),
                          icon: Icon(Icons.upcoming_outlined),
                        ),
                        ButtonSegment(
                          value: false,
                          label: Text('Passés'),
                          icon: Icon(Icons.history_rounded),
                        ),
                      ],
                      selected: {_upcoming},
                      onSelectionChanged: (value) =>
                          setState(() => _upcoming = value.first),
                      showSelectedIcon: false,
                    ),
                    const SizedBox(height: 24),
                    AppSectionHeading(
                      title: _upcoming
                          ? 'Prochains rendez-vous'
                          : 'Événements passés',
                      subtitle:
                          '${events.length} événement${events.length > 1 ? 's' : ''}',
                    ),
                    const SizedBox(height: 12),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final width = constraints.maxWidth >= 700
                            ? (constraints.maxWidth - 14) / 2
                            : constraints.maxWidth;
                        return Wrap(
                          spacing: 14,
                          runSpacing: 14,
                          children: [
                            for (final event in events)
                              SizedBox(
                                width: width,
                                child: _EventCard(
                                  event: event,
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (_) =>
                                          EvenementDetailPage(event: event),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EventCard extends StatelessWidget {
  final UniversityEvent event;
  final VoidCallback onTap;
  const _EventCard({required this.event, required this.onTap});
  @override
  Widget build(BuildContext context) => AppSurface(
    onTap: onTap,
    padding: EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Image.asset(
                event.imageAsset,
                width: double.infinity,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 14,
              top: 14,
              child: Container(
                width: 48,
                padding: const EdgeInsets.symmetric(vertical: 7),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.surface.withValues(alpha: .94),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Column(
                  children: [
                    Text(
                      '${event.startsAt.day}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Text(
                      _month(event.startsAt),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(event.title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 9),
              _Meta(icon: Icons.location_on_outlined, label: event.location),
              const SizedBox(height: 5),
              _Meta(
                icon: Icons.schedule_rounded,
                label:
                    '${event.startsAt.hour.toString().padLeft(2, '0')}:${event.startsAt.minute.toString().padLeft(2, '0')}',
              ),
              if (event.participating) ...[
                const SizedBox(height: 10),
                Text(
                  'PARTICIPATION CONFIRMÉE',
                  style: TextStyle(
                    color: context.semanticColors.success,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: .4,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

class _Meta extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Meta({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, size: 15, color: context.semanticColors.textDisabled),
      const SizedBox(width: 6),
      Expanded(
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: context.semanticColors.textSecondary,
          ),
        ),
      ),
    ],
  );
}

String _month(DateTime value) => const [
  'JAN',
  'FÉV',
  'MAR',
  'AVR',
  'MAI',
  'JUN',
  'JUL',
  'AOÛ',
  'SEP',
  'OCT',
  'NOV',
  'DÉC',
][value.month - 1];
