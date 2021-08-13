import 'package:flutter/material.dart';
import 'package:cetis32_app_registro/src/constants/constants.dart';

class FormUtil {
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

  static Future<void> alertCustom(
      BuildContext context,
      String title,
      String message,
      backgrounColor,
      titleColor,
      contentColor,
      buttonColor,
      okColor) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgrounColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          titleTextStyle:
              TextStyle(color: titleColor, fontWeight: FontWeight.bold),
          contentPadding: EdgeInsets.all(0),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            Divider(
              color: Color(0XEE555555),
              height: 10.0,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                )),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(20))),
                    child: Center(
                        child:
                            Text('Aceptar', style: TextStyle(color: okColor)))))
          ]),
          contentTextStyle: TextStyle(color: contentColor),
          /*actions: <Widget>[
            Container(
              width: double.infinity,
              color: AppColor.cyanDark,
              child: Text('Aceptar', style: TextStyle(color: okColor)),
                onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],*/
        );
      },
    );
  }

  static Future<void> showAlert(
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

  static Future<void> showRequeridedAlert(
      BuildContext context, String title, String message) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.blackTransparent,
          titleTextStyle: TextStyle(color: Colors.white),
          content: new Text(message, style: TextStyle(color: Colors.red)),
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
}
