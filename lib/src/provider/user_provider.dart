import 'dart:async';

import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/services/RegistrationService.dart';
import 'package:flutter/widgets.dart';
//import 'package:cetis32_app_registro/src/utils/log_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  User _user;
  Registration _reg;

  User get getUser => _user;
  Registration get getRegistration => _reg;

  initUSer() {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((prefs) {
      if (prefs.containsKey("registration_id")) {
        String id = prefs.getString("registration_id");
        String access = prefs.getString("auth_method");
        setUser(id, access);
        print("setting timer");

        RegistrationService().get(id).then((registration) {
          print("ejecutando get registration");
          if (registration != null) setRegistration(registration);
        });
      }
    });
  }

  setUser(String id, String access) {
    _user = new User(id, access);
    notifyListeners();
  }

  setRegistration(Registration reg) {
    _reg = reg;
    notifyListeners();
  }
}
