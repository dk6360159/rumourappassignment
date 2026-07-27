import 'package:rumour/core/errors/exceptions.dart';
import 'package:rumour/core/errors/failures.dart';
import 'package:rumour/core/helpers/typedef.dart';
import 'package:rumour/core/utilities/monads/result.dart';
import 'package:rumour/features/chat/data/chat_local_provider.dart';
import 'package:rumour/features/chat/data/chat_remote_provider.dart';
import 'package:rumour/features/chat/domain/repository/chat_repository.dart';
import 'package:rumour/features/chat/domain/usecases/create_member_local_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/create_member_remote_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/create_message_local_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/create_message_remote_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/create_room_local_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/create_room_remote_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/get_random_user_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/load_all_local_messages_usecase.dart';
import 'package:rumour/features/chat/domain/usecases/load_all_local_rooms_usecase.dart';

class  ChatRepoImpl extends ChatRepository {
  final ChatLocalProvider localProvider;
  final ChatRemoteProvider remoteProvider;

  ChatRepoImpl({required this.localProvider,required this.remoteProvider});
  @override
  ResultFuture<CreateMessageLocalUsecaseOut> createMessageLocal(CreateMessageLocalUsecaseParam param)async {
    try {
      final result= await localProvider.createMessageLocal(param);

      return Result.success(result);
      
    }on AppException catch (e) {

      return Result.failure(AppFailure.fromException(e));
      
    }
  }

  @override
  ResultFuture<CreateMemberRemoteUsecaseOut> createMemberRemote(CreateMemberRemoteUsecaseParam param) async{
  try {
    final result= await remoteProvider.createMemberRemote(param);
    return Result.success(result);
    
  }on AppException catch (e) {
    return Result.failure(AppFailure.fromException(e));
    
  }
  }

  @override
  ResultFuture<CreateMessageRemoteUsecaseOut> createMessageRemote(CreateMessageRemoteUsecaseParam param)async {
   try {
    final result= await remoteProvider.createMessageRemote(param);
    return Result.success(result);
     
   }on AppException catch (e) {
    return Result.failure(AppFailure.fromException(e));

     
   }
  }

  @override
  ResultFuture<CreateRoomLocalUsecaseOut> createRoomLocal(CreateRoomLocalUsecaseParam param) async{
  try {
    final result= await localProvider.createRoomLocal(param);
    return Result.success(result);
    
  }on AppException catch (e) {
    return Result.failure(AppFailure.fromException(e));
    
  }
  }

  @override
  ResultFuture<CreateRoomRemoteUsecaseOut> createRoomRemote(CreateRoomRemoteUsecaseParam param) async{
    try {
      final result= await remoteProvider.createRoomRemote(param);
     

     return Result.success(result);

      
    }on AppException catch (e) {
      return Result.failure(AppFailure.fromException(e));
    }
  }

  @override
  ResultFuture<CreateMemberLocalUsecaseOut> createMemberLocal(CreateMemberLocalUsecaseParam param)async {
   try {
    final result= await localProvider.createMemberLocal(param);
    return Result.success(result);
     
   }on AppException catch (e) {
    return Result.failure(AppFailure.fromException(e));
     
   }
  }

  @override
  ResultFuture<LoadAllLocalMessagesOut> loadAllLocalMessages(LoadAllLocalMessagesParam param) async{
   try {
     final result= await localProvider.loadAllLocalMessages(param);
     return Result.success(result);
   }on AppException catch (e) {
    return Result.failure(AppFailure.fromException(e));
     
   }
  }

  @override
  ResultFuture<LoadAllLocalRoomsOut> loadAllLocalRooms(LoadAllLocalRoomsParam param)async {
    try {
      final result= await localProvider.loadAllLocalRooms(param);
      return Result.success(result);
      
    }on AppException catch (e) {
      return Result.failure(AppFailure.fromException(e));
      
    }
  }

  @override
  ResultFuture<GetRandomUserOut> getRandomUser(GetRandomUserParam param)async {
  try {
    final result= await remoteProvider.getRandomUser(param);
    return Result.success(result);
    
  }on AppException catch (e) {
    return Result.failure(AppFailure.fromException(e));
    
  }
  }
  
}