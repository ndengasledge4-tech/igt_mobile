import 'package:flutter/material.dart';

import '../../app/routes/route_names.dart';
import '../../app/theme/semantic_colors.dart';
import '../../shared/widgets/premium_ui.dart';
import '../actualite/pages/actualites_page.dart';
import '../communication/communication_store.dart';
import '../messagerie/pages/conversation_page.dart';
import '../messagerie/pages/messagerie_page.dart';
import '../timetable/planning_store.dart';
import '../timetable/teacher_planning_page.dart';

class TeacherHomePage extends StatelessWidget {
  const TeacherHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final communication = CommunicationStore.instance;
    final planning = PlanningStore.instance;
    return AnimatedBuilder(
      animation: Listenable.merge([communication, planning]),
      builder: (context, _) {
        final next =
            planning.items
                .where((item) => item.start.isAfter(DateTime.now()))
                .firstOrNull ??
            planning.items.first;
        final conversation = communication.conversationById('teacher-mariam');
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AppStudentHeader(
                  greeting: 'Bonjour, Mariam',
                  identity: 'Enseignante · Département Informatique',
                  initials: 'MD',
                  notificationCount: communication.unreadNotifications,
                  onNotifications: () =>
                      Navigator.pushNamed(context, RouteNames.notifications),
                  secondaryAction: IconButton(
                    tooltip: 'Revenir au profil étudiant',
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.switch_account_outlined),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: AppResponsiveContent(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF143D5D), Color(0xFF2F7D78)],
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PROCHAIN COURS',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: .7),
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: .8,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              next.subject,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${_hour(next.start)} – ${_hour(next.end)} · ${next.room}\n${next.group}',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: .75),
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 18),
                            FilledButton.tonalIcon(
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => const TeacherPlanningPage(),
                                ),
                              ),
                              icon: const Icon(Icons.calendar_month_rounded),
                              label: const Text('Gérer le planning'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      const AppSectionHeading(
                        title: 'Communication',
                        subtitle: 'Vos échanges et publications',
                      ),
                      const SizedBox(height: 12),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final width = constraints.maxWidth >= 600
                              ? (constraints.maxWidth - 12) / 2
                              : constraints.maxWidth;
                          return Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              SizedBox(
                                width: width,
                                child: _TeacherShortcut(
                                  icon: Icons.forum_rounded,
                                  title: 'Messages',
                                  subtitle:
                                      '${communication.unreadMessages} non lus',
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (_) => const MessageriePage(
                                        teacherMode: true,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width,
                                child: _TeacherShortcut(
                                  icon: Icons.campaign_rounded,
                                  title: 'Annonces',
                                  subtitle: 'Publications de l’IGT',
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (_) => const ActualitePage(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width,
                                child: _TeacherShortcut(
                                  icon: Icons.groups_2_outlined,
                                  title: 'Groupes / classes',
                                  subtitle: 'L3 GI · Groupes A et B',
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (_) => const ConversationPage(
                                        conversationId: 'group-l3',
                                        teacherMode: true,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width,
                                child: _TeacherShortcut(
                                  icon: Icons.notifications_rounded,
                                  title: 'Notifications',
                                  subtitle:
                                      '${communication.unreadNotifications} à consulter',
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    RouteNames.notifications,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 28),
                      const AppSectionHeading(
                        title: 'Conversation récente',
                        subtitle: 'Visible également côté étudiant',
                      ),
                      const SizedBox(height: 12),
                      AppSurface(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => ConversationPage(
                              conversationId: conversation.id,
                              teacherMode: true,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 46,
                              height: 46,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Text(
                                'AM',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Aymen M.',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    conversation.messages.last.text,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: context
                                              .semanticColors
                                              .textSecondary,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right_rounded),
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

class _TeacherShortcut extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final VoidCallback onTap;
  const _TeacherShortcut({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => AppSurface(
    onTap: onTap,
    child: Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.semanticColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.chevron_right_rounded),
      ],
    ),
  );
}

String _hour(DateTime date) =>
    '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
