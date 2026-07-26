
import 'package:flutter/material.dart';
import 'package:rumour/core/utilities/navigation/navigation_routes.dart';
import 'package:rumour/features/chat/presentation/models/room_member.dart';
import 'package:rumour/features/chat/presentation/models/room_model.dart';
import 'package:rumour/features/chat/presentation/screens/home_screen.dart';
import 'package:rumour/features/chat/presentation/screens/join_room_preview_screen.dart';
import 'package:rumour/features/chat/presentation/screens/join_room_screen.dart';
import 'package:rumour/features/chat/presentation/screens/message_screen.dart';

class AppRouter {

  Route onGenerateRoute(RouteSettings settings){

    switch (settings.name) {
      case homeScreen:
      return MaterialPageRoute(builder:(context) {
        return const HomeScreen();
      },);

      case chatScreen:
      return  MaterialPageRoute(builder:(context) {

        final chat= settings.arguments as RoomMember;
        return  MessageScreen(chat: chat,);
      },);

      case roomJoinScreen:
      return  MaterialPageRoute(builder:(context) {
    
        return  const JoinRoomScreen();
      },);

      case joinRoomPreviewScreen:
      return   MaterialPageRoute(builder:(context) {
        final roomMember=settings.arguments as RoomMember;
    
        return   JoinRoomPreviewScreen(member: roomMember );
      },);
      
        
        
      default:
       return MaterialPageRoute(builder:(context) {
        return const HomeScreen();
      },);

    }
    
  }

}