import 'package:cetis32_app_registro/src/screens/initial_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:another_flushbar/flushbar_route.dart';

class NotifyUI {
  static Future<void> showBasic(
      BuildContext context, String title, String message) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.blackTransparent,
          title: Text(title),
          titleTextStyle: TextStyle(color: AppColors.redError),
          content: new Text(message, style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static flushbar(BuildContext context, String message) {
    Flushbar(
      messageText:
          Text(message, style: TextStyle(fontSize: 13, color: Colors.white)),
      margin: EdgeInsets.fromLTRB(2, 0, 2, 40),
      mainButton: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          'Entendido',
          style: TextStyle(color: Colors.blue),
        ),
      ),
    ).show(context);
  }

  static flushbarAutoHide(BuildContext context, String message) {
    Flushbar(
      messageText:
          Text(message, style: TextStyle(fontSize: 13, color: Colors.white)),
      margin: EdgeInsets.fromLTRB(2, 0, 2, 40),
      duration: Duration(seconds: 3),
    ).show(context);
  }

  static Future<void> showError(
      BuildContext context, String title, String message) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(title),
          titleTextStyle: TextStyle(
              color: AppColors.morenaColor,
              fontSize: 16,
              fontWeight: FontWeight.w500),
          content: Container(
            height: 100,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Container(
              child: Align(
                  alignment: Alignment.center,
                  child: Text(message, style: TextStyle(color: Colors.black))),
            ),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.05),
              border:
                  Border.all(color: Colors.grey.withOpacity(0.7), width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar',
                  style: TextStyle(color: AppColors.morenaColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
