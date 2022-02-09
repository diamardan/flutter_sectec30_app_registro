import 'package:cetis32_app_registro/src/screens/initial_screen.dart';
import 'package:cetis32_app_registro/src/screens/notifications/attachments_screen.dart';
import 'package:cetis32_app_registro/src/screens/notifications/notifications_screen.dart';
import 'package:cetis32_app_registro/src/screens/pago/payment_wrapper.dart';
import 'package:cetis32_app_registro/src/screens/preregistro/create_form.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes(BuildContext context) {
  return <String, WidgetBuilder>{
    'inicio': (BuildContext context) => InitialScreen(),
    'formPreregistro': (BuildContext context) => PreregForm(),
    'pagar': (BuildContext context) => PaymentPage(),
    'wrapper': (BuildContext context) => PaymentPage(),
    'notifications': (BuildContext context) => NotificationsScreen(),
    'notifications-attachments': (BuildContext context) => AttachmentsScreen(),
    // 'accesses': (BuildContext context) => AccessesScreen(),
    //'verCredencialDigital': (BuildContext context) => DigitalCredentialScreen(),
  };
}
