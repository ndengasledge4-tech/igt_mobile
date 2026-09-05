import 'package:flutter/material.dart';

import '../../app/theme/colors.dart';
import '../../app/theme/semantic_colors.dart';
import '../../core/models/timetable_model.dart';
import 'planning_store.dart';
import 'teacher_planning_page.dart';

enum PlanningView { day, week, month, semester }

class PlanningPage extends StatefulWidget {
  const PlanningPage({super.key});
  @override
  State<PlanningPage> createState() => _PlanningPageState();
}

class _PlanningPageState extends State<PlanningPage> {
  final store = PlanningStore.instance;
  PlanningView view = PlanningView.day;
  late DateTime selected = store.today;
  late DateTime month = DateTime(selected.year, selected.month);

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: store,
    builder: (context, _) => Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        titleSpacing: 20,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Mon planning'),
            const SizedBox(height: 3),
            Text(
              _period,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: context.semanticColors.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Choisir une date',
            onPressed: _pickDate,
            icon: const Icon(Icons.calendar_month_rounded),
          ),
          IconButton(
            tooltip: 'Mode enseignant (démo)',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => const TeacherPlanningPage(),
              ),
            ),
            icon: const Icon(Icons.co_present_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 760),
                child: SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<PlanningView>(
                    key: const Key('planning-view-selector'),
                    segments: const [
                      ButtonSegment(
                        value: PlanningView.day,
                        label: Text('Jour'),
                      ),
                      ButtonSegment(
                        value: PlanningView.week,
                        label: Text('Semaine'),
                      ),
                      ButtonSegment(
                        value: PlanningView.month,
                        label: Text('Mois'),
                      ),
                      ButtonSegment(
                        value: PlanningView.semester,
                        label: Text('Semestre'),
                      ),
                    ],
                    selected: {view},
                    showSelectedIcon: false,
                    onSelectionChanged: (value) =>
                        setState(() => view = value.first),
                    style: ButtonStyle(
                      visualDensity: const VisualDensity(vertical: -1),
                      minimumSize: const WidgetStatePropertyAll(Size(0, 40)),
                      padding: const WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 6),
                      ),
                      textStyle: const WidgetStatePropertyAll(
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      side: WidgetStatePropertyAll(
                        BorderSide(color: context.semanticColors.border),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: switch (view) {
              PlanningView.day => DayPlanning(
                day: selected,
                items: store.itemsFor(selected),
              ),
              PlanningView.week => WeekPlanning(
                anchor: store.today,
                selected: selected,
                store: store,
                onSelected: (day) => setState(() => selected = day),
              ),
              PlanningView.month => MonthPlanning(
                month: month,
                selected: selected,
                store: store,
                onSelected: (day) => setState(() => selected = day),
                onMonthChanged: (value) => setState(() {
                  month = value;
                  selected = value;
                }),
              ),
              PlanningView.semester => SemesterPlanning(
                milestones: store.milestones,
              ),
            },
          ),
        ],
      ),
    ),
  );

  String get _period => switch (view) {
    PlanningView.day => fullDate(selected),
    PlanningView.week =>
      'Semaine du ${shortDate(store.today)} au ${shortDate(store.today.add(const Duration(days: 6)))}',
    PlanningView.month => '${months[month.month - 1]} ${month.year}',
    PlanningView.semester => 'Semestre 6 · 2025–2026',
  };

  Future<void> _pickDate() async {
    final value = await showDatePicker(
      context: context,
      initialDate: selected,
      firstDate: DateTime(store.today.year - 1),
      lastDate: DateTime(store.today.year + 2),
      helpText: 'Choisir une date du planning',
    );
    if (value != null) {
      setState(() {
        selected = value;
        month = DateTime(value.year, value.month);
        view = PlanningView.day;
      });
    }
  }
}

class DayPlanning extends StatelessWidget {
  final DateTime day;
  final List<PlanningItem> items;
  const DayPlanning({super.key, required this.day, required this.items});
  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return EmptyDay(date: day);
    return ListView(
      key: const Key('day-planning'),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 36),
      children: [
        DaySummary(items: items),
        const SizedBox(height: 20),
        for (var i = 0; i < items.length; i++)
          TimelineEntry(item: items[i], last: i == items.length - 1),
      ],
    );
  }
}

