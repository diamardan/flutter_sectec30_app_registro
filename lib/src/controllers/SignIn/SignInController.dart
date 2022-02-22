import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/provider/user_provider.dart';
import 'package:cetis32_app_registro/src/services/AuthenticationService.dart';
import 'package:cetis32_app_registro/src/services/RegistrationService.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SignInController {
  final RegistrationService registrationService = RegistrationService();
  AuthenticationService authenticationService = AuthenticationService();
  Registration r;

  _createState(BuildContext context, Registration reg, String access) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setUser(reg.id, access);
    reg.resetMessagingInfo();
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
