import 'dart:async';
import 'package:cetis32_app_registro/fcm/fcm_service.dart';
import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/controllers/SignIn/SignInController.dart';
import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/provider/Device.dart';
import 'package:cetis32_app_registro/src/provider/user_provider.dart';
import 'package:cetis32_app_registro/ui/res/colors.dart';
import 'package:cetis32_app_registro/ui/screens/home/menu_view.dart';
import 'package:cetis32_app_registro/ui/screens/home/news_view.dart';
import 'package:cetis32_app_registro/ui/screens/notifications/notifications_screen.dart';
import 'package:cetis32_app_registro/src/data/AuthenticationService.dart';
import 'package:cetis32_app_registro/src/data/RegistrationService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => _homeScreenState();
}

// ignore: camel_case_types
class _homeScreenState extends State<HomeScreen> {
  final RegistrationService registrationService = RegistrationService();
  FCMService fcmService;

  FirebaseMessaging messaging;

  int _viewIndex = 0;
  Registration user;
  UserProvider userProvider;

  bool userLoaded = false;
  bool loading;

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
      fcmService = FCMService(user.id, context);
      fcmService.starOnMessagetListener();
      fcmService.startOnMessageOpenedAppListener();
      startDeviceLIstener();
      userLoaded = true;
    }

    super.didChangeDependencies();
  }

  void startDeviceLIstener() async {
    Device device = await DeviceProvider.instance.device;
    final school = AppConstants.fsCollectionName;

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
    setState(() {
      _viewIndex = index;
    });
  }

  Future<bool> _systemBackButtonPressed() async {
    if (_viewIndex > 0) {
      setState(() {
        _viewIndex--;
      });
      return false;
    } else
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
                children: [MenuView(), NotificationsScreen(), NewsView()],
              ),
              bottomNavigationBar: _bottomNavBar(),
            )));
  }

  _bottomNavBar() {
    double iconSize = 35;
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              size: iconSize,
            ),
            label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_rounded,
              size: iconSize,
            ),
            label: "Notificaciones"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.newspaper_rounded,
              size: iconSize,
            ),
            label: "Noticias"),
      ],
      currentIndex: _viewIndex,
      selectedItemColor: AppColors.morenaLightColor,
      unselectedItemColor: Colors.grey,
      iconSize: 30,
      onTap: _switchView,
    );
  }
}
