import 'package:rumour/core/base_service/service_registry.dart';
import 'package:rumour/core/events/event_bus.dart';
import 'package:rumour/core/local_db/local_db_service.dart';
import 'package:rumour/core/modules/core_modules/core_modules.dart';
import 'package:rumour/core/modules/feature_modules/chat_modules.dart';
import 'package:rumour/core/modules/module.dart';
import 'package:rumour/core/services/device_info_service.dart';
import 'package:rumour/features/chat/presentation/service/chat_service.dart';

final List<Module> modules=<Module>[
  ...coreModules,
  ...chatModules,

  Module<ServiceRegistry>(builder:() => ServiceRegistry([
    sl<DeviceInfoService>(),
      sl<LocalDbService>(),
    sl<ChatService>(),
  
    

  ], bus: sl<EventBus>()),)


];