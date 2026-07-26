

import 'package:rumour/core/events/event_bus.dart';
import 'package:rumour/core/local_db/local_db_service.dart';
import 'package:rumour/core/modules/module.dart';
import 'package:rumour/features/chat/data/chat_local_provider.dart';
import 'package:rumour/features/chat/data/chat_remote_provider.dart';
import 'package:rumour/features/chat/data/repository/chat_repo_impl.dart';
import 'package:rumour/features/chat/domain/repository/chat_repository.dart';
import 'package:rumour/features/chat/domain/usecases/create_member_local_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/create_member_remote_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/create_message_local_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/create_message_remote_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/create_room_local_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/create_room_remote_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/load_all_local_messages_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/load_all_local_rooms_usecase.dart';
import 'package:rumour/features/chat/presentation/service/chat_service.dart';

final List<Module> chatModules=<Module>[

  Module<ChatLocalProvider>(builder:() => ChatLocalProvider(localDbService: sl<LocalDbService>()),),
  Module<ChatRemoteProvider>(builder:() => ChatRemoteProvider(),),

  Module<ChatRepository>(builder:() => ChatRepoImpl(localProvider: sl<ChatLocalProvider>(), remoteProvider: sl<ChatRemoteProvider>()),),

 Module<CreateMessageLocalUsecase>(builder:() => CreateMessageLocalUsecase(repository: sl<ChatRepository>()),),
Module<CreateMemberRemoteUsecase>(builder:() => CreateMemberRemoteUsecase(repository: sl<ChatRepository>()),),
Module<CreateMessageRemoteUsecase>(builder:() => CreateMessageRemoteUsecase(repository: sl<ChatRepository>()),),
Module<CreateRoomLocalUsecase>(builder:() => CreateRoomLocalUsecase(repository: sl<ChatRepository>()),),
Module<CreateRoomRemoteUsecase>(builder:() => CreateRoomRemoteUsecase(repository: sl<ChatRepository>()),),
Module<CreateMemberLocalUsecase>(builder:() => CreateMemberLocalUsecase(repository: sl<ChatRepository>()),),

Module<LoadAllLocalMessagesUsecase>(builder:() => LoadAllLocalMessagesUsecase(repository: sl<ChatRepository>()),),
Module<LoadAllLocalRoomsUsecase>(builder:() => LoadAllLocalRoomsUsecase(repository: sl<ChatRepository>()),),


 Module<ChatService>(builder:() => ChatService(uCreateMessageLocal: sl<CreateMessageLocalUsecase>(),
 uCreateMemberLocal: sl<CreateMemberLocalUsecase>(),
 uLoadAllLocalMessages: sl<LoadAllLocalMessagesUsecase>(),
 uLoadAllLocalRooms: sl<LoadAllLocalRoomsUsecase>(),
 
  bus:sl<EventBus>(), uCreateMemberRemote: sl<CreateMemberRemoteUsecase>(), uCreateMessageRemote: sl<CreateMessageRemoteUsecase>(), uCreateRoomLocal: sl<CreateRoomLocalUsecase>(), uCreateRoomRemote: sl<CreateRoomRemoteUsecase>()),)

];