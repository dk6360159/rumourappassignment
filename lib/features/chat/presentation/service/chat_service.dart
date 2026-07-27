import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:rumour/core/base_service/base_service.dart';
import 'package:rumour/core/events/event_bus.dart';
import 'package:rumour/core/helpers/typedef.dart';
import 'package:rumour/features/chat/domain/usecases/create_member_local_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/create_member_remote_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/create_message_local_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/create_message_remote_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/create_room_local_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/create_room_remote_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/get_random_user_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/load_all_local_messages_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/load_all_local_rooms_usecase.dart';
import 'package:rumour/features/chat/presentation/models/room_member.dart';
import 'package:rumour/features/chat/presentation/models/room_model.dart';
import 'package:rumour/features/chat/presentation/models/message_model.dart';
import 'package:rumour/features/chat/presentation/service/chat_service_events.dart';

class  ChatService extends BaseService {

  ChatService({required this.uCreateMessageLocal,
  required this.uCreateMemberRemote,
  required this.uCreateMessageRemote,
  required this.uCreateRoomLocal,
  required this.uCreateRoomRemote,
  required this.uCreateMemberLocal,

  required this.uLoadAllLocalMessages,
  required this.uLoadAllLocalRooms,
  required this.uGetRandomUser,
  required EventBus bus}):
  _bus=bus,

  super(serviceMode: ServiceMode.appOnly);

  final CreateMessageLocalUsecase uCreateMessageLocal;
  final CreateMemberRemoteUsecase uCreateMemberRemote;
  final CreateMessageRemoteUsecase uCreateMessageRemote;
  final CreateRoomLocalUsecase uCreateRoomLocal;
  final CreateRoomRemoteUsecase uCreateRoomRemote;
  final CreateMemberLocalUsecase uCreateMemberLocal;

  final LoadAllLocalMessagesUsecase uLoadAllLocalMessages;
  final LoadAllLocalRoomsUsecase uLoadAllLocalRooms;

  final GetRandomUserUsecase uGetRandomUser;


  final EventBus _bus;



 final ValueNotifier<List<RoomMember>> _myChats=ValueNotifier([]);
  

  ValueListenable<List<RoomMember>> get myChats=>_myChats;
 final ValueNotifier<List<MessageModel>> _myMessages=ValueNotifier([]);
  

  ValueListenable<List<MessageModel>> get myMessages=>_myMessages;

StreamSubscription<QuerySnapshot>? _subscription;
ValueNotifier<RoomMember?> currentRoom=ValueNotifier(null);
ValueNotifier<List<MessageModel>> currentroomMessages=ValueNotifier([]);

DataMap? randomUser;

void changeCurrentRoom(RoomMember? room){

currentRoom.value=room;

}


