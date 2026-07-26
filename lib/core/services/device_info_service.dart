import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:rumour/core/base_service/base_service.dart';
import 'package:android_id/android_id.dart'; // For Android Id

import 'dart:io' show Platform;
class  DeviceInfoService extends BaseService{

  DeviceInfoService():super(serviceMode: ServiceMode.appOnly);

late final String _deviceId;


String get deviceId=> _deviceId;




  @override
  Future<void> onInit() async{

    await _loadDeviceId();


   
  }

  @override
  Future<void> onCleanup() async{
  }

  @override
  Future<void> onCloseup() async{
  
  }

    Future<void> _loadDeviceId() async {
    if (kIsWeb) {
      _deviceId = 'WEB_PLATFORM';
      return;
    }

    final info = DeviceInfoPlugin();

    if (Platform.isIOS) {
      final ios = await info.iosInfo;
      _deviceId = ios.identifierForVendor ?? 'IOS_IDENTIFIER_NOT_FOUND';
      return;
    }

    if (Platform.isAndroid) {
      const androidId = AndroidId();
      _deviceId = await androidId.getId() ?? 'ANDROID_ID_NOT_FOUND';
      return;
    }

    _deviceId = 'UNKNOWN_PLATFORM';
  }


  
}