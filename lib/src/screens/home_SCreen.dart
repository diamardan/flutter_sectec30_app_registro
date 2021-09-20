import 'dart:ui';
import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("BIENVENIDO A CETIS 32"),
          centerTitle: true,
        ),
        body: Stack(children: [
          Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/img/fondo.jpg')))),
          _homeMenu()
        ]),
        bottomNavigationBar: _bottomNavBar(),
      ),
    );
  }

  _bottomNavBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.battery_full), label: "Recursos"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined), label: "Mis datos"),
      ],
      onTap: null,
      currentIndex: 0,
      fixedColor: Colors.green[800],
      iconSize: 30,
    );
  }

  _homeMenu() {
    return Center(
        child: Container(
            width: 310,
            height: 540,
            //padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              //mainAxisSize: MainAxisSize.min,

              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text("SELECCIONA UNA OPCIÓN",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20)),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 150,
                        width: 135,
                        child: OutlineButton(
                            onPressed: () {
                              print("hola");
                            },
                            child: Column(children: [
                              Icon(Icons.account_box_outlined,
                                  size: 90,
                                  color: AppColors.morenaLightColor
                                      .withOpacity(0.6)),
                              Text("Ver Accesos",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.morenaLightColor
                                          .withOpacity(0.6)
                                          .withBlue(20))),
                            ]))),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        height: 150,
                        width: 145,
                        child: OutlineButton(
                            onPressed: () {
                              print("hola");
                            },
                            child: Column(children: [
                              Icon(Icons.check_circle_outline_rounded,
                                  size: 90,
                                  color: AppColors.morenaLightColor
                                      .withOpacity(0.6)),
                              Text("Ver Asistencias",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.morenaLightColor
                                          .withOpacity(0.6)))
                            ])))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 140,
                        width: 130,
                        child: OutlineButton(
                            onPressed: () {},
                            child: Column(children: [
                              Icon(Icons.add_alert_outlined,
                                  size: 100,
                                  color: AppColors.morenaLightColor
                                      .withOpacity(0.6)),
                              Text(
                                "Abrir Notificaciones",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.morenaLightColor
                                        .withOpacity(0.6)),
                              )
                            ]))),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                        height: 140,
                        width: 130,
                        child: OutlineButton(
                            onPressed: () {},
                            child: Column(children: [
                              Icon(Icons.content_paste_outlined,
                                  size: 100,
                                  color: AppColors.morenaLightColor
                                      .withOpacity(0.6)),
                              Text("Protocolos",
                                  style: TextStyle(
                                      color: AppColors.morenaLightColor
                                          .withOpacity(0.6)))
                            ])))
                  ],
                )
              ],
            )));
  }
}
