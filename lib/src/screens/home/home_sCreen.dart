import 'dart:ui';
import 'package:cetis32_app_registro/main.dart';
import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/models/notification_model.dart'
    as NotificationModel;
import 'package:cetis32_app_registro/src/provider/user_provider.dart';
import 'package:cetis32_app_registro/src/screens/home/my_data_view.dart';
import 'package:cetis32_app_registro/src/services/MessagingService.dart';
import '../../services/RegistrationService.dart';
import 'package:cetis32_app_registro/src/services/RegistrationService.dart';
import 'package:cetis32_app_registro/src/utils/auth_actions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => _homeScreenState();
}

// ignore: camel_case_types
class _homeScreenState extends State<HomeScreen> {
  final RegistrationService registrationService = RegistrationService();
  final MessagingService messagingService = MessagingService();
  FirebaseMessaging messaging;
  Registration _registration;
  int _viewIndex = 0;
  User _user;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 10), initMessaging);

    super.initState();
  }

  initMessaging() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    _user = userProvider.getUser;
    _registration = userProvider.getRegistration;

    messaging = FirebaseMessaging.instance;

    setListeners() {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        // app on foreground
        print("message recieved");

        RemoteNotification notification = message.notification;

        AndroidNotification android = message.notification?.android;

        // If `onMessage` is triggered with a notification, construct our own
        // local notification to show to users using the created channel.
        if (notification != null && android != null) {
          NotificationModel.Notification myNotification =
              NotificationModel.Notification(
                  title: notification.title,
                  message: notification.body,
                  receivedDate: DateTime.now(),
                  sentDate: message.sentTime,
                  sender: message.senderId,
                  read: false);
          messagingService.save(myNotification);

          AndroidInitializationSettings android =
              AndroidInitializationSettings("@mipmap/launch");
          await flutterLocalNotificationsPlugin.initialize(
              InitializationSettings(android: android),
              onSelectNotification: onSelectNotification);

          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                  android: AndroidNotificationDetails(
                      channel.id, channel.name, channel.description,
                      icon: "@mipmap/launch"
                      // other properties...
                      )),
              payload: "go-to-notification");
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        //click from user on notification when app is backgroud
        print('Message clicked!');
        Navigator.pushNamed(context, 'notifications');
      });
    }

    print(_registration.toString());
    if (_registration.fcmToken == null) {
      messaging.getToken().then((value) {
        registrationService.setFCMToken(_user.id, value);
        setListeners();
        messagingService.suscribeToTopics(_registration);
      });
    } else {
      print("before setlisteners");
      setListeners();
      if (_registration.subscribedTo == null)
        messagingService.suscribeToTopics(_registration);
    }
  }

  Future<dynamic> onSelectNotification(payload) async {
    // implement the navigation logic
    if (payload == "go-to-notification") {
      Navigator.pushNamed(context, 'notifications');
    }
  }

  testNotification() async {
    AndroidInitializationSettings android =
        AndroidInitializationSettings("@mipmap/launch");
    await flutterLocalNotificationsPlugin.initialize(
        InitializationSettings(android: android),
        onSelectNotification: onSelectNotification);
    flutterLocalNotificationsPlugin.show(
        1,
        "hola",
        "test",
        NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id, channel.name, channel.description,
                icon: "@mipmap/launch"
                // other properties...
                )),
        payload: "go-to-notification");
  }

  void _switchView(BuildContext context, int index) {
    if (index == 2) {
      AuthActions.showConfimLogout(context);
      return;
    }

    setState(() {
      _viewIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _getView(),
        bottomNavigationBar: _bottomNavBar(context),
      ),
    );
  }

  _bottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_box_outlined), label: "Mis datos"),
        BottomNavigationBarItem(
            icon: Icon(Icons.logout_outlined), label: "Salir"),
      ],
      onTap: (index) => _switchView(context, index),
      currentIndex: 0,
      fixedColor: Colors.green[800],
      iconSize: 30,
    );
  }

  Widget _getView() {
    Widget view;
    String title;
    switch (_viewIndex) {
      case 0:
        view = _home();
        title = "Mis QRs";
        break;
      case 1:
        view = MyDataView();
        title = "Mis visitas";
        break;
    }
    return view;
  }

  _home() {
    return Scaffold(
        appBar: AppBar(
          title: Text("BIENVENIDO A CETIS 32"),
          centerTitle: true,
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
                                  onPressed: testNotification,
                                  child: Column(children: [
                                    Icon(Icons.account_box_outlined,
                                        size: 90,
                                        color: AppColors.morenaLightColor
                                            .withOpacity(0.6)),
                                    Text("Accesos",
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
                                    Text("Asistencias",
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
                  )))
        ]));
  }
}
