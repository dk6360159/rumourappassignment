
import 'package:rumour/core/events/event_bus.dart';

final class ChatTaskInProgress<I,O,T extends ChatTask> extends BaseEvent<I,O,T>{
  ChatTaskInProgress({required super.input, 
  super.failure,
  super.output,
  required super.task});

}

final class ChatTaskCompleted<I,O,T extends ChatTask> extends BaseEvent<I,O,T>{
  ChatTaskCompleted({
    required super.input,
  required super.output,
  super.failure,
   required super.task});

}

final class ChatTaskFailed<I,O,T extends ChatTask> extends BaseEvent<I,O,T>{
  ChatTaskFailed({required super.input, 
  required super.failure,
  super.output,
  required super.task});

}


enum ChatTask { loadAllLocalMessages,loadAllLocalRooms,  createMemberRemote,createMemberLocal,createMessageLocal,createMessageRemote,createRoomLocal,createRoomRemote}





