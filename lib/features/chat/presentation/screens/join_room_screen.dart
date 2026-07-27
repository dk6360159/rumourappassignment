import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rumour/core/events/event_bus.dart';
import 'package:rumour/core/modules/module.dart';
import 'package:rumour/core/services/device_info_service.dart';
import 'package:rumour/core/utilities/navigation/navigation_routes.dart';
import 'package:rumour/features/chat/domain/usecases/create_member_local_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/create_member_remote_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/create_room_local_usecase.dart';
import 'package:rumour/features/chat/presentation/models/room_member.dart';
import 'package:rumour/features/chat/presentation/service/chat_service.dart';
import 'package:rumour/features/chat/presentation/service/chat_service_events.dart';

// ---- Design tokens (match these to your theme file if you have one) ----
class _JoinRoomColors {
  static const background = Color(0xFF0B0B0D);
  static const avatarBg = Color(0xFF1D1D1F);
  static const accent = Color(0xFFC6F135); // lime-green
  static const subtitle = Color(0xFF9A9A9E);
  static const fieldBg = Color(0xFF19191B);
  static const fieldBorder = Color(0xFF2A2A2D);
}

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController myCode = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isSubmitting = false;

  static const int _codeLength = 6;

  @override
  void initState() {
    super.initState();

    sl<EventBus>().on<ChatTaskCompleted>().listen((data) {
      if (data.task == ChatTask.createMemberLocal) {
        final newroom = (data.output as CreateMemberLocalUsecaseOut).member;
        sl<ChatService>().changeCurrentRoom(newroom);
        // if (mounted) {
          Navigator.of(context).popAndPushNamed(joinRoomPreviewScreen, arguments: newroom);
        // }
      }
    });

    myCode.addListener(() {
      setState(() {}); // rebuild the dash boxes as user types
    });
  }

  @override
  void dispose() {
    myCode.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _onProceed()async {
    if (myCode.text.trim().isEmpty || _isSubmitting) return;
    setState(() => _isSubmitting = true);
 await sl<ChatService>().getRandomUser();
    sl<ChatService>().createMemberRemote(
      CreateMemberRemoteUsecaseParam(
        member: RoomMember(
          deviceId: sl<DeviceInfoService>().deviceId,
          createDate: DateTime.now(),
          roomCode: myCode.text,
          name: "${sl<ChatService>().randomUser!['first']} ${sl<ChatService>().randomUser!['last']}",
        ),
      ),
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _JoinRoomColors.background,
      appBar: AppBar(
        backgroundColor:_JoinRoomColors.background, 
        leading:  IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                // color: _ChatColors.avatarBg,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.chevron_left, color: Colors.white, size: 22),
            ),
          ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(

              children: [
                const SizedBox(height: 64),
            
                // ---- Key icon avatar ----
                Container(
                  width: 76,
                  height: 76,
                  decoration: const BoxDecoration(
                    color: _JoinRoomColors.avatarBg,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.vpn_key_rounded,
                    color: _JoinRoomColors.accent,
                    size: 32,
                  ),
                ),
            
                const SizedBox(height: 140),
            
                // ---- Title ----
                const Text(
                  "Join A Room",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
            
                const SizedBox(height: 12),
            
                // ---- Subtitle ----
                const Text(
                  "Enter the code to join the anon chat room",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _JoinRoomColors.subtitle,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
            
                const SizedBox(height: 32),
            
                // ---- Code input (dash-segmented pill) ----
                GestureDetector(
                  onTap: () => _focusNode.requestFocus(),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 64,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: _JoinRoomColors.fieldBg,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: _JoinRoomColors.fieldBorder,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(_codeLength, (index) {
                            final hasChar = index < myCode.text.length;
                            return Text(
                              hasChar ? myCode.text[index] : "-",
                              style: TextStyle(
                                color: hasChar ? Colors.white : Colors.white38,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          }),
                        ),
                      ),
                      // Invisible field that actually captures input
                      Opacity(
                        opacity: 0,
                        child: TextField(
                          controller: myCode,
                          focusNode: _focusNode,
                          keyboardType: TextInputType.text,
                          maxLength: _codeLength,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
                          ],
                          decoration: const InputDecoration(counterText: ""),
                        ),
                      ),
                    ],
                  ),
                ),
            
                // const Spacer(),
            
                // ---- Proceed button ----
              
                // const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    bottomNavigationBar:  Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: _onProceed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _JoinRoomColors.accent,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child:const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Text(
              "Proceed",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward_rounded, size: 20),
          ],
        ),
      ),
    ),
 
    
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:rumour/core/events/event_bus.dart';
// import 'package:rumour/core/modules/module.dart';
// import 'package:rumour/core/services/device_info_service.dart';
// import 'package:rumour/core/utilities/navigation/navigation_routes.dart';
// import 'package:rumour/features/chat/domain/usecases/create_member_local_usecase.dart';
// import 'package:rumour/features/chat/domain/usecases/create_member_remote_usecase.dart';
// import 'package:rumour/features/chat/domain/usecases/create_room_local_usecase.dart';
// import 'package:rumour/features/chat/presentation/models/room_member.dart';
// import 'package:rumour/features/chat/presentation/service/chat_service.dart';
// import 'package:rumour/features/chat/presentation/service/chat_service_events.dart';

// class JoinRoomScreen extends StatefulWidget {
//    JoinRoomScreen({super.key});

//   @override
//   State<JoinRoomScreen> createState() => _JoinRoomScreenState();
// }

// class _JoinRoomScreenState extends State<JoinRoomScreen> {
//   final TextEditingController myCode=TextEditingController();

//  @override
//   void initState() {
    
//     super.initState();

//     sl<EventBus>().on<ChatTaskCompleted>().listen((data){
//       if(data.task==ChatTask.createRoomLocal){
//         final newroom=(data.output as CreateMemberLocalUsecaseOut).member;
//         sl<ChatService>().changeCurrentRoom(newroom);
//       Navigator.of(context).popAndPushNamed(chatScreen,arguments:newroom );
      
//       }
//     });

    
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title:const Text("Join Room"),),

//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [

      
//       const  Text("Enter Room Code"),

// TextFormField(
//   controller: myCode,
//   decoration:const InputDecoration(
//     border: OutlineInputBorder()
//   ),

// )



//       ],),

//       floatingActionButton: FloatingActionButton(onPressed:(){
//         sl<ChatService>().createMemberRemote(CreateMemberRemoteUsecaseParam(member: RoomMember(deviceId: sl<DeviceInfoService>().deviceId, createDate: DateTime.now(), roomCode: myCode.text, name: "Dinesh_${myCode.text}")));
//       },child:const Row(children: [
//         Text("Proceed"),
//         Icon(Icons.forward)
//       ],),),
//     );
//   }
// }