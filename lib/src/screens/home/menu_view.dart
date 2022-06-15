import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/widgets/manu_button.dart';
import 'package:cetis32_app_registro/src/widgets/whatsapp_help_btn.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class MenuView extends StatelessWidget {
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
      Center(
          child: Container(
              //width: 310,
              height: 650,
              width: MediaQuery.of(context).size.width * .9,
              // margin: EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                //  color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Card(
                  child: Column(
                //mainAxisSize: MainAxisSize.min,

                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text(
                    "Sistema Escolar Inteligente",
                    style: TextStyle(
                        color: AppColors.morenaColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 21,
                        fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    'assets/img/logo-3.png',
                    color: AppColors.morenaColor,
                    width: 100,
                  ),
                  SizedBox(height: 30),
                  /*   Align(
                      alignment: Alignment.centerLeft,
                      child: Text("SELECCIONA UNA OPCIÓN",
                          // textAlign: TextAlign.start,
                          style:
                              TextStyle(fontSize: 16, color: Colors.black54))),*/
                  SizedBox(
                    height: 20,
                  ),
                  MenuButton(
                      title: "Accesos",
                      iconData: Icons.account_box_outlined,
                      route: "access"),
                  SizedBox(
                    height: 15,
                  ),
                  MenuButton(
                      title: "Notificaciones",
                      iconData: Icons.circle_notifications_outlined,
                      route: "notifications"),
                  SizedBox(
                    height: 15,
                  ),
                  MenuButton(
                      title: "Credencial Inteligente",
                      iconData: Icons.ad_units_outlined,
                      route: "credential"),
                  SizedBox(
                    height: 15,
                  ),
                  MenuButton(
                      title: "Mis dispositivos",
                      iconData: Icons.phone_android_outlined,
                      route: "my-devices"),
                  SizedBox(height: 30),
                  /*  ConstrainedBox(
                      constraints: BoxConstraints.tight(Size(150, 40)),
                      child:*/
                ],
              )))),
      WhatsappHelpBtn(context: context)

      //
    ]);
  }
}
