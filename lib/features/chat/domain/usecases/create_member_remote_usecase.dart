import 'package:rumour/core/helpers/typedef.dart';
import 'package:rumour/core/services/usecase.dart';
import 'package:rumour/features/chat/domain/repository/chat_repository.dart';
import 'package:rumour/features/chat/presentation/models/room_member.dart';

class  CreateMemberRemoteUsecase extends UseCaseWithParams<CreateMemberRemoteUsecaseOut,CreateMemberRemoteUsecaseParam> {
  final ChatRepository repository;
  CreateMemberRemoteUsecase({required this.repository});
  @override
  ResultFuture<CreateMemberRemoteUsecaseOut> call(CreateMemberRemoteUsecaseParam params) async{
final result= await repository.createMemberRemote(params);
return result;
  }
  
}

class  CreateMemberRemoteUsecaseParam {
  final RoomMember member;
  CreateMemberRemoteUsecaseParam({required this.member});

  DataMap toMap(){
    return member.toMap();
  }



  
}

class CreateMemberRemoteUsecaseOut {
  final RoomMember member;
  CreateMemberRemoteUsecaseOut({required this.member});
  
}