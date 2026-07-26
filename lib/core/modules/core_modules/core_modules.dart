import 'package:rumour/core/events/event_bus.dart';
import 'package:rumour/core/local_db/local_db_service.dart';
import 'package:rumour/core/modules/module.dart';
import 'package:rumour/core/services/device_info_service.dart';

final coreModules=<Module>[
  Module<EventBus>(builder:() => EventBus(),),
  Module<DeviceInfoService>(builder:() => DeviceInfoService(),),
  Module<LocalDbService>(builder:() => LocalDbService() ,),

  




];