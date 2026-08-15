import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/dimensions.dart';
import '../../../app/theme/text_styles.dart';
import '../widgets/conversation_header.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_composer.dart';

typedef ConversationMessage = ({String text, String time, bool isSentByUser});

class ConversationPage extends StatelessWidget {
  const ConversationPage({
    super.key,
    required this.subject,
    required this.interlocutor,
    required this.initials,
    required this.status,
    required this.messages,
    required this.messageDraft,
    required this.onMessageChanged,
    required this.onSendMessage,
    this.onBack,
  });

  final String subject;
  final String interlocutor;
  final String initials;
  final String status;

  final List<ConversationMessage> messages;

  /// Texte actuellement saisi.
  final String messageDraft;

  /// Appelé à chaque modification du champ.
  final ValueChanged<String> onMessageChanged;

  /// Appelé lorsque l'utilisateur appuie sur Envoyer.
  final VoidCallback onSendMessage;

  /// Navigation gérée par la couche supérieure.
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            ConversationHeader(
              initials: initials,
              interlocutor: interlocutor,
              subject: subject,
              status: status,
              onBack: onBack ?? () => Navigator.of(context).pop(),
            ),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(AppDimensions.md),
                itemCount: messages.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppDimensions.sm),
                itemBuilder: (context, index) {
                  final message = messages[index];

                  return MessageBubble(
                    text: message.text,
                    time: message.time,
                    isSentByUser: message.isSentByUser,
                    initials: initials,
                  );
                },
              ),
            ),

            MessageComposer(
              value: messageDraft,
              onChanged: onMessageChanged,
              onSend: onSendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
