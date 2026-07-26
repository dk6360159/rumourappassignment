import 'package:rumour/core/helpers/typedef.dart';
import 'package:rumour/core/services/usecase.dart';
import 'package:rumour/features/chat/domain/repository/chat_repository.dart';
import 'package:rumour/features/chat/presentation/models/room_member.dart';

class LoadAllLocalRoomsUsecase extends UseCaseWithParams<LoadAllLocalRoomsOut,LoadAllLocalRoomsParam> {
  final ChatRepository repository;
  LoadAllLocalRoomsUsecase({required this.repository});
  @override
  ResultFuture<LoadAllLocalRoomsOut> call(LoadAllLocalRoomsParam params) async{
   final result= await repository.loadAllLocalRooms(params);
   return result;
  }
  
}

class  LoadAllLocalRoomsParam {
  
}

class  LoadAllLocalRoomsOut {
  final List<RoomMember> rooms;
  LoadAllLocalRoomsOut({required this.rooms});
  
}