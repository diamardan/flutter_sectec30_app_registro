// * * *  Sign off  * * *
import 'package:flutter/material.dart';

import '../constants/constants.dart';

Future<bool> showLogoutDialog(BuildContext context, String launcher) {
  String message = launcher == "main"
      ? "¿Abandonar la sesión?"
      : "Eliminar el dispositivo actual cerrará la sesión.\n ¿Desea continuar?";
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "CETIS 32",
          style: TextStyle(color: AppColors.morenaColor, fontSize: 16),
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 3,
        actions: <Widget>[
          Container(
              width: 120,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.grey.withOpacity(0.7)),
                child: Text("Cancelar",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7), fontSize: 16)),
              )),
          Container(
              width: 120,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text("Salir",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 16)),
              )),
        ],
      );
    },
  );
}