 void _updateCurrentRoomMessages() {
    final room = currentRoom.value;

    if (room == null) {
      currentroomMessages.value = [];
      return;
    }

    currentroomMessages.value = _myMessages.value
        .where((message) => message.roomCode == room.roomCode)
        .toList();

print("current messae called and lenght is ${currentroomMessages.value.length}");

  }



Future<void> loadAllLocalMessages()async{
  final result = await uLoadAllLocalMessages(LoadAllLocalMessagesParam());

  result.fold(onSuccess:(value) {
    _myMessages.value=value.messages;

    _bus.fire(ChatTaskCompleted(input: null, output: value, task: ChatTask.loadAllLocalMessages));


    
  }, onFailure:(failure) {
    _bus.fire(ChatTaskFailed(input: null, failure: failure, task: ChatTask.loadAllLocalMessages));
    
  },);

}

Future<void> loadAllLocalRooms()async{
  final result = await uLoadAllLocalRooms(LoadAllLocalRoomsParam());

  result.fold(onSuccess:(value) {
    _myChats.value=value.rooms;

    _bus.fire(ChatTaskCompleted(input: null, output: value, task: ChatTask.loadAllLocalRooms));


    
  }, onFailure:(failure) {
    _bus.fire(ChatTaskFailed(input: null, failure: failure, task: ChatTask.loadAllLocalRooms));
    
  },);

}
  


Future<void> createMessageLocal(CreateMessageLocalUsecaseParam param)async{
  final result= await uCreateMessageLocal(param);

  result.fold(onSuccess:(value) {

    _bus.fire(ChatTaskCompleted(input: param, output: value, task: ChatTask.createMessageLocal));
    
    List<MessageModel> tempList=_myMessages.value;
    tempList.add(param.message);
    _myMessages.value= [...tempList];
  }, onFailure:(failure){
    _bus.fire(ChatTaskFailed(input: param, failure: failure, task: ChatTask.createMessageLocal));

  },);

}

Future<void> createMemberRemote(CreateMemberRemoteUsecaseParam param)async{
  final result= await uCreateMemberRemote(param);

  result.fold(onSuccess:(value) {

    _bus.fire(ChatTaskCompleted(input: param, output: value, task: ChatTask.createMemberRemote));
    
    createRoomMemberLocal(CreateMemberLocalUsecaseParam(member: param.member));
  }, onFailure:(failure){
    _bus.fire(ChatTaskFailed(input: param, failure: failure, task: ChatTask.createMemberRemote));

  },);

}

Future<void> createMessageRemote(CreateMessageRemoteUsecaseParam param)async{
  final result= await uCreateMessageRemote(param);

  result.fold(onSuccess:(value) {

    _bus.fire(ChatTaskCompleted(input: param, output: value, task: ChatTask.createMessageRemote));
    createMessageLocal(CreateMessageLocalUsecaseParam(message: param.message));
  }, onFailure:(failure){
    _bus.fire(ChatTaskFailed(input: param, failure: failure, task: ChatTask.createMessageRemote));

  },);

}

Future<void> createRoomMemberLocal(CreateMemberLocalUsecaseParam param)async{
  print("send to create local ${param.member.toMap()}");
  final result= await uCreateMemberLocal(param);

  result.fold(onSuccess:(value) {

    _bus.fire(ChatTaskCompleted(input: param, output: value, task: ChatTask.createMemberLocal));
    
    final templist=_myChats.value;
    templist.add(value.member);
    _myChats.value=[...templist];
  }, onFailure:(failure){
    _bus.fire(ChatTaskFailed(input: param, failure: failure, task: ChatTask.createMemberLocal));

  },);

}


Future<void> createRoomRemote(CreateRoomRemoteUsecaseParam param)async{
  final result= await uCreateRoomRemote(param);

  result.fold(onSuccess:(value) {

    _bus.fire(ChatTaskCompleted(input: param, output: value, task: ChatTask.createRoomRemote));

    createRoomMemberLocal(CreateMemberLocalUsecaseParam(member:RoomMember(deviceId: param.room.senderDeviceId, createDate: DateTime.now(), roomCode: param.room.roomCode, name: param.room.myName)));
    
  }, onFailure:(failure){
    _bus.fire(ChatTaskFailed(input: param, failure: failure, task: ChatTask.createRoomRemote));

  },);

}

Future<void> getRandomUser()async{
  print("get random user method called");
  final result= await uGetRandomUser(GetRandomUserParam());
  result.fold(onSuccess:(value) {
    randomUser=value.user;

    print("get randon user is $randomUser");
    
  }, onFailure:(failure) {
      print("get randon user is failurer $randomUser ${failure.message}");
    
  },);

}





void startListening(List<String> roomCodes) {
  _subscription = FirebaseFirestore.instance
      .collection('messages')
      .where('roomCode', whereIn: roomCodes)
      .orderBy('createDate')
      .snapshots()
      .listen(
    (snapshot) async {
      for (final change in snapshot.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            final message = MessageModel.fromMap(
              
            change.doc.data()!,
            
            );

            // Save to SQLite
            await createMessageLocal(CreateMessageLocalUsecaseParam(message: message));

          

            break;

          case DocumentChangeType.modified:
           

            break;

          case DocumentChangeType.removed:
            

            break;
        }
      }
    },
  );
}

  @override
  Future<void> onCleanup() async{
  }

  @override
  Future<void> onCloseup() async{
    currentRoom.removeListener(_updateCurrentRoomMessages);
    _myMessages.removeListener(_updateCurrentRoomMessages);
    
  }

  @override
  Future<void> onInit()async {
     currentRoom.addListener(_updateCurrentRoomMessages);
    _myMessages.addListener(_updateCurrentRoomMessages);

 await   loadAllLocalMessages();
   await loadAllLocalRooms();
    startListening(_myChats.value.map((room)=>room.roomCode).toList());
   getRandomUser();
  }
  
}