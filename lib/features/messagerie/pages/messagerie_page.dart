import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/text_styles.dart';
import '../widgets/conversation_card.dart';
import 'conversation_page.dart';
import 'nouvelle_demande_page.dart';

class MessageriePage extends StatelessWidget {
  const MessageriePage({super.key});

  static const _conversations = [
    (
      initials: 'S',
      subject: 'Demande de relevé de notes',
      interlocutor: 'Secrétariat',
      lastMessage: 'Votre document est prêt, venez le retirer.',
      date: '10h30',
      status: 'traite',
      unreadCount: 2,
      messages: [
        (
          text:
              'Bonjour, je souhaite obtenir mon relevé de notes pour le Semestre 3.',
          time: '09h45',
          isSentByUser: true,
        ),
        (
          text:
              'Bonjour Jean, votre demande est bien prise en compte. Nous allons préparer le document.',
          time: '10h00',
          isSentByUser: false,
        ),
        (
          text:
              'Votre relevé de notes est prêt. Vous pouvez venir le retirer au secrétariat (Bureau 105) du lundi au vendredi de 8h à 16h.',
          time: '10h30',
          isSentByUser: false,
        ),
      ],
    ),
    (
      initials: 'SA',
      subject: 'Concernant mes notes de S3',
      interlocutor: 'Service académique',
      lastMessage: 'Nous avons bien reçu votre demande...',
      date: 'Hier',
      status: 'en-cours',
      unreadCount: 1,
      messages: [
        (
          text: 'Bonjour, pouvez-vous vérifier mes notes du semestre 3 ?',
          time: 'Hier 08h20',
          isSentByUser: true,
        ),
        (
          text: 'Nous avons bien reçu votre demande...',
          time: 'Hier 11h05',
          isSentByUser: false,
        ),
      ],
    ),
    (
      initials: 'A',
      subject: 'Question sur mon inscription',
      interlocutor: 'Administration',
      lastMessage: 'Vous pouvez passer au bureau 201',
      date: 'Lun.',
      status: 'ferme',
      unreadCount: 0,
      messages: [
        (
          text: 'Bonjour, mon dossier d’inscription est-il complet ?',
          time: 'Lun. 09h10',
          isSentByUser: true,
        ),
        (
          text: 'Vous pouvez passer au bureau 201.',
          time: 'Lun. 14h25',
          isSentByUser: false,
        ),
      ],
    ),
    (
      initials: 'ST',
      subject: 'Problème de connexion au portail',
      interlocutor: 'Support technique',
      lastMessage: 'Problème résolu de votre côté ?',
      date: '12 Nov.',
      status: 'traite',
      unreadCount: 0,
      messages: [
        (
          text: 'Je n’arrive plus à me connecter au portail étudiant.',
          time: '12 Nov. 15h00',
          isSentByUser: true,
        ),
        (
          text: 'Nous avons réinitialisé votre accès.',
          time: '12 Nov. 15h40',
          isSentByUser: false,
        ),
        (
          text: 'Problème résolu de votre côté ?',
          time: '12 Nov. 16h05',
          isSentByUser: false,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final unreadConversations = _conversations
        .where((conversation) => conversation.unreadCount > 0)
        .length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 76,
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        titleSpacing: 20,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Messagerie',
              style: AppTextStyles.headline3.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '$unreadConversations message(s) non lu(s)',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.white.withValues(alpha: 0.7),
                fontSize: 13,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: FilledButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => nouvelleDemandePage(),
                  ),
                );
              },
              icon: const Icon(Icons.add, size: 14),
              label: const Text('Nouveau'),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.white,
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: AppTextStyles.caption.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _conversations.length,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
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
                    initials: conversation.initials,
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
