import 'dart:ui';

import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/provider/user_provider.dart';
import 'package:cetis32_app_registro/src/screens/access/access_screen.dart';
import 'package:cetis32_app_registro/src/screens/home/my_data_view.dart';
import 'package:cetis32_app_registro/src/services/MessagingService.dart';
import 'package:cetis32_app_registro/src/services/RegistrationService.dart';
import 'package:cetis32_app_registro/src/utils/auth_sign.dart';
import 'package:cetis32_app_registro/src/utils/notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/RegistrationService.dart';

class HomeScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => _homeScreenState();
}

// ignore: camel_case_types
class _homeScreenState extends State<HomeScreen> {
  final RegistrationService registrationService = RegistrationService();
  final MessagingService messagingService = MessagingService();
  FirebaseMessaging messaging;
  int _viewIndex = 0;
  Registration registration = Registration();
  UserProvider userProvider;
  User user;

  _getStudentData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (user == null) {
      var id = prefs.getString("registration_id");
      var authMethod = prefs.getString("auth_method");
      user = User(id, authMethod);
    }

    Registration _registration = await registrationService.get(user.id);

    if (registration != null) {
      setState(() {
        registration = _registration;
      });
    }
  }

  @override
  void initState() {
    _getStudentData();
    Future.delayed(
        Duration(seconds: 10), () => AppNotifications.initialize(context));

    super.initState();
  }

  void _switchView(int index) {
    if (index == 2) {
      AuthSign.showConfimLogout(context);
      return;
    }

    setState(() {
      _viewIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: AppColors.morenaLightColor,
        ),
        child: Scaffold(
          body: _getView(),
          bottomNavigationBar: _bottomNavBar(context),
        ));
  }

  _bottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
            ),
            label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded), label: "Mis datos"),
        BottomNavigationBarItem(
            icon: Icon(Icons.logout_outlined), label: "Salir"),
      ],
      currentIndex: _viewIndex,
      selectedItemColor: AppColors.morenaLightColor,
      unselectedItemColor: Colors.grey,
      iconSize: 30,
      onTap: _switchView,
    );
  }

  Widget _getView() {
    Widget view;
    switch (_viewIndex) {
      case 0:
        view = _home();
        break;
      case 1:
        view = MyDataView();
        break;
    }
    return view;
  }

  _home() {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bienvenido a CETIS 32"),
          titleTextStyle: TextStyle(fontSize: 18),
          centerTitle: false,
          leading: Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 0, 10),
            child: Image.asset(
              'assets/img/logo-3.png',
              color: Colors.white,
              width: 10,
            ),
          ),
          backgroundColor: AppColors.morenaLightColor,
        ),
        body: Stack(children: [
          Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/img/fondo.jpg')))),
          Center(
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
                          style: TextStyle(
                              fontSize: 16, color: AppColors.textFieldLabel)),
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AccessesScreen(registration)));
                                  },
                                  child: Column(children: [
                                    Icon(Icons.account_box_outlined,
                                        size: 90,
                                        color: AppColors.morenaLightColor
                                            .withOpacity(0.6)),
                                    Text("Accesos",
                                        style: TextStyle(
                                            fontSize: 15,
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
                                  onPressed: () {},
                                  child: Column(children: [
                                    Icon(Icons.check_circle_outline_rounded,
                                        size: 90,
                                        color: AppColors.morenaLightColor
                                            .withOpacity(0.6)),
                                    Text("Asistencias",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15,
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
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, "notifications");
                                  },
                                  child: Column(children: [
                                    Icon(Icons.add_alert_outlined,
                                        size: 100,
                                        color: AppColors.morenaLightColor
                                            .withOpacity(0.6)),
                                    Text(
                                      "Notificaciones",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 11.5,
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
                                            fontSize: 14,
                                            color: AppColors.morenaLightColor
                                                .withOpacity(0.6)))
                                  ])))
                        ],
                      )
                    ],
                  )))
        ]));
  }
}
