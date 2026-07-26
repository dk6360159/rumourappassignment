import 'package:flutter/widgets.dart';
import 'package:rumour/core/helpers/typedef.dart';
import 'package:rumour/core/services/usecase.dart';
import 'package:rumour/features/chat/domain/repository/chat_repository.dart';
import 'package:rumour/features/chat/presentation/models/message_model.dart';

class CreateMessageRemoteUsecase extends UseCaseWithParams<CreateMessageRemoteUsecaseOut,CreateMessageRemoteUsecaseParam> {
     final ChatRepository repository;
    CreateMessageRemoteUsecase({required this.repository});
  @override
  ResultFuture<CreateMessageRemoteUsecaseOut> call(CreateMessageRemoteUsecaseParam params) async{
 
   final result= await repository.createMessageRemote(params);
   return result;
  }
  
}

class  CreateMessageRemoteUsecaseParam {
  final MessageModel message;
  CreateMessageRemoteUsecaseParam({required this.message});

  DataMap toMap(){
    return message.toMap();
  }
  
}

class CreateMessageRemoteUsecaseOut {
  final MessageModel message;
  CreateMessageRemoteUsecaseOut({required this.message});
  
}