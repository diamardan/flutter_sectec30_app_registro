import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/widgets/manu_button.dart';
import 'package:cetis32_app_registro/src/widgets/whatsapp_help_btn.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class MenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("RUBEN DAVID DOMINGUEZ PEREZ"),
          //       style: TextStyle(fontStyle: FontStyle.italic),
          titleTextStyle: TextStyle(fontSize: 14),
          centerTitle: true,
          //toolbarHeight: 120,
        ),
        body: Stack(children: [
          /* Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/img/fondo.jpg')))),*/
          SingleChildScrollView(
            child: Center(
                child: Container(
                    //width: 310,
                    height: 900,
                    width: MediaQuery.of(context).size.width * .9,
                    // margin: EdgeInsets.symmetric(vertical: 40),
                    decoration: BoxDecoration(
                      //  color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      //mainAxisSize: MainAxisSize.min,

                      // mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        SizedBox(height: 15),
                        Row(children: [
                          Image.asset(
                            'assets/img/logo-3.png',
                            color: AppColors.morenaColor,
                            width: 80,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "SISTEMA ESCOLAR",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  "INTELIGENTE",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      fontStyle: FontStyle.italic),
                                ),
                              ]),
                        ]),
                        Divider(
                          thickness: 0.5,
                          height: 30,
                          color: AppColors.morenaColor.withOpacity(0.8),
                        ),

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
                          height: 10,
                        ),
                        MenuButton(
                            title: "Asistencia",
                            iconData: Icons.account_box_outlined,
                            route: "access"),
                        SizedBox(
                          height: 10,
                        ),
                        MenuButton(
                            title: "Recompensas",
                            iconData: Icons.star,
                            route: "access"),
                        SizedBox(
                          height: 10,
                        ),
                        MenuButton(
                            title: "Notificaciones",
                            iconData: Icons.circle_notifications_outlined,
                            route: "notifications"),
                        SizedBox(
                          height: 10,
                        ),
                        MenuButton(
                            title: "Credencial Inteligente",
                            iconData: Icons.ad_units_outlined,
                            route: "credential"),
                        SizedBox(
                          height: 10,
                        ),
                        MenuButton(
                            title: "Mis dispositivos",
                            iconData: Icons.phone_android_outlined,
                            route: "my-devices"),

                        /*  ConstrainedBox(
                        constraints: BoxConstraints.tight(Size(150, 40)),
                        child:*/
                      ],
                    ))),
          ),
          WhatsappHelpBtn(context: context)

          //
        ]));
  }
}
