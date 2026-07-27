import 'package:rumour/core/helpers/typedef.dart';
import 'package:rumour/core/services/usecase.dart';
import 'package:rumour/features/chat/domain/repository/chat_repository.dart';

class GetRandomUserUsecase extends UseCaseWithParams<GetRandomUserOut,GetRandomUserParam>{
  final ChatRepository repository;
  GetRandomUserUsecase({required this.repository});
  @override
  ResultFuture<GetRandomUserOut> call(GetRandomUserParam params)async {
    final result= await repository.getRandomUser(params);
    return result;
  }
  
}

class  GetRandomUserParam {
  
}

class  GetRandomUserOut {
  final DataMap user;
  GetRandomUserOut({required this.user});
  
}