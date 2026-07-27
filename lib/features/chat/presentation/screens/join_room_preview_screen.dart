import 'package:flutter/material.dart';
import 'package:rumour/core/utilities/navigation/navigation_routes.dart';
import 'package:rumour/features/chat/presentation/models/room_member.dart';

class _Colors {
  static const background = Color(0xFF0B0B0D);
  static const avatarBg = Color(0xFF1D1D1F);
  static const accent = Color(0xFFC6F135);
  static const subtitle = Color(0xFF9A9A9E);
  static const cardBg = Color(0xFF171A26);
}

class JoinRoomPreviewScreen extends StatelessWidget {
  const JoinRoomPreviewScreen({super.key, required this.member});
  final RoomMember member;

  @override
  Widget build(BuildContext context) {
    final nameParts = member.name.split(' ');
    final firstWord = nameParts.isNotEmpty ? nameParts.first : '';
    final secondWord = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    return Scaffold(
      backgroundColor: _Colors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: _Colors.avatarBg,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.chevron_left, color: Colors.white, size: 22),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Room #${member.roomCode}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                       
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
            ),
            const Spacer(flex: 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                decoration: BoxDecoration(
                  color: _Colors.cardBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      "For this room, you are",
                      style: TextStyle(color: _Colors.subtitle, fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      firstWord,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: _Colors.accent,
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                    ),
                    if (secondWord.isNotEmpty)
                      Text(
                        secondWord,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: _Colors.accent,
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                          height: 1.1,
                        ),
                      ),
                    const SizedBox(height: 16),
                    const Text(
                      "This is your anonymous identifier, visible only to others in this room.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: _Colors.subtitle, fontSize: 13, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).popAndPushNamed(chatScreen,arguments: member),
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
                    "Acknowledge and continue",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
