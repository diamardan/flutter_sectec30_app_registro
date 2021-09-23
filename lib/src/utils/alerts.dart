import 'package:flutter/material.dart';
import 'package:cetis32_app_registro/src/constants/constants.dart';

class AppAlert {
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
            FlatButton(
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

  static Future<void> showSuccess(
      BuildContext context, String title, String message) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.blackTransparent,
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          titleTextStyle: TextStyle(color: Color(0xFFFFFFFF)),
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          contentTextStyle: TextStyle(color: Color(0xFFFFFFFF)),
          actions: <Widget>[
            FlatButton(
              child: Text('Aceptar', style: TextStyle(color: AppColors.yellow)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showError(
      BuildContext context, String title, String message, String error) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.blackTransparent,
          title: Text(title),
          titleTextStyle: TextStyle(color: Colors.white),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(message, style: TextStyle(color: Colors.white)),
            SizedBox(
              height: 10,
            ),
            Text(error, style: TextStyle(color: Colors.white)),
          ]),
          actions: <Widget>[
            FlatButton(
              child: Text('Aceptar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<bool> showConfim(BuildContext context, String title,
      String message, Color backgroundColor) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          content: Text(message),
          backgroundColor: backgroundColor,
          actions: <Widget>[
            FlatButton(
              child: Text("Continuar", style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            FlatButton(
              child: Text("Cancelar", style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        );
      },
    );
  }
}
