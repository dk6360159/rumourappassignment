

import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable {
  final String message;
  final StackTrace? stackTrace;

 const AppException( this.message,[this.stackTrace]);
@override
 String toString(){

 final stackTraceInfo=stackTrace!=null?'\nSTack Trace: \n$stackTrace':'';

 return '${runtimeType.toString()}: $message $stackTraceInfo';
 }
  
}

/// Server-related exception

class ServerException extends AppException{
final int statusCode;
const ServerException({
  required String message,
  required this.statusCode,
  StackTrace? stackTrace
}):super( message,stackTrace);


@override
List<Object?> get props=> [message,statusCode,stackTrace];
}
/// Serialization-related exception
class SerializationException extends AppException {
  const SerializationException(super.message, [super.stackTrace]);

  @override
  List<Object?> get props => [message, stackTrace];
}

class LocalException extends AppException{
  const LocalException({required String message, StackTrace? stackTrace}):super(message,stackTrace);

  @override
  List<Object?> get props => [message,stackTrace];

}

class NetworkException extends AppException {
 const NetworkException(super.message,super.stackTrace);

 factory NetworkException.quick(){
  return NetworkException(
    'Internet Connection is required',
    StackTrace.current
  );
 }

 @override
 List<Object?> get props => [message,stackTrace];


}

String extractServerErrorMesssage(dynamic responseBody){
  if(responseBody==null){
    return 'Unknown server error (empty response)';

  }
  if(responseBody is String){
    return responseBody.isNotEmpty? responseBody:"Unknown server error";
  }
  if(responseBody is Map<String,dynamic>){
    final msg=responseBody['message'];
    if(msg is String) return msg;
    if(msg!=null) return msg.toString();
    final error =responseBody['error'];
    if(error is String) return error;
    if(error !=null) return error.toString();
    return responseBody.toString();
  }
  return responseBody.toString();
}