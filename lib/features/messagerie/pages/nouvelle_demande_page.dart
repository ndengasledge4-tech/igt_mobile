import 'package:flutter/material.dart';

import '../../../shared/widgets/app_header.dart';

import '../../../app/theme/semantic_colors.dart';
import '../../../shared/widgets/premium_ui.dart';
import '../../communication/communication_store.dart';
import 'conversation_page.dart';

class NouvelleDemandePage extends StatefulWidget {
  const NouvelleDemandePage({super.key});
  @override
  State<NouvelleDemandePage> createState() => _NouvelleDemandePageState();
}

class _NouvelleDemandePageState extends State<NouvelleDemandePage> {
  final _message = TextEditingController();
  String? _service;
  String? _subject;
  static const _services = [
    ('Scolarité', Icons.school_outlined),
    ('Service académique', Icons.menu_book_outlined),
    ('Administration', Icons.account_balance_outlined),
  ];
  static const _subjects = [
    'Question générale',
    'Document administratif',
    'Inscription',
    'Cours ou planning',
    'Notes ou résultats',
    'Autre demande',
  ];

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ready =
        _service != null && _subject != null && _message.text.trim().isNotEmpty;
    return Scaffold(
      appBar: const AppHeader.secondary(
        title: 'Nouvelle demande',
        subtitle: 'Contactez le service concerné',
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          AppResponsiveContent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: .08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.forum_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Votre demande ouvrira une conversation suivie avec le service choisi.',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const AppSectionHeading(
                  title: '1. Choisir un service',
                  subtitle: 'Le bon interlocuteur répondra plus rapidement',
                ),
                const SizedBox(height: 12),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth >= 600
                        ? (constraints.maxWidth - 12) / 2
                        : constraints.maxWidth;
                    return Wrap(
                      spacing: 12,
                      runSpacing: 10,
                      children: [
                        for (final item in _services)
                          SizedBox(
                            width: width,
                            child: _ServiceChoice(
                              label: item.$1,
                              icon: item.$2,
                              selected: _service == item.$1,
                              onTap: () => setState(() => _service = item.$1),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 26),
                const AppSectionHeading(title: '2. Préciser la demande'),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  key: const Key('request-subject-field'),
                  initialValue: _subject,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Objet de la demande',
                  ),
                  items: [
                    for (final subject in _subjects)
                      DropdownMenuItem(
                        value: subject,
                        child: Text(
                          subject,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                  onChanged: (value) => setState(() => _subject = value),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _message,
                  minLines: 5,
                  maxLines: 8,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    labelText: 'Votre message',
                    hintText:
                        'Décrivez votre besoin avec les informations utiles…',
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.lock_outline_rounded,
                      size: 15,
                      color: context.semanticColors.textDisabled,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Échange visible uniquement par vous et le service destinataire.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 11,
                          color: context.semanticColors.textDisabled,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    key: const Key('send-administrative-request'),
                    onPressed: ready ? _send : null,
                    icon: const Icon(Icons.send_rounded),
                    label: const Text('Envoyer la demande'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _send() {
    final id = CommunicationStore.instance.createAdministrativeRequest(
      service: _service!,
      subject: _subject!,
      message: _message.text,
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => ConversationPage(conversationId: id),
      ),
    );
  }
}

class _ServiceChoice extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  const _ServiceChoice({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => AppSurface(
    onTap: onTap,
    color: selected
        ? Theme.of(context).colorScheme.primary.withValues(alpha: .08)
        : null,
    padding: const EdgeInsets.all(14),
    child: Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(label, style: Theme.of(context).textTheme.titleSmall),
        ),
        Icon(
          selected ? Icons.check_circle_rounded : Icons.circle_outlined,
          color: selected
              ? Theme.of(context).colorScheme.primary
              : context.semanticColors.textDisabled,
        ),
      ],
    ),
  );
}
