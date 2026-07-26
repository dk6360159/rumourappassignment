import 'package:rumour/core/helpers/typedef.dart';
import 'package:rumour/core/utilities/helping_methods.dart';

class RoomMember {

 final String id; 

final String roomCode;
final String deviceId;
final String name;
final DateTime createDate;


RoomMember({required this.deviceId,
required this.createDate,
String? id,
required this.roomCode,required this.name}):id=id??generateLocalId();


DataMap toMap(){
  return {
    'id':id,
    'roomCode':roomCode,
    'senderId':deviceId,
    'myname':name,
    'createDate':createDate.millisecondsSinceEpoch
  };
}

factory RoomMember.fromMap(DataMap map){
  return RoomMember(
    id: map['id'],
 roomCode: map['roomCode'],
    deviceId: map['senderId'],
  createDate: DateTime.fromMillisecondsSinceEpoch(map['createDate']),
   name: map['myname'],
   
   );
}


  
}