class DaySummary extends StatelessWidget {
  final List<PlanningItem> items;
  const DaySummary({super.key, required this.items});
  @override
  Widget build(BuildContext context) {
    final count = items
        .where((e) => e.status != PlanningItemStatus.cancelled)
        .length;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryStrong, Color(0xFF215B77)],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.today_rounded, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$count séance${count > 1 ? 's' : ''} au programme',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${hour(items.first.start)} — ${hour(items.last.end)}',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: .7),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          if (items.any((e) => e.isRecentChange))
            const PlanningBadge(
              label: 'Mis à jour',
              icon: Icons.bolt_rounded,
              foreground: Colors.white,
            ),
        ],
      ),
    );
  }
}

class TimelineEntry extends StatelessWidget {
  final PlanningItem item;
  final bool last;
  const TimelineEntry({super.key, required this.item, required this.last});
  @override
  Widget build(BuildContext context) => IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: 54,
          child: Column(
            children: [
              Text(
                hour(item.start),
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 7),
              Container(
                width: 11,
                height: 11,
                decoration: BoxDecoration(
                  color: itemColor(item, context),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 2,
                  ),
                ),
              ),
              if (!last)
                Expanded(
                  child: Container(
                    width: 2,
                    color: context.semanticColors.border,
                  ),
                ),
              Text(
                hour(item.end),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.semanticColors.textDisabled,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: LessonCard(item: item),
          ),
        ),
      ],
    ),
  );
}

