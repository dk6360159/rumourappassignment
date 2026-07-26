


import 'package:rumour/core/extensions/log_extensions.dart';

final sl = ModuleLocator.instance;
class Module<T>{

final T Function() builder;

final bool lazy;

Type get type => T;
T? _instance;

Module({required this.builder,this.lazy=true});

void _createInstance(){
  _instance??=builder();
}

T getInstance(){
  _createInstance();
  return _instance!;
}

}

class ModuleLocator{
  ModuleLocator._();

  static final ModuleLocator instance=ModuleLocator._();
  final Map<Type,Module> _modules={};

  void registerMany<T>(List<Module> modules){
    for(var module in modules){
      final type=module.type;
      if(_modules.containsKey(type)){
        '$type is already registered'.logError();
        throw ModuleAlreadyRegisteredException(type: type);
        
      }
      _modules[type]=module;

      if(!module.lazy){
        module._createInstance();
      }
    }
  }


  T call<T>(){
    final module=_modules[T];
    if(module==null){
    throw ModuleNotFoundException(type: T);

    }
    return (module as Module<T>).getInstance();
  }

  void reset(){
    for(var module in _modules.values){
      module._instance=null;
    }
    _modules.clear();
  }



}

class ModuleNotFoundException implements Exception{
  final Type type;
  ModuleNotFoundException({required this.type});
}

class ModuleAlreadyRegisteredException implements Exception{
  final Type type;
  ModuleAlreadyRegisteredException({required this.type});
}