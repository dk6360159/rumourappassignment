
import 'package:rumour/core/errors/failures.dart';

abstract class Result<T>{
  Result();


  factory Result.success(T value)=SuccessResult<T>;
  factory Result.failure(AppFailure failure) =FailureResult<T>;

  R fold<R>({
    required R Function(T value ) onSuccess,
    required R Function(AppFailure failure) onFailure
  });


  bool get isSuccess => this is SuccessResult<T>;
  bool get isFailure => this is FailureResult<T>;
  
}


class SuccessResult<T> extends Result<T>{
  final T value;
  SuccessResult(this.value);
  
  @override
  R fold<R>({required R Function(T value) onSuccess, required R Function(AppFailure failure) onFailure}) {
  return onSuccess(value);
  }

}

class FailureResult<T> extends Result<T>{
  final AppFailure failure;
  FailureResult(this.failure);
  
  @override
  R fold<R>({required R Function(T value) onSuccess, required R Function(AppFailure failure) onFailure}) {
 
    return onFailure(failure);

  }

  
}


  extension UnWrapRsult<T> on Result<T>{
    T unWrapOrThrow(){
      return fold(onSuccess:(value) => value,
      onFailure:(failure) => throw failure.toException(),
      
      );
    }


      Result<void> toVoid()=> fold(onSuccess: (_)=> Result.success(null), onFailure:(failure) => Result.failure(failure),);
  }



  


