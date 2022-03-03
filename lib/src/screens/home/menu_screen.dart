import 'dart:async';

import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/provider/user_provider.dart';
import 'package:cetis32_app_registro/src/res/notifications.dart';
import 'package:cetis32_app_registro/src/screens/home/home_view.dart';
import 'package:cetis32_app_registro/src/screens/home/my_data_view.dart';
import 'package:cetis32_app_registro/src/services/MessagingService.dart';
import 'package:cetis32_app_registro/src/services/RegistrationService.dart';
import 'package:cetis32_app_registro/src/widgets/log_out_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../services/RegistrationService.dart';

class DisposableWidget {
  List<StreamSubscription> _subscriptions = [];

  void cancelSubscriptions() {
    _subscriptions.forEach((subscription) {
      subscription.cancel();
    });
  }

  void addSubscription(StreamSubscription subscription) {
    _subscriptions.add(subscription);
  }
}

extension DisposableStreamSubscriton on StreamSubscription {
  void canceledBy(DisposableWidget widget) {
    widget.addSubscription(this);
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => _homeScreenState();
}

// ignore: camel_case_types
class _homeScreenState extends State<HomeScreen> with DisposableWidget {
  final RegistrationService registrationService = RegistrationService();
  final MessagingService messagingService = MessagingService();
  FirebaseMessaging messaging;

  int _viewIndex = 0;
  Registration registration;
  UserProvider userProvider;
  User user;
  bool userLoaded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    cancelSubscriptions();
    super.dispose();
  }

  @override
  didChangeDependencies() {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    registration = userProvider.getRegistration;
    user = userProvider.getUser;
    if (user != null && userLoaded == false) {
      startNotificationsListening();
      userLoaded = true;
    }

    super.didChangeDependencies();
  }

  openNotificationScreen() {
    Navigator.pushNamed(context, "notification");
  }

  startNotificationsListening() {
    print("Starting notifications");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      NotificationHandler notificationHandler = NotificationHandler(message);
      notificationHandler.showLocalNotification(openNotificationScreen);

      messagingService.addNotification(
          user.id, notificationHandler.currentNotification);
    }).canceledBy(this);
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      openNotificationScreen();
    });
  }

  void _switchView(int index) {
    if (index == 2) {
      showLogoutDialog(context, "main");
      return;
    }

    setState(() {
      _viewIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: user == null,
        child: Scaffold(
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
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          body: IndexedStack(
            index: _viewIndex,
            children: [HomeView(), MyDataView()],
          ),
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
}
