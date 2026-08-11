import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../widgets/conversation_card.dart';
import 'conversation_page.dart';
import 'nouvelle_demande_page.dart';

class MessageriePage extends StatelessWidget {
  const MessageriePage({super.key});

  static const List<_ConversationPreview> _conversations = [
    _ConversationPreview(
      initials: 'S',
      subject: 'Demande de relevé de notes',
      interlocutor: 'Secrétariat',
      lastMessage: 'Votre document est prêt, vous pouvez passer le récupérer.',
      date: '10h30',
      status: ConversationStatus.traite,
      unreadCount: 2,
      messages: [
        ConversationMessage(
          text: 'Bonjour, je souhaite obtenir mon relevé de notes.',
          time: '09h15',
          isSentByUser: true,
        ),
        ConversationMessage(
          text: 'Votre demande a bien été reçue par le secrétariat.',
          time: '09h42',
          isSentByUser: false,
        ),
        ConversationMessage(
          text: 'Votre document est prêt, vous pouvez passer le récupérer.',
          time: '10h30',
          isSentByUser: false,
        ),
      ],
    ),
    _ConversationPreview(
      initials: 'SA',
      subject: 'Concernant mes notes de S3',
      interlocutor: 'Service académique',
      lastMessage: 'Nous avons bien reçu votre demande.',
      date: 'Hier',
      status: ConversationStatus.enCours,
      unreadCount: 1,
      messages: [
        ConversationMessage(
          text: 'Bonjour, pouvez-vous vérifier mes notes du semestre 3 ?',
          time: 'Hier 08h20',
          isSentByUser: true,
        ),
        ConversationMessage(
          text: 'Nous avons bien reçu votre demande.',
          time: 'Hier 11h05',
          isSentByUser: false,
        ),
      ],
    ),
    _ConversationPreview(
      initials: 'A',
      subject: 'Question sur mon inscription',
      interlocutor: 'Administration',
      lastMessage: 'Vous pouvez passer au bureau des inscriptions.',
      date: 'Lun.',
      status: ConversationStatus.ferme,
      unreadCount: 0,
      messages: [
        ConversationMessage(
          text: 'Bonjour, mon dossier d’inscription est-il complet ?',
          time: 'Lun. 09h10',
          isSentByUser: true,
        ),
        ConversationMessage(
          text: 'Vous pouvez passer au bureau des inscriptions.',
          time: 'Lun. 14h25',
          isSentByUser: false,
        ),
      ],
    ),
    _ConversationPreview(
      initials: 'ST',
      subject: 'Problème de connexion au portail',
      interlocutor: 'Support technique',
      lastMessage: 'Problème résolu de votre côté ?',
      date: '12 Nov.',
      status: ConversationStatus.traite,
      unreadCount: 0,
      messages: [
        ConversationMessage(
          text: 'Je n’arrive plus à me connecter au portail étudiant.',
          time: '12 Nov. 15h00',
          isSentByUser: true,
        ),
        ConversationMessage(
          text: 'Nous avons réinitialisé votre accès.',
          time: '12 Nov. 15h40',
          isSentByUser: false,
        ),
        ConversationMessage(
          text: 'Problème résolu de votre côté ?',
          time: '12 Nov. 16h05',
          isSentByUser: false,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final unreadMessages = _conversations.fold<int>(
      0,
      (total, conversation) => total + conversation.unreadCount,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 78,
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        titleSpacing: 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Messagerie',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$unreadMessages message(s) non lu(s)',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: FilledButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const NouvelleDemandePage(),
                  ),
                );
              },
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Nouveau'),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
                visualDensity: VisualDensity.compact,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        itemCount: _conversations.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final conversation = _conversations[index];

          return ConversationCard(
            initials: conversation.initials,
            subject: conversation.subject,
            interlocutor: conversation.interlocutor,
            lastMessage: conversation.lastMessage,
            date: conversation.date,
            status: conversation.status,
            unreadCount: conversation.unreadCount,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => ConversationPage(
                    subject: conversation.subject,
                    interlocutor: conversation.interlocutor,
                    status: conversation.status,
                    messages: conversation.messages,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _ConversationPreview {
  const _ConversationPreview({
    required this.initials,
    required this.subject,
    required this.interlocutor,
    required this.lastMessage,
    required this.date,
    required this.status,
    required this.unreadCount,
    required this.messages,
  });

  final String initials;
  final String subject;
  final String interlocutor;
  final String lastMessage;
  final String date;
  final ConversationStatus status;
  final int unreadCount;
  final List<ConversationMessage> messages;
}
