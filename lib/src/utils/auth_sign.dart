import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/screens/initial_screen.dart';
import 'package:cetis32_app_registro/src/services/RegistrationService.dart';
import 'package:cetis32_app_registro/src/services/AuthenticationService.dart';
import 'package:cetis32_app_registro/src/utils/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'dart:math';

class AuthSign {
  static RegistrationService registrationService = RegistrationService();

  static AuthenticationService authenticationService = AuthenticationService();

// * * *  Sign up email and password  * * *
  static signUpWithEmailAndPassword(String email) async {
    Registration registration = await RegistrationService().checkEmail(email);
    if (registration == null)
      return {'code': AuthResponseStatus.EMAIL_NOT_FOUND};

    var password = generatePassword();

    Map<String, String> result = await authenticationService
        .signUpEmailAndPassword(email: email, password: password);
    var response = {};
    switch (result['code']) {
      case "sign_up_success":
        await authenticationService.sendPassword(email, password);
        await authenticationService.savePassword(registration.id, password);
        response['code'] = AuthResponseStatus.SUCCESS;
        break;

      case "email-already-in-use":
        response['code'] = AuthResponseStatus.EMAIL_ALREADY_EXISTS;
        break;
      default:
        print(result['code']);
        response['code'] = AuthResponseStatus.AUTH_ERROR;
    }

    return response;
  }

// * * *  Sign off  * * *
  static Future<bool> showConfimLogout(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Cerrar Sesión",
            style: TextStyle(color: AppColors.morenaLightColor),
          ),
          content: Text("¿Desea continuar con esta acción?"),
          backgroundColor: Colors.white.withOpacity(0.7),
          elevation: 3,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text("Cancelarr", style: TextStyle(color: Colors.black45)),
            ),
            TextButton(
              onPressed: () async {
                // auth with firebase
                final FirebaseAuth _auth = FirebaseAuth.instance;
                try {
                  Navigator.pop(context, false);
                  await _auth.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => InitialScreen()),
                      (route) => false);
                } catch (error) {
                  print(error);
                }
              },
              child: Text("Salir", style: TextStyle(color: Colors.black45)),
            ),
          ],
        );
      },
    );
  }

  // * * *  Utilities  * * *

  static String generatePassword() {
    final length = 12;
    final letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    final letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    final number = '01234567890123456789';
    final special = '@#%+&#%+&';

    String chars = "";
    chars += '$letterLowerCase$letterUpperCase';
    chars += '$number';
    chars += '$special';

    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }
}
