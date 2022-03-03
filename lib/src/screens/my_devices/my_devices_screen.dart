import 'package:cetis32_app_registro/src/provider/Device.dart';
import 'package:cetis32_app_registro/src/provider/user_provider.dart';
import 'package:cetis32_app_registro/src/services/RegistrationService.dart';
import 'package:cetis32_app_registro/src/widgets/log_out_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class MyDevicesScreen extends StatefulWidget {
  const MyDevicesScreen({Key key}) : super(key: key);

  @override
  _MyDevicesScreenState createState() => _MyDevicesScreenState();
}

class _MyDevicesScreenState extends State<MyDevicesScreen> {
  RegistrationService registrationService = RegistrationService();
  List devices = [];
  String userId;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _getDevices();

    super.didChangeDependencies();
  }

  _getDevices() {
    userId = Provider.of<UserProvider>(context).getUser.id;

    registrationService.get(userId).then((r) => setState(() {
          devices = r.devices;
        }));
  }

  _removeDevice(deviceId) async {
    Device myDevice = await DeviceProvider.instance.device;
    if (deviceId == myDevice.id) {
      showLogoutDialog(context, "my-devices-screen");
    } else
      registrationService.removeDevice(userId, deviceId);
    _getDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Mis dispositivos"),
          titleTextStyle: TextStyle(
              fontSize: 17, color: Colors.black87, fontWeight: FontWeight.w400),
          backgroundColor: Color(0XEEF5F5F5),
          foregroundColor: Colors.black87,
        ),
        body: ListView.builder(
            itemCount: devices.length,
            itemBuilder: (context, index) {
              var device = Device.fromJson(devices[index]);
              return Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 3, color: Color(0XFFEEEEEE)))),
                  child: ListTile(
                    leading: Icon(Icons.phone_android_outlined, size: 50),
                    title: Text(
                      "${device.brand.toString().capitalize()} ",
                      style: TextStyle(fontSize: 17),
                    ),
                    subtitle:
                        Text("${device.model}", style: TextStyle(fontSize: 14)),
                    trailing: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () => _removeDevice(device.id)),
                  ));
            }));
  }
}
