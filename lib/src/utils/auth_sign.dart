import 'dart:math';

import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/screens/initial_screen.dart';
import 'package:cetis32_app_registro/src/services/AuthenticationService.dart';
import 'package:cetis32_app_registro/src/services/RegistrationService.dart';
import 'package:cetis32_app_registro/src/utils/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthSign {
  static RegistrationService registrationService = RegistrationService();

  static AuthenticationService authenticationService = AuthenticationService();

// * * *  Sign up email and password  * * *
  static signUpWithEmailAndPassword(String email) async {
    Map<String, dynamic> response =
        await RegistrationService().checkEmail(email);
    if (response["code"] == "failed_operation")
      return AuthResponseStatus.UNKNOW_ERROR;

    if (response["code"] == "email_not_found")
      return AuthResponseStatus.EMAIL_NOT_FOUND;

    Registration registration = response["registration"];
    if (registration == null) {
      return AuthResponseStatus.EMAIL_NOT_FOUND;
    }

    var password = generatePassword();

    Map<String, String> result = await authenticationService
        .signUpEmailAndPassword(email: email, password: password);

    switch (result['code']) {
      case "sign_up_success":
        await authenticationService.sendPassword(email, password);
        await authenticationService.savePassword(registration.id, password);
        return AuthResponseStatus.SUCCESS;
      case "email-already-in-use":
        return AuthResponseStatus.EMAIL_ALREADY_EXISTS;
      default:
        return AuthResponseStatus.UNKNOW_ERROR;
    }
  }

// * * *  Sign off  * * *
  static Future<bool> showConfimLogout(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Cerrar Sesión",
            //style: TextStyle(color: AppColors.morenaLightColor),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.logout_outlined,
                size: 50,
                color: Colors.orange.withOpacity(0.5),
              ),
              Text(
                "¿Abandonar la sesión?",
                textAlign: TextAlign.center,
              )
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 3,
          actions: <Widget>[
            Container(
                width: 120,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text("Cancelar",
                      style: TextStyle(color: Colors.black45, fontSize: 16)),
                )),
            Container(
                width: 120,
                child: OutlinedButton(
                  onPressed: () async {
                    // auth with firebase
                    final FirebaseAuth _auth = FirebaseAuth.instance;
                    try {
                      Navigator.pop(context, false);
                      await _auth.signOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InitialScreen()),
                          (route) => false);
                    } catch (error) {
                      print(error);
                    }
                  },
                  child: Text("Salir",
                      style: TextStyle(color: Colors.black45, fontSize: 16)),
                )),
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
