import 'package:cetis32_app_registro/src/screens/home/digital_credential_screen.dart';
import 'package:flutter/material.dart';
import 'package:cetis32_app_registro/src/screens/initial_screen.dart';
import 'package:cetis32_app_registro/src/screens/pago/payment_wrapper.dart';
import 'package:cetis32_app_registro/src/screens/preregistro/create_form.dart';

Map<String, WidgetBuilder> getApplicationRoutes(BuildContext context) {
  return <String, WidgetBuilder>{
    'inicio': (BuildContext context) => InitialScreen(),
    'formPreregistro': (BuildContext context) => PreregForm(),
    'pagar': (BuildContext context) => PaymentPage(),
    'wrapper': (BuildContext context) => PaymentPage(),
    //'verCredencialDigital': (BuildContext context) => DigitalCredentialScreen(),
  };
}
