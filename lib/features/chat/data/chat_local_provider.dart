import 'package:rumour/core/errors/exceptions.dart';
import 'package:rumour/core/local_db/local_db_provider.dart';
import 'package:rumour/core/local_db/local_db_service.dart';
import 'package:rumour/core/local_db/tables/table_names.dart';
import 'package:rumour/features/chat/domain/usecases/create_member_local_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/create_message_local_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/create_room_local_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/load_all_local_messages_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/load_all_local_rooms_usecase.dart';
import 'package:rumour/features/chat/presentation/models/message_model.dart';
import 'package:rumour/features/chat/presentation/models/room_member.dart';

class  ChatLocalProvider  {

  final LocalDbService localDbService;
  ChatLocalProvider({required this.localDbService});



  Future<CreateMessageLocalUsecaseOut> createMessageLocal(CreateMessageLocalUsecaseParam param)async{

    try {
    final result=await localDbService.insert(table: messageTableName, values: param.toMap());



     return CreateMessageLocalUsecaseOut(message: MessageModel.fromMap(result!));



      
    } catch (e) {
      throw LocalException(message: "Failed to create Message ${e.toString()}");
      
    }

  }


 Future<CreateRoomLocalUsecaseOut> createRoomLocal(CreateRoomLocalUsecaseParam param)async{
  try {
    final result= await localDbService.insert(table: roomTableName, values: param.toMap());
    
    return CreateRoomLocalUsecaseOut(room: param.room);
  } catch (e) {
    throw LocalException(message: "Failed to createLocal Room ${e.toString()}");
    
  }
 }



   Future<CreateMemberLocalUsecaseOut>createMemberLocal(CreateMemberLocalUsecaseParam param)async{
    try {
      print("before create local");
      final result= await localDbService.insert(table: roomTableName, values: param.toMap());
      print("result affter clreat local $result");
      return CreateMemberLocalUsecaseOut(member: param.member);

      
    } catch (e) {
      throw  LocalException(message: "Failed TO Create Member Local ${e.toString()}");
      
    }
   }
     Future<LoadAllLocalMessagesOut>loadAllLocalMessages(LoadAllLocalMessagesParam param)async{
    try {
      print("before create local");
      final result= await localDbService.findAll(table: messageTableName);
      
      final messages= result.map((e)=>MessageModel.fromMap(e)).toList();
      
      return LoadAllLocalMessagesOut(messages: messages);

      
    } catch (e) {
      throw  LocalException(message: "Failed TO Load message Local ${e.toString()}");
      
    }
   }

      Future<LoadAllLocalRoomsOut>loadAllLocalRooms(LoadAllLocalRoomsParam param)async{
    try {
      print("before create local");
      final result= await localDbService.findAll(table: roomTableName);
      
      final rooms= result.map((e)=>RoomMember.fromMap(e)).toList();
      
      return LoadAllLocalRoomsOut(rooms: rooms);

      
    } catch (e) {
      throw  LocalException(message: "Failed TO Load rooms Local ${e.toString()}");
      
    }
   }
  
}