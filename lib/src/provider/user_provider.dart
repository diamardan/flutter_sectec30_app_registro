import 'package:flutter/widgets.dart';
import 'package:cetis32_app_registro/src/models/user_model.dart';
//import 'package:cetis32_app_registro/src/utils/log_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  User _user;

  User get getUser => _user;

  UserProvider() {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    print("entré a constructor user provider");
    _prefs.then((prefs) {
      if (prefs.containsKey("registration_id")) {
        String id = prefs.getString("registration_id");
        String authMethod = prefs.getString("auth_method");
        setUser(id, authMethod);
      }
    });
  }

  Future<void> setUser(String id, String authMethod) async {
    _user = new User(id, authMethod);
    notifyListeners();
    return;
  }
}
