
import 'package:rumour/core/helpers/typedef.dart';

abstract class UseCaseWithParams<T,Params> {
  UseCaseWithParams();

 ResultFuture<T> call(Params params);
}

abstract class UseWithoutParams<T>{
  UseWithoutParams();

  ResultFuture<T> call();
}
