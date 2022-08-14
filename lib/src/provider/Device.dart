import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class Device {
  final String id;
  final String brand;
  final String model;
  final String os;
  final String version;
  String fcmToken;

  Device(
      {this.id, this.brand, this.model, this.version, this.os, this.fcmToken});

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        id: json["id"],
        brand: json["brand"],
        model: json["model"],
        version: json["version"],
        os: json["os"],
        fcmToken: json["fcm_token"],
      );

  @override
  String toString() {
    var strOutput = ''' id $id\n 
            brand $brand \n  
            model: $model \n 
            os: $os \n  
            version: $version \n
            fcmToken: $fcmToken 
            ''';
    return strOutput;
  }

  Map<String, String> toJson() => {
        "id": id,
        "brand": brand,
        "model": model,
        "version": version,
        "os": os,
        "fcm_token": fcmToken
      };
}

class DeviceProvider {
  Device _device;
  DeviceProvider._();

  static final DeviceProvider instance = DeviceProvider._();

  Future<Device> get device async {
    if (_device != null) return _device;
    _device = await _create();
    return _device;
  }

  addToken(String token) {
    _device.fcmToken = token;
  }

  Future<Map<String, String>> _getIosInfo(DeviceInfoPlugin deviceInfo) async {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return {
      "id": iosDeviceInfo.identifierForVendor,
      "brand": iosDeviceInfo.systemName,
      "model": iosDeviceInfo.model,
      "os": "iOS",
      "version": iosDeviceInfo.systemVersion,
    };
  }

  Future<Map<String, String>> _getAndroidInfo(
      DeviceInfoPlugin deviceInfo) async {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return {
      "id": androidDeviceInfo.id,
      "brand": androidDeviceInfo.brand,
      "model": androidDeviceInfo.model,
      "os": "android",
      "version": androidDeviceInfo.version.release,
    };
  }

  Future<Device> _create() async {
    Map<String, String> info = {};
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS)
      info = await _getIosInfo(deviceInfo);
    else
      info = await _getAndroidInfo(deviceInfo);

    return Device.fromJson(info);

    // Do initialization that requires async
    //await component._complexAsyncInit();
  }
}
