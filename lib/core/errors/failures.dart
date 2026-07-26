import 'package:rumour/core/errors/exceptions.dart';
import 'package:equatable/equatable.dart';

abstract class AppFailure extends Equatable{
  final String message;
  final int statusCode;
  final String? source;
  final StackTrace? stackTrace;
  final String? errorType;

  const AppFailure({
    required this.message,
    required this.statusCode,
    this.source,
    this.stackTrace,
    this.errorType
  });

  @override
  List<Object?> get props =>[message,statusCode,source,stackTrace,errorType];


  factory AppFailure.fromException(AppException exception){
    final errorType=exception.runtimeType.toString();

    switch (exception.runtimeType){
      case const( ServerException):
      return ServerFailure(message: exception.message,statusCode:(exception as ServerException).statusCode,stackTrace:exception.stackTrace);
      case const(LocalException):
       return LocalFailure(
          message: exception.message,
          stackTrace: exception.stackTrace,
        );
      case const(SerializationException):
      return SerializationFailure(message: exception.message,
      stackTrace:exception.stackTrace
      );
       case const (NetworkException):
        return NetworkFailure(
          message: exception.message,
          stackTrace: exception.stackTrace,
        );
      default:
        return UnknownFailure(
          message: exception.toString(),
          stackTrace: exception.stackTrace,
          errorType: errorType,
        );

    }
  }


}

class ServerFailure extends AppFailure{
 const ServerFailure({
    required super.message,
    required super.statusCode,
    super.stackTrace
  }):super(source: "Server",errorType:'ServerException');
}

class LocalFailure extends AppFailure{
 const LocalFailure({
    required super.message,
    super.stackTrace
  }):super(statusCode: 902,source:'Local',errorType:'LocalException');
}

class SerializationFailure extends AppFailure{
  const SerializationFailure({required super.message,super.stackTrace}):super(statusCode: 903,
  source:'Serialization',
  errorType:'SerializationException'
  );
}

class UnknownFailure extends AppFailure{
  const UnknownFailure({
    required super.message,
    super.stackTrace,
    String? errorType,
    int? statusCode
  }):super(statusCode: statusCode??999,
  source:'Unknown',
  errorType:errorType??"UnknownException"
  
  );
}

class NetworkFailure extends AppFailure{
  const NetworkFailure({
    required super.message,required super.stackTrace
  }):super(statusCode: 666);
}


extension AppFailureX on AppFailure{
  AppException toException(){
    switch(runtimeType){
      case const (ServerFailure):
      return ServerException(message: message,statusCode:statusCode,stackTrace:stackTrace);

    case const(LocalFailure):
    return LocalException(message: message,stackTrace:stackTrace);

    case const(SerializationFailure):
    return NetworkException(message,stackTrace??StackTrace.current);

    case const(NetworkFailure):
    return NetworkException(message,stackTrace??StackTrace.current);

    case const (UnknownFailure):
    return LocalException(message: message,stackTrace:stackTrace);
    
    default:
    return LocalException(message: message,stackTrace:stackTrace);

    }
  }
}

/// specific failure types
/// 
final class ValidationFailure extends AppFailure{
  final List<String> errors;
  const ValidationFailure(this.errors):super(message: ' ',statusCode:0);


  Exception toException()=> Exception('Validation failed: ${errors.join(', ')}');
}

final class ParseFailure extends AppFailure{
  final String reason;
  const ParseFailure(this.reason):super(message: ' ',statusCode:0);
   
   Exception toException()=> Exception('Parse failed: $reason');

}
