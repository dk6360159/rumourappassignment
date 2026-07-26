
import 'dart:async';
import 'package:rumour/core/base_service/base_service.dart';
import 'package:rumour/core/events/event_bus.dart';
import 'package:rumour/core/extensions/log_extensions.dart';
import 'package:flutter/foundation.dart';

final class ServiceRegistry{

  ServiceRegistry(
    this._services,
    {
     
     required EventBus bus
  }):_bus= bus{
    _registerLifecycleListeners();
  }

  final List<BaseService> _services;
  final EventBus _bus;

  final ValueNotifier<double> progress=ValueNotifier(0.0);

   final ValueNotifier<String?> currentLabel=ValueNotifier(null);
    
  void _registerLifecycleListeners(){
    
    // _bus.on<>()
  }



  Future<void> initPreLogin()async{
    await _initServices(label: 'Pre-login initialization',
    filter:(s) => s.serviceMode!=ServiceMode.userRequired,
    );
  }

  Future<void> initPostLogin()async{
    await _initServices(label: 'Post-login initialization',
    filter:(s) => s.serviceMode!=ServiceMode.appOnly,
    );
  }

  Future<void> cleanupPostLogin()async{
    await _cleanupServices(filter: (s) => s.serviceMode==ServiceMode.userOptional||s.serviceMode==ServiceMode.userRequired,
    label:'Cleaning user Services'
    );
  }

  // shutdown

  Future<void> closeAll()async{
    progress.value=0.0;
    currentLabel.value='Closing all services...';
 '[ServiceRegistry] ⚫ Closing all services…'.logInfo();

 await Future.wait(_services.map((s)=>s.close()));
 progress.value=1.0;
 currentLabel.value='All Services closed';
'[ServiceRegistry] 🏁 All services closed successfully.'.logSuccess();


  }
  


Future<void> _initServices({
  required String label,
  required bool Function(BaseService s) filter
})async{
  final list= _services.where(filter).toList();
  progress.value=0.0;
  currentLabel.value=label;

  final total=list.length;
  var done=0;

  for(final service in list){
    if(service.state==ServiceState.ready||service.state==ServiceState.initializing||service.state==ServiceState.closed){
      done++;
      continue;
    }

    try{
      await service.init();
      '[ServiceRegistry] INIT ${service.runtimeType}'.logSuccess();

    }catch(e,st){
      logWarning('[ServiceRegistry] INIT Failed for ${service.runtimeType}',warning:e,stackTrace:st);

    }
    done++;
    progress.value=done/total;


  }
  currentLabel.value='$label complete';


}

Future<void> _cleanupServices({
  required String label,
  required bool Function(BaseService s) filter
})async{
  final list=_services.where(filter).toList();
  progress.value=0.0;
  currentLabel.value=label;
  final total=list.length;
  var done=0;
  for(final service in list){
    try{
      await service.cleanup();
      '[ServiceRegistry] CLEAN ${service.runtimeType}'.logSuccess();


    }catch(e,st){

   logWarning(
          '[ServiceRegistry] CLEAN failed for ${service.runtimeType}',
          warning: e,
          stackTrace: st,
        );

    }
    done++;
    progress.value=done/total;
  }

  currentLabel.value='$label complete';

}


  

  
}