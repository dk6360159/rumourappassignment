import 'package:rumour/core/helpers/typedef.dart';
import 'package:rumour/core/services/usecase.dart';
import 'package:rumour/features/chat/domain/repository/chat_repository.dart';
import 'package:rumour/features/chat/presentation/models/room_model.dart';

class CreateRoomLocalUsecase extends UseCaseWithParams<CreateRoomLocalUsecaseOut,CreateRoomLocalUsecaseParam> {
  final ChatRepository repository;
  CreateRoomLocalUsecase({required this.repository});
  @override
  ResultFuture<CreateRoomLocalUsecaseOut> call(CreateRoomLocalUsecaseParam params) async{
   final result=await repository.createRoomLocal(params);
   return result;
  }
  
}

class CreateRoomLocalUsecaseParam {
  final RoomModel room;
  CreateRoomLocalUsecaseParam({required this.room});

  DataMap toMap(){
    return room.toMap();
  }


  
}

class  CreateRoomLocalUsecaseOut {
  final RoomModel room;
  CreateRoomLocalUsecaseOut({required this.room});
  
}