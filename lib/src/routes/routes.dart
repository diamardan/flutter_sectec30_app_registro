import 'package:flutter/material.dart';
import 'package:lumen_app_registro/src/screens/initial_screen.dart';
import 'package:lumen_app_registro/src/screens/preregistro/create_form.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'inicio': (BuildContext context) => InitialScreen(),
    'formPreregistro': (BuildContext context) => PreregForm()
  };
}