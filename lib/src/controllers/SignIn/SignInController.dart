import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/provider/Device.dart';
import 'package:cetis32_app_registro/src/provider/user_provider.dart';
import 'package:cetis32_app_registro/src/services/AuthenticationService.dart';
import 'package:cetis32_app_registro/src/services/DeviceService.dart';
import 'package:cetis32_app_registro/src/services/MessagingService.dart';
import 'package:cetis32_app_registro/src/services/RegistrationService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController {
  final RegistrationService registrationService = RegistrationService();
  final AuthenticationService authenticationService = AuthenticationService();
  final MessagingService messagingService = MessagingService();
  final DeviceService deviceService = DeviceService();
  Registration r;
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> registerDevice(Registration r) async {
    if (r.devices.length < r.maxDevicesAllowed) {
      Device device = await DeviceProvider.instance.device;
      String token = await messaging.getToken();
      DeviceProvider.instance.addToken(token);
      await registrationService.addDevice(r.id, device.toJson());
      return "device_registered_success";
    } else
      return "max_devices_registered";
  }

  unregisterDevice(String regId) async {
    Device device = await DeviceProvider.instance.device;
    registrationService.removeDevice(regId, device.id);
  }

  subscribeToTopics(Registration r) {
    messagingService.subscribeToTopics(r);
  }

  unsubscribeFromTopics(Registration r) {
    messagingService.unsubscribeFromTopics(r);
  }

  _createState(BuildContext context, Registration reg, String access) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setUser(reg.id, access);
    //reg.resetMessagingInfo();
    userProvider.setRegistration(reg);
  }

  _createPersistence(Registration r, String access) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("registration_id", r.id);
    prefs.setString("auth_method", access);
  }

  setStateAndPersistence(
      BuildContext context, Registration reg, String access) {
    _createState(context, r, access);
    _createPersistence(r, access);
  }
}