class LessonCard extends StatelessWidget {
  final PlanningItem item;
  final bool compact;
  const LessonCard({super.key, required this.item, this.compact = false});
  @override
  Widget build(BuildContext context) {
    final cancelled = item.status == PlanningItemStatus.cancelled;
    return Card(
      child: InkWell(
        key: ValueKey('lesson-${item.id}'),
        onTap: () => showLessonDetails(context, item),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: EdgeInsets.all(compact ? 13 : 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 4,
                height: compact ? 72 : 98,
                decoration: BoxDecoration(
                  color: itemColor(item, context),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 7,
                      runSpacing: 6,
                      children: [
                        TypeBadge(type: item.type),
                        StatusBadge(status: item.status),
                        if (item.isRecentChange)
                          const PlanningBadge(
                            label: 'Récent',
                            icon: Icons.bolt_rounded,
                          ),
                      ],
                    ),
                    const SizedBox(height: 9),
                    Text(
                      item.subject,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        decoration: cancelled
                            ? TextDecoration.lineThrough
                            : null,
                        color: cancelled
                            ? context.semanticColors.textSecondary
                            : null,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Wrap(
                      spacing: 12,
                      runSpacing: 6,
                      children: [
                        Meta(
                          icon: Icons.person_outline_rounded,
                          label: item.teacher,
                        ),
                        Meta(
                          icon: Icons.location_on_outlined,
                          label: item.room,
                        ),
                      ],
                    ),
                    if (!compact && item.lastChange != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        item.lastChange!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: planningOrange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class WeekPlanning extends StatelessWidget {
  final DateTime anchor, selected;
  final PlanningStore store;
  final ValueChanged<DateTime> onSelected;
  const WeekPlanning({
    super.key,
    required this.anchor,
    required this.selected,
    required this.store,
    required this.onSelected,
  });
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final days = List.generate(7, (i) => anchor.add(Duration(days: i)));
      if (constraints.maxWidth >= 760) {
        return TabletWeek(days: days, store: store);
      }
      final items = store.itemsFor(selected);
      return Column(
        children: [
          SizedBox(
            height: 82,
            child: ListView.separated(
              key: const Key('week-day-selector'),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              itemCount: days.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final day = days[i],
                    active = sameDay(day, selected),
                    count = store.itemsFor(day).length;
                return InkWell(
                  key: ValueKey('week-day-$i'),
                  onTap: () => onSelected(day),
                  borderRadius: BorderRadius.circular(16),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 62,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: active
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: active
                            ? Colors.transparent
                            : context.semanticColors.border,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          weekdays[day.weekday - 1],
                          style: TextStyle(
                            fontSize: 12,
                            color: active
                                ? Colors.white70
                                : context.semanticColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          '${day.day}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: active ? Colors.white : null,
                          ),
                        ),
                        Text(
                          '$count cours',
                          style: TextStyle(
                            fontSize: 8,
                            color: active
                                ? Colors.white70
                                : context.semanticColors.textDisabled,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? EmptyDay(date: selected)
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (_, i) =>
                        LessonCard(item: items[i], compact: true),
                  ),
          ),
        ],
      );
    },
  );
}

class TabletWeek extends StatelessWidget {
  final List<DateTime> days;
  final PlanningStore store;
  const TabletWeek({super.key, required this.days, required this.store});
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(24, 10, 24, 36),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < days.length; i++)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: i == days.length - 1 ? 0 : 8),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    decoration: BoxDecoration(
                      color: sameDay(days[i], store.today)
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: context.semanticColors.border),
                    ),
                    child: Column(
                      children: [
                        Text(
                          weekdays[days[i].weekday - 1],
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text('${days[i].day}'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  for (final item in store.itemsFor(days[i]))
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: InkWell(
                        onTap: () => showLessonDetails(context, item),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: itemColor(
                              item,
                              context,
                            ).withValues(alpha: .12),
                            borderRadius: BorderRadius.circular(12),
                            border: Border(
                              left: BorderSide(
                                color: itemColor(item, context),
                                width: 3,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${hour(item.start)}–${hour(item.end)}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                item.subject,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.room,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (store.itemsFor(days[i]).isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Text(
                        'Libre',
                        style: TextStyle(
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

class MonthPlanning extends StatelessWidget {
  final DateTime month, selected;
  final PlanningStore store;
  final ValueChanged<DateTime> onSelected, onMonthChanged;
  const MonthPlanning({
    super.key,
    required this.month,
    required this.selected,
    required this.store,
    required this.onSelected,
    required this.onMonthChanged,
  });
  @override
  Widget build(BuildContext context) {
    final first = DateTime(month.year, month.month),
        count = DateTime(month.year, month.month + 1, 0).day,
        leading = first.weekday - 1;
    final cells = ((leading + count + 6) ~/ 7) * 7,
        agenda = store.itemsFor(selected);
    return ListView(
      key: const Key('month-planning'),
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 36),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 16),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () =>
                          onMonthChanged(DateTime(month.year, month.month - 1)),
                      icon: const Icon(Icons.chevron_left_rounded),
                    ),
                    Expanded(
                      child: Text(
                        '${months[month.month - 1]} ${month.year}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          onMonthChanged(DateTime(month.year, month.month + 1)),
                      icon: const Icon(Icons.chevron_right_rounded),
                    ),
                  ],
                ),
                Row(
                  children: [
                    for (final day in weekdays)
                      Expanded(
                        child: Text(
                          day.substring(0, 1),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: context.semanticColors.textSecondary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 7),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cells,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisExtent: 48,
                  ),
                  itemBuilder: (context, index) {
                    final n = index - leading + 1;
                    if (n < 1 || n > count) return const SizedBox.shrink();
                    final date = DateTime(month.year, month.month, n),
                        dayItems = store.itemsFor(date),
                        active = sameDay(date, selected),
                        today = sameDay(date, store.today);
                    return InkWell(
                      key: ValueKey('month-day-$n'),
                      onTap: () => onSelected(date),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: active
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border: today && !active
                              ? Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                )
                              : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$n',
                              style: TextStyle(
                                fontWeight: today || active
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: active ? Colors.white : null,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (final item in dayItems.take(3))
                                  Container(
                                    width: 5,
                                    height: 5,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 1,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: active
                                          ? Colors.white
                                          : itemColor(item, context),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Agenda · ${fullDate(selected)}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        if (agenda.isEmpty)
          const CompactEmpty()
        else
          for (final item in agenda)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: LessonCard(item: item, compact: true),
            ),
      ],
    );
  }
}

class SemesterPlanning extends StatelessWidget {
  final List<SemesterMilestone> milestones;
  const SemesterPlanning({super.key, required this.milestones});
  @override
  Widget build(BuildContext context) => ListView(
    key: const Key('semester-planning'),
    padding: const EdgeInsets.fromLTRB(18, 8, 18, 40),
    children: [
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF6264A7).withValues(alpha: .1),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            const Icon(Icons.route_rounded, color: Color(0xFF6264A7), size: 30),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Les temps forts du semestre',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Une lecture simple des étapes qui structurent votre année.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: context.semanticColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 22),
      for (var i = 0; i < milestones.length; i++)
        MilestoneTile(item: milestones[i], last: i == milestones.length - 1),
    ],
  );
}

class MilestoneTile extends StatelessWidget {
  final SemesterMilestone item;
  final bool last;
  const MilestoneTile({super.key, required this.item, required this.last});
  @override
  Widget build(BuildContext context) {
    final passed = item.date.isBefore(DateTime.now());
    final color = item.type == SemesterMilestoneType.exam
        ? const Color(0xFF6264A7)
        : item.type == SemesterMilestoneType.holiday
        ? context.semanticColors.success
        : planningOrange;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 35,
            child: Column(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: .14),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    passed ? Icons.check_rounded : milestoneIcon(item.type),
                    color: color,
                    size: 16,
                  ),
                ),
                if (!last)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: context.semanticColors.border,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 22),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dateRange(item.date, item.endDate),
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        item.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item.subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: context.semanticColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showLessonDetails(
  BuildContext context,
  PlanningItem item,
) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  builder: (_) => SafeArea(
    child: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(22, 4, 22, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              TypeBadge(type: item.type),
              StatusBadge(status: item.status),
              if (item.isRecentChange)
                const PlanningBadge(
                  label: 'Changement récent',
                  icon: Icons.bolt_rounded,
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(item.subject, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 20),
          DetailRow(
            icon: Icons.schedule_rounded,
            label: 'Horaires',
            value:
                '${fullDate(item.start)} · ${hour(item.start)} – ${hour(item.end)}',
          ),
          DetailRow(
            icon: Icons.person_outline_rounded,
            label: 'Enseignant',
            value: item.teacher,
          ),
          DetailRow(
            icon: Icons.location_on_outlined,
            label: 'Salle',
            value:
                '${item.room}${item.campus == null ? '' : ' · ${item.campus}'}',
          ),
          DetailRow(
            icon: Icons.groups_2_outlined,
            label: 'Groupe',
            value: item.group,
          ),
          if (item.resources.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              'Ressources associées',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            for (final resource in item.resources)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.description_outlined),
                title: Text(resource),
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
          ],
          if (item.lastChange != null)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: planningOrange.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.update_rounded, color: planningOrange),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item.lastChange!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
  ),
);

class DetailRow extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const DetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.primaryContainer.withValues(alpha: .5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 21),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.semanticColors.textSecondary,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class EmptyDay extends StatelessWidget {
  final DateTime date;
  const EmptyDay({super.key, required this.date});
  @override
  Widget build(BuildContext context) => Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primaryContainer.withValues(alpha: .45),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.event_available_rounded, size: 34),
          ),
          const SizedBox(height: 18),
          Text('Aucune séance', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 7),
          Text(
            'Votre agenda est libre le ${fullDate(date)}.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: context.semanticColors.textSecondary,
            ),
          ),
        ],
      ),
    ),
  );
}

class CompactEmpty extends StatelessWidget {
  const CompactEmpty({super.key});
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          const Icon(Icons.event_available_outlined),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Aucun rendez-vous ce jour.',
              style: TextStyle(color: context.semanticColors.textSecondary),
            ),
          ),
        ],
      ),
    ),
  );
}

