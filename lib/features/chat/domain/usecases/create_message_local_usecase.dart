import 'package:rumour/core/helpers/typedef.dart';
import 'package:rumour/core/services/usecase.dart';
import 'package:rumour/features/chat/domain/repository/chat_repository.dart';
import 'package:rumour/features/chat/presentation/models/message_model.dart';

class CreateMessageLocalUsecase extends UseCaseWithParams<CreateMessageLocalUsecaseOut,CreateMessageLocalUsecaseParam> {
  final ChatRepository repository;
  CreateMessageLocalUsecase({required this.repository});
  @override
  ResultFuture<CreateMessageLocalUsecaseOut> call(CreateMessageLocalUsecaseParam params) async{
 final result= await repository.createMessageLocal(params);
 return result;
  }
  
  
}


class  CreateMessageLocalUsecaseParam {

  final MessageModel message;
  CreateMessageLocalUsecaseParam({required this.message});


  DataMap toMap(){
    return message.toMap();
  }
  
}

class  CreateMessageLocalUsecaseOut {

  final MessageModel message;
  CreateMessageLocalUsecaseOut({required this.message});


  
  
}