import 'package:rumour/core/helpers/typedef.dart';
import 'package:rumour/core/services/usecase.dart';
import 'package:rumour/features/chat/domain/repository/chat_repository.dart';
import 'package:rumour/features/chat/presentation/models/room_member.dart';

class  CreateMemberLocalUsecase extends UseCaseWithParams<CreateMemberLocalUsecaseOut,CreateMemberLocalUsecaseParam> {
  final ChatRepository repository;
  CreateMemberLocalUsecase({required this.repository});
  @override
  ResultFuture<CreateMemberLocalUsecaseOut> call(CreateMemberLocalUsecaseParam params) async{
final result= await repository.createMemberLocal(params);
return result;
  }
  
}

class  CreateMemberLocalUsecaseParam {
  final RoomMember member;
  CreateMemberLocalUsecaseParam({required this.member});

  DataMap toMap(){
    return member.toMap();
  }



  
}

class CreateMemberLocalUsecaseOut {
  final RoomMember member;
  CreateMemberLocalUsecaseOut({required this.member});
  
}