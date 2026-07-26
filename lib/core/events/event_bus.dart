import 'dart:async';

import 'package:rumour/core/errors/failures.dart';
import 'package:rumour/core/extensions/log_extensions.dart';

abstract class BaseEvent<I,O,T extends Enum> {
  I  input;
  O?  output;
  AppFailure?  failure;
  T  task;

  BaseEvent({required this.input,this.output,this.failure,required this.task});

  @override
  String toString(){
    return 'taskType: ${task.name} failure:${failure?.message} statusCode: ${failure?.statusCode} Input:$input output:$output';
  }
  

}

class EventBus{
  final _controller=StreamController<BaseEvent>.broadcast();

   /// fires an event
   void fire(BaseEvent event){
    print("${event.runtimeType} and ${event.task.name} and failure:${event.failure},success:${event.output.toString()}");
  // "${event.runtimeType} and failure:${event.failure},success:${event.output.toString()}".logInfo();
    if(!_controller.isClosed){
      _controller.add(event);
    }

  
   }


/// listens for evettnss of a specific type.

 Stream<T> on<T extends BaseEvent>(){
  return _controller.stream.where((event)=> event is T).cast<T>();

 }

 void dispose(){
  _controller.close();
  ('EventBus: Disposed. ').logInfo();
 }


}