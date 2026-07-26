import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rumour/core/extensions/log_extensions.dart';

enum ServiceMode{
  appOnly,
  userOptional,
  userRequired
}

enum ServiceState{
  created,
  initializing,
  ready,
  cleaning,
  cleaned,
  closed
}


abstract class BaseService{
  BaseService({required this.serviceMode});

  final ServiceMode serviceMode;

  final List<StreamSubscription> _subs=[];
  final List<VoidCallback> _notifierDisposers=[];

  ServiceState _state= ServiceState.created;
  ServiceState get state=> _state;


  Completer<void>? _initCompleter;
  
  bool get isReady=> _state==ServiceState.ready;

  Future<void> get ready async{
    if(isReady) return ;
    _initCompleter??=Completer<void>();
    return _initCompleter!.future;
  }


  void logGeneric(String msg){
    '[$runtimeType] $msg'.logInfo();

  }

  void logErrorInfo(String msg, {
    Object? error,
    StackTrace? st
  }){

    '[$runtimeType] $msg'.logError(error:error,stackTrace:st);
  }


  // init lifecycle

  Future<void> init()async{
    switch(_state){

      case ServiceState.ready:
        return ;
      case ServiceState.initializing:
      return ready;

      case ServiceState.closed:
       throw StateError(
        'Cannot intialize $runtimeType whill cleaning'
       );

      case ServiceState.created:
      case ServiceState.cleaned:
        break;

      default:
      break;

    }

    logGeneric('-> INIT Started');
    _state=ServiceState.initializing;
    _initCompleter??=Completer<void>();

    try{
      await onInit();
      _state=ServiceState.ready;
      logGeneric('✔️ INIT Complete');
      _initCompleter?.complete();

    }catch(e, st){
      _state=ServiceState.created;
      logErrorInfo('⚠️ INIT failed: $e', error:e,st:st);
      _initCompleter?.completeError(e,st);
      rethrow;
    }
    return ;
  }


  Future<void> cleanup()async{
    if(_state==ServiceState.closed){
      logGeneric('Cleanup Skipped: already closed');
      return;
    }
    if(_state==ServiceState.cleaning){
      logGeneric('Cleanup Skipped: already cleaning');
      return;
    }
    _state=ServiceState.cleaning;
    logGeneric('-> CLEANUP Stated');
    
    try{
      await onCleanup();


    }finally{

      await _cancelSub();
      _state=ServiceState.cleaned;
      _initCompleter=null;
      logGeneric('✔️ Cleanup Complete -> state=cleaned');


    }
  }

  Future<void> close()async{
    if(_state==ServiceState.closed){
      logGeneric('Close skipped: already closed');
      return ;
    }
    logGeneric('-> Close started');

    await cleanup();

    try{
      await onCloseup();


    }catch(e,st){
      logErrorInfo(' Close Error: $e',error:e,st:st);

    }

    _state=ServiceState.closed;
    logGeneric('✔️ Close Completed -> state=closed');
  }



  
    @protected
    Future<void> onInit();

    @protected 
    Future<void> onCleanup();

    @protected
    Future<void> onCloseup();

    @protected
    void addSub(StreamSubscription sub){
      _subs.add(sub);
    }


    Future<void> _cancelSub()async{
      for(final sub in _subs){
        try{
          await sub.cancel();

        }catch (e){

        '[$runtimeType] Error cancelling subscription : $e'.logError();
        }
        _subs.clear();
      }
    }





}