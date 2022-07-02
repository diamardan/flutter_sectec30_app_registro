import 'dart:async';

import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/controllers/SignIn/SignInController.dart';
import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/provider/Device.dart';
import 'package:cetis32_app_registro/src/provider/supscritions_provider.dart';
import 'package:cetis32_app_registro/src/provider/user_provider.dart';
import 'package:cetis32_app_registro/src/res/notifications.dart';
import 'package:cetis32_app_registro/src/screens/home/menu_view.dart';
import 'package:cetis32_app_registro/src/screens/home/my_data_view.dart';
import 'package:cetis32_app_registro/src/services/AuthenticationService.dart';
import 'package:cetis32_app_registro/src/services/MessagingService.dart';
import 'package:cetis32_app_registro/src/services/RegistrationService.dart';
import 'package:cetis32_app_registro/src/widgets/log_out_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
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

extension StreamSubscriptionState on StreamSubscription {
  void addToState(BuildContext context) {
    SubscriptionsProvider subscriptionProvider =
        Provider.of<SubscriptionsProvider>(context, listen: false);
    subscriptionProvider.addSubscription(this);
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
  Registration user;
  UserProvider userProvider;

  bool userLoaded = false;
  bool loading;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //  cancelSubscriptions();
    super.dispose();
  }

  setLoading(value) {
    setState(() {
      loading = value;
    });
  }

  @override
  didChangeDependencies() {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    user = userProvider.getRegistration;
    //print(user.toString());
    print(user.toString());
    if (user != null && userLoaded == false) {
      startNotificationsListeners();
      startDeviceLIstener();
      userLoaded = true;
    }

    super.didChangeDependencies();
  }

  openNotificationScreen() {
    Navigator.pushNamed(context, "notification");
  }

  startNotificationsListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      NotificationHandler notificationHandler = NotificationHandler(message);
      notificationHandler.showLocalNotification(openNotificationScreen);

      messagingService.addNotification(
          user.id, notificationHandler.currentNotification);
    }).addToState(context);
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      openNotificationScreen();
    }).addToState(context);
  }

  void startDeviceLIstener() async {
    Device device = await DeviceProvider.instance.device;
    print("listen device");
    print(user.id);

    FirebaseFirestore.instance
        .collection("schools")
        .doc(school)
        .collection("registros")
        .doc(user.id)
        .collection("devices")
        .doc(device.id)
        .snapshots()
        .listen((doc) {
      print(doc);
      if (!doc.exists) {
        print("no hay dispositivo");
        SignInController().cleanAuthenticationData(context);
        AuthenticationService().signOut();
      }
    }).addToState(context);
  }

  void _logout() async {
    setLoading(true);
    //  cancelSubscriptions();
    await SignInController().cleanAuthenticationData(context);
    AuthenticationService().signOut();
  }

  void _switchView(int index) async {
    if (index == 2) {
      bool res = await showLogoutDialog(context, "main");
      if (res) _logout();

      return;
    }

    setState(() {
      _viewIndex = index;
    });
  }

  Future<bool> _systemBackButtonPressed() async {
    if (_viewIndex == 1) {
      setState(() {
        _viewIndex = 0;
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _systemBackButtonPressed,
        child: ModalProgressHUD(
            inAsyncCall: user == null,
            child: Scaffold(
              body: IndexedStack(
                index: _viewIndex,
                children: [MenuView(), MyDataView()],
              ),
              bottomNavigationBar: _bottomNavBar(context),
            )));
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
