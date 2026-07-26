import 'package:rumour/core/helpers/typedef.dart';
import 'package:rumour/core/services/usecase.dart';
import 'package:rumour/features/chat/data/repository/chat_repo_impl.dart';
import 'package:rumour/features/chat/domain/repository/chat_repository.dart';
import 'package:rumour/features/chat/presentation/models/message_model.dart';

class LoadAllLocalMessagesUsecase extends UseCaseWithParams<LoadAllLocalMessagesOut,LoadAllLocalMessagesParam> {
  final ChatRepository repository;
  LoadAllLocalMessagesUsecase({required this.repository});
  @override
  ResultFuture<LoadAllLocalMessagesOut> call(LoadAllLocalMessagesParam params) async{
   final result= await repository.loadAllLocalMessages(params);
   return result;
  }
  
}

class  LoadAllLocalMessagesParam {
  
}

class  LoadAllLocalMessagesOut {

  final List<MessageModel> messages;
LoadAllLocalMessagesOut({required this.messages});
  
}