// ---------------- home_screen.dart ----------------
import 'package:flutter/material.dart';
import 'package:rumour/core/modules/module.dart';
import 'package:rumour/core/services/device_info_service.dart';
import 'package:rumour/core/utilities/navigation/navigation_routes.dart';
import 'package:rumour/features/chat/domain/usecases/create_room_remote_usecase.dart';
import 'package:rumour/features/chat/presentation/models/room_model.dart';
import 'package:rumour/features/chat/presentation/screens/helping_widgets/one_chat_widget.dart';
import 'package:rumour/features/chat/presentation/service/chat_service.dart';

class _Colors {
  static const background = Color(0xFF0B0B0D);
  static const avatarBg = Color(0xFF1D1D1F);
  static const accent = Color(0xFFC6F135);
  static const subtitle = Color(0xFF9A9A9E);
  static const cardBg = Color(0xFF171A26);
  static const divider = Color(0xFF23232A);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _createRoom(BuildContext context) {
    final code = generateRoomCode();
    sl<ChatService>().createRoomRemote(
      CreateRoomRemoteUsecaseParam(
        room: RoomModel(
          roomCode: code,
          myName: "Dinesh_$code",
          senderDeviceId: sl<DeviceInfoService>().deviceId,
        ),
      ),
    );
  }

  void _joinRoom(BuildContext context) {
    Navigator.of(context).pushNamed(roomJoinScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _Colors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: _Colors.avatarBg,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person_outline, color: _Colors.accent, size: 20),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      "My Rooms",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: sl<ChatService>().myChats,
                builder: (context, chats, child) {
                  if (chats.isEmpty) {
                    return _buildEmptyState(context);
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: chats.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return OneChatWidget(chat: chats[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFab(
              icon: Icons.login_rounded,
              onTap: () => _joinRoom(context),
              filled: false,
            ),
            const SizedBox(height: 12),
            _buildFab(
              icon: Icons.add,
              onTap: () => _createRoom(context),
              filled: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFab({
    required IconData icon,
    required VoidCallback onTap,
    required bool filled,
  }) {
    return SizedBox(
      width: 52,
      height: 52,
      child: FloatingActionButton(
        heroTag: icon.toString(),
        onPressed: onTap,
        elevation: filled ? 8 : 0,
        backgroundColor: filled ? _Colors.accent : _Colors.avatarBg,
        foregroundColor: filled ? Colors.black : Colors.white,
        shape: const CircleBorder(),
        child: Icon(icon, size: 22),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: const BoxDecoration(
                color: _Colors.avatarBg,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.chat_bubble_outline_rounded,
                  color: _Colors.accent, size: 32),
            ),
            const SizedBox(height: 24),
            const Text(
              "No Chats Yet",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Create a new room or join one with a code to start an anonymous chat.",
              textAlign: TextAlign.center,
              style: TextStyle(color: _Colors.subtitle, fontSize: 14, height: 1.4),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => _createRoom(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _Colors.accent,
                  foregroundColor: Colors.black,
                  elevation: 8,
                  shadowColor: _Colors.accent.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: const Text(
                  "Create Room",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton(
                onPressed: () => _joinRoom(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: _Colors.divider),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: const Text(
                  "Join Room",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

