// * * *  Sign off  * * *
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../res/colors.dart';

Future<bool> showLogoutDialog(BuildContext context, String launcher) {
  String message = launcher == "main"
      ? "¿Abandonar la sesión?"
      : "Eliminar el dispositivo actual cerrará la sesión.\n ¿Desea continuar?";
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(height: 20),
                Image.asset(
                  'assets/img/logo-3.png',
                  width: 80,
                  color: AppColors.primary,
                ),
                SizedBox(height: 20),
              ],
            )),
        content: Text(
          message,
          textAlign: TextAlign.center,
          //  style: TextStyle(fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 3,
        actions: <Widget>[
          Container(
              width: 120,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                style: ElevatedButton.styleFrom(primary: AppColors.greyButton),
                child: Text("Cancelar", style: TextStyle(color: Colors.white)),
              )),
          Container(
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: AppColors.primary),
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text("Salir",
                    style: TextStyle(color: Colors.white.withOpacity(0.7))),
              )),
        ],
      );
    },
  );
}
