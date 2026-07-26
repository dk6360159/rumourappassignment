import 'package:rumour/core/helpers/typedef.dart';

abstract class  MappableClass<T> {


DataMap toMap();
T  fromMap(DataMap map);
  
}