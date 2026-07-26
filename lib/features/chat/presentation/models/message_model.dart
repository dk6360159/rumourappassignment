import 'package:rumour/core/helpers/mappable_class.dart';
import 'package:rumour/core/helpers/typedef.dart';
import 'package:rumour/core/utilities/helping_methods.dart';

class  MessageModel extends MappableClass<MessageModel> {

  MessageModel({String? id,
  required this.createDate,
  
  required this.messageText,required this.roomCode,required this.sendDeviceId,required this.senderName}):id=id??generateLocalId();


  final String id;
  final String messageText;
  final String roomCode;
  final String sendDeviceId;
  final String senderName;

 final DateTime createDate;
  



factory MessageModel.fromMap(DataMap map){
  return MessageModel(id: map['id'], 
  messageText: map['text'],
   roomCode: map['roomCode'],
   createDate: DateTime.fromMillisecondsSinceEpoch(map['createDate']),
   sendDeviceId: map['senderId'],
   senderName: map['senderName']
   );
}

  @override
  MessageModel fromMap(DataMap map) {
    return MessageModel.fromMap(map);
  }

  @override
  DataMap toMap() {
  return {
    'id':id,
    'text':messageText,
    'roomCode':roomCode,
    'senderId':sendDeviceId,
    'senderName':senderName,
    'createDate':createDate.millisecondsSinceEpoch

  };
  }










}