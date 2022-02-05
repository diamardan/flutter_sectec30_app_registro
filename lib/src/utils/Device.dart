import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class Device {
  String id;
  String brand;
  String model;
  String os;
  String version;

  Device._create(
      {this.id, this.brand, this.model, this.version, this.os});

  static Future<Device> create() async {
    Map<String, String> info = {};
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      info = {
        "id": iosDeviceInfo.identifierForVendor,
        "brand": iosDeviceInfo.systemName,
        "model": iosDeviceInfo.model,
        "os": "iOS",
        "version": iosDeviceInfo.systemVersion,
      };
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      info = {
        "id": androidDeviceInfo.androidId,
        "brand": androidDeviceInfo.brand,
        "model": androidDeviceInfo.model,
        "os": "android" ,
        "version": androidDeviceInfo.version.release,
      };
    }

    var device = Device.fromJson(info);

    // Do initialization that requires async
    //await component._complexAsyncInit();

    return device;
  }


  factory Device.fromJson(Map<String, dynamic> json) => Device._create(
        id: json["id"],
        brand: json["brand"],
        model: json["model"],
        version: json["version"],
        os: json["os"],
      );

  @override
  String toString() {
    var strOutput =
        " id $id\n brand $brand \n  model: $model \n os: $os \n  version: $version \n ";
    return strOutput;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "brand": brand,
        "model": model,
        "version": version,
        "os": os,
      };
}
