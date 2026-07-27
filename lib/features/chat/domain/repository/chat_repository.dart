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

abstract class ChatRepository {



  ResultFuture<CreateMessageLocalUsecaseOut> createMessageLocal(CreateMessageLocalUsecaseParam param);
    ResultFuture<CreateMemberRemoteUsecaseOut> createMemberRemote(CreateMemberRemoteUsecaseParam param);
      ResultFuture<CreateMemberLocalUsecaseOut> createMemberLocal(CreateMemberLocalUsecaseParam param);
    ResultFuture<CreateMessageRemoteUsecaseOut> createMessageRemote(CreateMessageRemoteUsecaseParam param);
    ResultFuture<CreateRoomLocalUsecaseOut> createRoomLocal(CreateRoomLocalUsecaseParam param);
    ResultFuture<CreateRoomRemoteUsecaseOut> createRoomRemote(CreateRoomRemoteUsecaseParam param);

    ResultFuture<LoadAllLocalMessagesOut> loadAllLocalMessages(LoadAllLocalMessagesParam param);
  ResultFuture<LoadAllLocalRoomsOut> loadAllLocalRooms(LoadAllLocalRoomsParam param);
  ResultFuture<GetRandomUserOut> getRandomUser(GetRandomUserParam param);
}