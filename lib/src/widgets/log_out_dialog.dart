// * * *  Sign off  * * *
import 'package:flutter/material.dart';

Future<bool> showLogoutDialog(BuildContext context, String launcher) {
  String message = launcher == "main"
      ? "¿Abandonar la sesión?"
      : "Eliminar el dispositivo actual cerrará la sesión.\n ¿Desea continuar?";
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
              message,
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
                  Navigator.pop(context, false);
                },
                child: Text("Cancelar",
                    style: TextStyle(color: Colors.black45, fontSize: 16)),
              )),
          Container(
              width: 120,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text("Salir",
                    style: TextStyle(color: Colors.black45, fontSize: 16)),
              )),
        ],
      );
    },
  );
}
