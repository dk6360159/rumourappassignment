// ---------------- one_message_widget.dart ----------------
import 'package:flutter/material.dart';
import 'package:rumour/features/chat/presentation/models/message_model.dart';

class _ChatColors {
  static const receivedBubble = Color(0xFF1E2233);
  static const accent = Color(0xFFC6F135);
  static const subtitle = Color(0xFF9A9A9E);
  static const timestamp = Color(0xFFB9BDD3);
  static const timestampOnGreen = Color(0xFF1B3B00);
}

class OneMessageWidget extends StatelessWidget {
  const OneMessageWidget({
    super.key,
    required this.message,
    required this.ismine,
  });

  final MessageModel message;
  final bool ismine;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          ismine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        // ---- Sender label (@name for others, "You" for mine) ----
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4, bottom: 6),
          child: Text(
            ismine ? "You" : "@${message.senderName}",
            style: TextStyle(
              color: ismine ? Colors.white : _ChatColors.subtitle,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // ---- Bubble ----
        Align(
          alignment: ismine ? Alignment.centerRight : Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.78,
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
              decoration: BoxDecoration(
                color: ismine ? _ChatColors.accent : _ChatColors.receivedBubble,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(ismine ? 16 : 4),
                  bottomRight: Radius.circular(ismine ? 4 : 16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message.messageText,
                    style: TextStyle(
                      color: ismine ? Colors.black : Colors.white,
                      fontSize: 14,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _formatTime(message.createDate),
                    style: TextStyle(
                      color: ismine
                          ? _ChatColors.timestampOnGreen
                          : _ChatColors.timestamp,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:rumour/features/chat/presentation/models/message_model.dart';

// class OneMessageWidget extends StatelessWidget {
//   const OneMessageWidget({super.key,required this.message,required this.ismine});
//   final MessageModel message;
//   final bool ismine;

//   @override
//   Widget build(BuildContext context) {
//     return Container(decoration:const BoxDecoration(
//   color: Colors.blue,
//   borderRadius: BorderRadius.all(Radius.circular(12))
//     ),
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(children: [
//         Text(message.messageText),
      
//         Text("${DateTime.now()..toString()}")
//       ],),
//     ),
//     );
//   }
// }