class Meta extends StatelessWidget {
  final IconData icon;
  final String label;
  const Meta({super.key, required this.icon, required this.label});
  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 190),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: context.semanticColors.textSecondary),
        const SizedBox(width: 5),
        Flexible(
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
    ),
  );
}

class TypeBadge extends StatelessWidget {
  final PlanningItemType type;
  const TypeBadge({super.key, required this.type});
  @override
  Widget build(BuildContext context) => PlanningBadge(
    label: typeLabel(type),
    icon: typeIcon(type),
    foreground: typeColor(type, context),
  );
}

class StatusBadge extends StatelessWidget {
  final PlanningItemStatus status;
  const StatusBadge({super.key, required this.status});
  @override
  Widget build(BuildContext context) => PlanningBadge(
    label: statusLabel(status),
    icon: statusIcon(status),
    foreground: statusColor(status, context),
  );
}

class PlanningBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? foreground;
  const PlanningBadge({
    super.key,
    required this.label,
    required this.icon,
    this.foreground,
  });
  @override
  Widget build(BuildContext context) {
    final color = foreground ?? planningOrange;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .11),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

const planningOrange = Color(0xFFD47A45);
const months = [
  'Janvier',
  'Février',
  'Mars',
  'Avril',
  'Mai',
  'Juin',
  'Juillet',
  'Août',
  'Septembre',
  'Octobre',
  'Novembre',
  'Décembre',
];
const weekdays = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
String hour(DateTime d) =>
    '${d.hour.toString().padLeft(2, '0')}h${d.minute == 0 ? '' : d.minute.toString().padLeft(2, '0')}';
