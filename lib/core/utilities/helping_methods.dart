import 'package:uuid/uuid.dart';

String generateLocalId(){
  final localId = const Uuid().v4();
  return localId;
}