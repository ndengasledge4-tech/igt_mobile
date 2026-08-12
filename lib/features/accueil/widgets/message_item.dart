import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';

class MessageItem extends StatelessWidget {
  final String initials;
  final String sender;
  final String message;
  final String time;
  final bool unread;
  final VoidCallback onTap;

  const MessageItem({
    super.key,
    required this.initials,
    required this.sender,
    required this.message,
    required this.time,
    required this.unread,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 4,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 9,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Text(
                initials,
                style: TextStyle(
                  fontSize: 9,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 9),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sender,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 8,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 7,
                    color: Colors.grey,
                  ),
                ),

                if (unread) ...[
                  const SizedBox(height: 4),
                  Container(
                    width: 15,
                    height: 15,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      "3",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 7,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}