String shortDate(DateTime d) =>
    '${d.day} ${months[d.month - 1].substring(0, 3).toLowerCase()}';
String fullDate(DateTime d) =>
    '${weekdays[d.weekday - 1]} ${d.day} ${months[d.month - 1].toLowerCase()}';
bool sameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;
String dateRange(DateTime a, DateTime? b) =>
    b == null ? fullDate(a) : '${shortDate(a)} — ${shortDate(b)}';
String typeLabel(PlanningItemType t) => switch (t) {
  PlanningItemType.course => 'Cours',
  PlanningItemType.td => 'TD',
  PlanningItemType.tp => 'TP',
  PlanningItemType.exam => 'Examen',
  PlanningItemType.event => 'Événement',
  PlanningItemType.deadline => 'Échéance',
};
IconData typeIcon(PlanningItemType t) => switch (t) {
  PlanningItemType.course => Icons.menu_book_rounded,
  PlanningItemType.td => Icons.edit_note_rounded,
  PlanningItemType.tp => Icons.science_outlined,
  PlanningItemType.exam => Icons.assignment_rounded,
  PlanningItemType.event => Icons.celebration_outlined,
  PlanningItemType.deadline => Icons.flag_outlined,
};
String statusLabel(PlanningItemStatus s) => switch (s) {
  PlanningItemStatus.scheduled => 'Prévu',
  PlanningItemStatus.confirmed => 'Confirmé',
  PlanningItemStatus.moved => 'Déplacé',
  PlanningItemStatus.cancelled => 'Annulé',
  PlanningItemStatus.inProgress => 'En cours',
};
IconData statusIcon(PlanningItemStatus s) => switch (s) {
  PlanningItemStatus.scheduled => Icons.schedule_rounded,
  PlanningItemStatus.confirmed => Icons.check_circle_outline_rounded,
  PlanningItemStatus.moved => Icons.swap_horiz_rounded,
  PlanningItemStatus.cancelled => Icons.cancel_outlined,
  PlanningItemStatus.inProgress => Icons.play_circle_outline_rounded,
};
Color statusColor(PlanningItemStatus s, BuildContext c) => switch (s) {
  PlanningItemStatus.moved => planningOrange,
  PlanningItemStatus.cancelled => Theme.of(c).colorScheme.error,
  PlanningItemStatus.confirmed ||
  PlanningItemStatus.inProgress => c.semanticColors.success,
  PlanningItemStatus.scheduled => c.semanticColors.info,
};
Color typeColor(PlanningItemType t, BuildContext c) => switch (t) {
  PlanningItemType.exam => const Color(0xFF6264A7),
  PlanningItemType.event || PlanningItemType.deadline => planningOrange,
  _ => c.semanticColors.info,
};
Color itemColor(PlanningItem item, BuildContext c) =>
    item.status == PlanningItemStatus.cancelled
    ? Theme.of(c).colorScheme.error
    : item.status == PlanningItemStatus.moved || item.isRecentChange
    ? planningOrange
    : typeColor(item.type, c);
IconData milestoneIcon(SemesterMilestoneType t) => switch (t) {
  SemesterMilestoneType.exam => Icons.assignment_rounded,
  SemesterMilestoneType.holiday => Icons.beach_access_outlined,
  SemesterMilestoneType.defense => Icons.record_voice_over_outlined,
  SemesterMilestoneType.result => Icons.workspace_premium_outlined,
  SemesterMilestoneType.assessment => Icons.fact_check_outlined,
  SemesterMilestoneType.institution => Icons.account_balance_outlined,
  SemesterMilestoneType.teaching => Icons.school_outlined,
};
