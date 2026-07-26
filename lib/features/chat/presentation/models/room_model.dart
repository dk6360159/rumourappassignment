import 'dart:math';

import 'package:rumour/core/helpers/mappable_class.dart';
import 'package:rumour/core/helpers/typedef.dart';
import 'package:rumour/core/utilities/helping_methods.dart';

class  RoomModel extends MappableClass<RoomModel>{

  RoomModel({required this.roomCode,required this.myName,required this.senderDeviceId,String? id}):id=id??generateLocalId();
final String id;
final String roomCode;
final String senderDeviceId;
final String myName;

  @override
  RoomModel fromMap(DataMap map) {
    return RoomModel(roomCode: map['roomCode'],senderDeviceId: map['senderId'],myName: map['myName']);
  }

  @override
  DataMap toMap() {
    return {
      'roomCode':roomCode,
      'senderId':senderDeviceId,
      'myName':myName
    };
  }

 
  
}

String generateRoomCode() {
  final random = Random();
  return (100000 + random.nextInt(900000)).toString();
}