
// ---------------- message_screen.dart ----------------
import 'package:flutter/material.dart';
import 'package:rumour/core/modules/module.dart';
import 'package:rumour/core/services/device_info_service.dart';
import 'package:rumour/features/chat/domain/usecases/create_message_remote_usecase.dart';
import 'package:rumour/features/chat/presentation/models/message_model.dart';
import 'package:rumour/features/chat/presentation/models/room_member.dart';
import 'package:rumour/features/chat/presentation/screens/helping_widgets/one_message_widget.dart';
import 'package:rumour/features/chat/presentation/service/chat_service.dart';

// ---- Design tokens (move into your theme file if you have one) ----
class _ChatColors {
  static const background = Color(0xFF0B0B0D);
  static const avatarBg = Color(0xFF1D1D1F);
  static const accent = Color(0xFFC6F135); // lime-green
  static const subtitle = Color(0xFF9A9A9E);
  static const receivedBubble = Color(0xFF1E2233);
  static const inputBg = Color(0xFF19191B);
  static const dateChipBg = Color(0xFF1D1D1F);
  static const timestamp = Color(0xFFB9BDD3);
  static const timestampOnGreen = Color(0xFF1B3B00);
}

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key, required this.chat});

  final RoomMember chat;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late TextEditingController messageTextController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    messageTextController = TextEditingController();
  }

  @override
  void dispose() {
    sl<ChatService>().changeCurrentRoom(null);
    messageTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = messageTextController.text.trim();
    if (text.isEmpty) return;

    sl<ChatService>().createMessageRemote(
      CreateMessageRemoteUsecaseParam(
        message: MessageModel(
          createDate: DateTime.now(),
          messageText: text,
          roomCode: widget.chat.roomCode,
          sendDeviceId: sl<DeviceInfoService>().deviceId,
          senderName: widget.chat.name,
        ),
      ),
    );
    messageTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _ChatColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: sl<ChatService>().currentroomMessages,
                builder: (context, messages, child) {
                  if (messages.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMine = message.sendDeviceId ==
                          sl<DeviceInfoService>().deviceId;
                      final showDateChip = index == 0; // customize with real date-grouping logic

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (showDateChip) ...[
                            _buildDateChip(_formatDateLabel(message.createDate)),
                            const SizedBox(height: 20),
                          ],
                          OneMessageWidget(message: message, ismine: isMine),
                          const SizedBox(height: 12),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: _ChatColors.avatarBg,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.chevron_left, color: Colors.white, size: 22),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "Room #${widget.chat.roomCode}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  "4 members", // replace with real member count if available
                  style: TextStyle(
                    color: _ChatColors.subtitle,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateChip(String label) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: _ChatColors.dateChipBg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: const TextStyle(color: _ChatColors.subtitle, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
            
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: _ChatColors.inputBg,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: messageTextController,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                cursorColor: _ChatColors.accent,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                 
                  hintText: "Type a message",
                  hintStyle: TextStyle(
                    
                    color: _ChatColors.subtitle, fontSize: 14),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: _sendMessage,
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: _ChatColors.accent,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send_rounded, color: Colors.black, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateLabel(DateTime date) {
    final now = DateTime.now();
    final isToday = date.year == now.year && date.month == now.month && date.day == now.day;
    if (isToday) return "Today";
    return "${date.day}/${date.month}/${date.year}";
  }
}
// import 'package:flutter/material.dart';
// import 'package:rumour/core/modules/module.dart';
// import 'package:rumour/core/services/device_info_service.dart';
// import 'package:rumour/features/chat/domain/usecases/create_message_remote_usecase.dart';
// import 'package:rumour/features/chat/presentation/models/message_model.dart';
// import 'package:rumour/features/chat/presentation/models/room_member.dart';
// import 'package:rumour/features/chat/presentation/models/room_model.dart';
// import 'package:rumour/features/chat/presentation/screens/helping_widgets/one_message_widget.dart';
// import 'package:rumour/features/chat/presentation/service/chat_service.dart';

// class MessageScreen extends StatefulWidget {
//   const MessageScreen({super.key,required this.chat});

//   final RoomMember chat;

//   @override
//   State<MessageScreen> createState() => _MessageScreenState();
// }

// class _MessageScreenState extends State<MessageScreen> {

//   late TextEditingController messageTextController;

//   @override
//   void initState() {
  
//     super.initState();
//     messageTextController=TextEditingController();
//   }

//   @override
//   void dispose() {
// sl<ChatService>().changeCurrentRoom(null);

//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:AppBar(
//         title: Text("Room# ${widget.chat.roomCode}"),

        
//       ) ,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//         ValueListenableBuilder(
//           valueListenable: sl<ChatService>().currentroomMessages,
//           builder: (context, messages, child) {


//             return Expanded(child: ListView.builder(


//               itemCount: messages.length,
//               itemBuilder:(context, index) {

//                 return OneMessageWidget(message: messages[index],ismine: messages[index].sendDeviceId==sl<DeviceInfoService>().deviceId,);
              
//             },));
//           }
//         ),
//       TextFormField(
//         controller: messageTextController,
//         decoration: InputDecoration(
//           border:const OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(12))
//           ),

//           suffixIcon: InkWell(child:const Icon(Icons.forward),
//           onTap:(){
// sl<ChatService>().createMessageRemote(CreateMessageRemoteUsecaseParam(message: MessageModel(createDate: DateTime.now(), messageText: messageTextController.text, roomCode: widget.chat.roomCode, sendDeviceId: sl<DeviceInfoService>().deviceId, senderName: widget.chat.name)));
//           },
//           )
//         ),
        
//       )
//       ],),
//     );
//   }
// }