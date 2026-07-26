import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rumour/core/errors/exceptions.dart';
import 'package:rumour/features/chat/domain/usecases/create_member_remote_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/create_message_remote_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/create_room_remote_usecase.dart';

class  ChatRemoteProvider {
  ChatRemoteProvider();

  final firestore= FirebaseFirestore.instance;


  Future<CreateMemberRemoteUsecaseOut>createMemberRemote(CreateMemberRemoteUsecaseParam param)async{
    try {

      // await firestore.
 await firestore
      .collection('members')
      .add(param.toMap());

      return CreateMemberRemoteUsecaseOut(member: param.member);
      
    } catch (e) {

      throw ServerException(message: "Failed to createRemote Member ${e.toString()}", statusCode: 401);
      
      
    }
  }


  Future<CreateMessageRemoteUsecaseOut> createMessageRemote(CreateMessageRemoteUsecaseParam param)async{
    try {
      await firestore.collection('message').add(param.toMap());
      return CreateMessageRemoteUsecaseOut(message: param.message);
      
    } catch (e) {
      throw ServerException(message: "Failed to create message ${e.toString()}", statusCode: 123);
      
    }
  }

   Future<CreateRoomRemoteUsecaseOut> createRoomRemote(CreateRoomRemoteUsecaseParam param)async{
    try {
      await firestore.collection('rooms').add(param.toMap());
      return CreateRoomRemoteUsecaseOut(room: param.room);
      
    } catch (e) {
throw ServerException(message: "Failed TO Create room ${e.toString()}", statusCode: 342);
      
    }
   }
  
}