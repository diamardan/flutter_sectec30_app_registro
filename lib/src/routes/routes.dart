import 'package:cetis32_app_registro/ui/screens/access/access_geo_screen.dart';
import 'package:cetis32_app_registro/ui/screens/access/access_screen.dart';
import 'package:cetis32_app_registro/ui/screens/access/register_access.dart';
import 'package:cetis32_app_registro/ui/screens/credential/digital_credential_screen.dart';
import 'package:cetis32_app_registro/ui/screens/home/home_screen.dart';
import 'package:cetis32_app_registro/ui/screens/home/profile_screen.dart';
import 'package:cetis32_app_registro/ui/screens/home/settings_screen.dart';
import 'package:cetis32_app_registro/ui/screens/incoming_screen.dart';
import 'package:cetis32_app_registro/ui/screens/login/wrapper_auth.dart';
import 'package:cetis32_app_registro/ui/screens/my_devices/my_devices_screen.dart';
import 'package:cetis32_app_registro/ui/screens/notifications/attachments_screen.dart';
import 'package:cetis32_app_registro/ui/screens/notifications/notifications_screen.dart';
import 'package:cetis32_app_registro/ui/screens/pago/payment_wrapper.dart';
import 'package:cetis32_app_registro/ui/screens/preregistro/create_form.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes(BuildContext context) {
  return <String, WidgetBuilder>{
    'formPreregistro': (BuildContext context) => PreregForm(),
    'pagar': (BuildContext context) => PaymentPage(),
    'wrapper': (BuildContext context) => Wrapper(),
    'access': (BuildContext context) => AccessesScreen(),
    'access-geo': (BuildContext context) => AccessesGeoScreen(),
    'notifications': (BuildContext context) => NotificationsScreen(),
    'notifications-attachments': (BuildContext context) => AttachmentsScreen(),
    'credential': (BuildContext context) => DigitalCredentialScreen(),
    'my-devices': (BuildContext context) => MyDevicesScreen(),
    'home': (BuildContext context) => HomeScreen(),
    'register-access': (BuildContext context) => RegisterAccess(),
    'settings': (BuildContext context) => SettingsScreen(),
    'incoming': (BuildContext context) => IncomingScreen(),
    'profile': (BuildContext context) => ProfileScreen(),

    //'verCredencialDigital': (BuildContext context) => DigitalCredentialScreen(),
  };
}
