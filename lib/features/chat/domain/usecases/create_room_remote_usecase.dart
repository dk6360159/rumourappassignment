import 'package:rumour/core/helpers/typedef.dart';
import 'package:rumour/core/services/usecase.dart';
import 'package:rumour/features/chat/domain/repository/chat_repository.dart';
import 'package:rumour/features/chat/domain/usecases/create_room_local_usecase.dart';
import 'package:rumour/features/chat/presentation/models/room_model.dart';

class  CreateRoomRemoteUsecase extends UseCaseWithParams<CreateRoomRemoteUsecaseOut,CreateRoomRemoteUsecaseParam> {
  final ChatRepository repository;
  CreateRoomRemoteUsecase({required this.repository});
  
  @override
  ResultFuture<CreateRoomRemoteUsecaseOut> call(CreateRoomRemoteUsecaseParam params)async {
   final result= await repository.createRoomRemote(params);
   return result;

  }
 
  
}

class  CreateRoomRemoteUsecaseParam {
  final RoomModel room;
  CreateRoomRemoteUsecaseParam({required this.room});

  DataMap toMap(){
    return room.toMap();
  }
  
}

class  CreateRoomRemoteUsecaseOut {
  final RoomModel room;
  CreateRoomRemoteUsecaseOut({required this.room});
  
}