

import 'package:rumour/core/abstractions/logging_abstraction.dart';
extension LogExtension on Object? {
  void logSuccess({
    Object? info,
    StackTrace? stackTrace,
    String loggerName='App'
  }){
    LoggingAbstraction.instance.success(
      toString(),
      loggerName: loggerName,
      error:info,
      stackTrace:stackTrace
    );
    

  }

  void logDebug({
    Object? info,
    StackTrace? stackTrace,
    String loggerName='APP'
  }){

LoggingAbstraction.instance.debug(toString(),
loggerName:loggerName,
error:info,
stackTrace:stackTrace
);

  }

  void logInfo({
    Object? info,
    StackTrace? stackTrace,
    String loggerName='App'
  })
 { LoggingAbstraction.instance.info(
    toString(),
    loggerName:loggerName,
    error:info,
    stackTrace:stackTrace


  );}

  void logWarning(String s,{
    Object? warning,
    StackTrace? stackTrace,
    String loggerName='App'
  }){
    LoggingAbstraction.instance.warning(toString(),loggerName:loggerName,error:warning,stackTrace:stackTrace);
  }

  void logError({
    Object? error,
    StackTrace? stackTrace,
    String loggerName='App'
  }){
    LoggingAbstraction.instance.error(toString(),loggerName:loggerName,error:error,stackTrace:stackTrace);
  }


}