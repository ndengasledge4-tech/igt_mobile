import 'package:flutter/material.dart';

import '../../app/theme/semantic_colors.dart';
import '../../core/models/timetable_model.dart';
import '../../shared/widgets/app_header.dart';
import 'planning_page.dart';
import 'planning_store.dart';

class TeacherPlanningPage extends StatelessWidget {
  const TeacherPlanningPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = PlanningStore.instance;
    return AnimatedBuilder(
      animation: store,
      builder: (context, _) {
        final lessons =
            store.items
                .where(
                  (item) =>
                      item.type != PlanningItemType.event &&
                      item.type != PlanningItemType.deadline,
                )
                .toList()
              ..sort((a, b) => a.start.compareTo(b.start));
        return Scaffold(
          appBar: const AppHeader.secondary(
            title: 'Planning enseignant',
            subtitle: 'Mode démonstration · données locales',
          ),
          body: ListView(
            key: const Key('teacher-planning'),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 36),
            children: [
              _TeacherHero(
                count: lessons
                    .where(
                      (item) => item.status != PlanningItemStatus.cancelled,
                    )
                    .length,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Séances à venir',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Text(
                    '${lessons.length} séances',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: context.semanticColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              for (final item in lessons)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _TeacherLesson(
                    item: item,
                    onActions: () => _showActions(context, item),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _showActions(BuildContext context, PlanningItem item) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 4, 18, 22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.subject,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 5),
                Text(
                  '${fullDate(item.start)} · ${hour(item.start)} – ${hour(item.end)} · ${item.group}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.semanticColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 18),
                _ActionTile(
                  icon: Icons.person_off_outlined,
                  title: 'Signaler une indisponibilité',
                  subtitle: 'Informe immédiatement les étudiants',
                  onTap: () {
                    Navigator.pop(sheetContext);
                    PlanningStore.instance.markUnavailable(item.id);
                    _confirm(
                      context,
                      'Indisponibilité signalée',
                      'Une notification mock a été créée côté étudiant.',
                    );
                  },
                ),
                _ActionTile(
                  icon: Icons.edit_calendar_outlined,
                  title: 'Proposer un nouvel horaire',
                  subtitle: 'Choisir une nouvelle heure pour cette séance',
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showMoveDialog(context, item);
                  },
                ),
                _ActionTile(
                  icon: Icons.event_busy_outlined,
                  title: 'Annuler la séance',
                  subtitle: 'L’annulation apparaîtra en rouge',
                  destructive: true,
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _confirmCancellation(context, item);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showMoveDialog(BuildContext context, PlanningItem item) {
    var selectedHour = 14;
    showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Proposer un nouvel horaire'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.subject, style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              Text(
                'Le changement sera visible immédiatement dans le planning étudiant.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.semanticColors.textSecondary,
                ),
              ),
              const SizedBox(height: 18),
              const Text('Nouvelle heure'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  for (final value in [14, 16, 18])
                    ChoiceChip(
                      label: Text('${value.toString().padLeft(2, '0')} h 00'),
                      selected: selectedHour == value,
                      onSelected: (_) =>
                          setDialogState(() => selectedHour = value),
                    ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Retour'),
            ),
            FilledButton(
              key: const Key('confirm-move-lesson'),
              onPressed: () {
                final newStart = DateTime(
                  item.start.year,
                  item.start.month,
                  item.start.day,
                  selectedHour,
                );
                PlanningStore.instance.moveLesson(item.id, newStart);
                Navigator.pop(dialogContext);
                _confirm(
                  context,
                  'Nouvel horaire publié',
                  '${item.subject} est maintenant prévu à ${selectedHour.toString().padLeft(2, '0')} h.',
                );
              },
              child: const Text('Publier'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmCancellation(BuildContext context, PlanningItem item) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: Icon(
          Icons.event_busy_outlined,
          color: Theme.of(context).colorScheme.error,
        ),
        title: const Text('Annuler cette séance ?'),
        content: Text(
          '${item.subject} sera marquée comme annulée pour ${item.group}. Une notification locale sera créée.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Retour'),
          ),
          FilledButton(
            key: const Key('confirm-cancel-lesson'),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () {
              PlanningStore.instance.cancelLesson(item.id);
              Navigator.pop(dialogContext);
              _confirm(
                context,
                'Séance annulée',
                'Le planning étudiant a été mis à jour.',
              );
            },
            child: const Text('Confirmer l’annulation'),
          ),
        ],
      ),
    );
  }

  void _confirm(BuildContext context, String title, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  Text(message, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TeacherHero extends StatelessWidget {
  final int count;
  const _TeacherHero({required this.count});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF143D5D), Color(0xFF2F7D78)],
      ),
      borderRadius: BorderRadius.circular(24),
    ),
    child: Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .13),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.co_present_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pr. Mariam Diarra',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$count séances actives · 3 groupes',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: .72),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const PlanningBadge(
          label: 'Démo',
          icon: Icons.science_outlined,
          foreground: Colors.white,
        ),
      ],
    ),
  );
}

class _TeacherLesson extends StatelessWidget {
  final PlanningItem item;
  final VoidCallback onActions;
  const _TeacherLesson({required this.item, required this.onActions});
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: itemColor(item, context).withValues(alpha: .11),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Column(
                  children: [
                    Text(
                      hour(item.start),
                      style: TextStyle(
                        color: itemColor(item, context),
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      weekdays[item.start.weekday - 1],
                      style: TextStyle(
                        color: context.semanticColors.textSecondary,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.subject,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 10,
                      runSpacing: 5,
                      children: [
                        Meta(icon: Icons.groups_2_outlined, label: item.group),
                        Meta(
                          icon: Icons.location_on_outlined,
                          label: item.room,
                        ),
                      ],
                    ),
                    const SizedBox(height: 9),
                    Wrap(
                      spacing: 7,
                      runSpacing: 5,
                      children: [
                        TypeBadge(type: item.type),
                        StatusBadge(status: item.status),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                key: ValueKey('teacher-actions-${item.id}'),
                tooltip: 'Actions sur la séance',
                onPressed: onActions,
                icon: const Icon(Icons.more_horiz_rounded),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final VoidCallback onTap;
  final bool destructive;
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.destructive = false,
  });
  @override
  Widget build(BuildContext context) {
    final color = destructive
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).colorScheme.primary;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      onTap: onTap,
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: color.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: destructive ? color : null,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right_rounded),
    );
  }
}
