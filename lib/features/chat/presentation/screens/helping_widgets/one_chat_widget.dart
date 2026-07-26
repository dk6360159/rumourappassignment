// ---------------- one_chat_widget.dart ----------------
import 'package:flutter/material.dart';
import 'package:rumour/core/modules/module.dart';
import 'package:rumour/core/utilities/navigation/navigation_routes.dart';
import 'package:rumour/features/chat/presentation/models/room_member.dart';
import 'package:rumour/features/chat/presentation/service/chat_service.dart';

class _Colors {
  static const cardBg = Color(0xFF171A26);
  static const avatarBg = Color(0xFF1D1D1F);
  static const accent = Color(0xFFC6F135);
  static const subtitle = Color(0xFF9A9A9E);
}

class OneChatWidget extends StatelessWidget {
  const OneChatWidget({super.key, required this.chat});
  final RoomMember chat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        sl<ChatService>().changeCurrentRoom(chat);
        Navigator.of(context).pushNamed(chatScreen, arguments: chat);
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _Colors.cardBg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: _Colors.avatarBg,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.key_rounded, color: _Colors.accent, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Room #${chat.roomCode}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chat.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: _Colors.subtitle, fontSize: 13),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: _Colors.subtitle, size: 20),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:rumour/core/modules/module.dart';

// import 'package:rumour/core/utilities/navigation/navigation_routes.dart';
// import 'package:rumour/features/chat/presentation/models/room_member.dart';
// import 'package:rumour/features/chat/presentation/service/chat_service.dart';

// class OneChatWidget extends StatelessWidget {
//   const OneChatWidget({super.key,required this.chat});
//   final RoomMember chat;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text("Room# ${chat.roomCode}"),

//       onTap:() {
//         sl<ChatService>().changeCurrentRoom(chat);
//         Navigator.of(context).pushNamed(chatScreen,arguments: chat);
//       },

//     );
//   }
// }