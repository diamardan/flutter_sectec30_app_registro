import 'package:cetis32_app_registro/src/widgets/manu_button.dart';
import "package:flutter/material.dart";

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/img/fondo.jpg')))),
      //  Center(
      Container(
          //width: 310,
          height: 540,
          // margin: EdgeInsets.symmetric(vertical: 40),
          decoration: BoxDecoration(
            //  color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            //mainAxisSize: MainAxisSize.min,

            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text("SELECCIONA UNA OPCIÓN",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54)),
              SizedBox(
                height: 20,
              ),
              MenuButton(
                  title: "Accesos",
                  iconData: Icons.account_box_outlined,
                  route: "access"),
              MenuButton(
                  title: "Notificaciones",
                  iconData: Icons.circle_notifications_outlined,
                  route: "notifications"),
              MenuButton(
                  title: "Credencial Inteligente",
                  iconData: Icons.ad_units_outlined,
                  route: "credential"),
              MenuButton(
                  title: "Mis dispositivos",
                  iconData: Icons.phone_android_outlined,
                  route: "my-devices"),
            ],
          ))
    ]);
  }
}
