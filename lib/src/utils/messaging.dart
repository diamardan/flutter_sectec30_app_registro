import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/provider/user_provider.dart';
import 'package:cetis32_app_registro/src/services/MessagingService.dart';
import 'package:cetis32_app_registro/src/services/RegistrationService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cetis32_app_registro/src/models/notification_model.dart'
    as NotificationModel;
import 'package:cetis32_app_registro/main.dart';
import 'package:provider/provider.dart';

class AppMessaging {
  static MessagingService messagingService = MessagingService();
  static FirebaseMessaging messaging;

  static initializeNotifications(BuildContext context) {
    Registration _registration;
    User _user;

    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    _user = userProvider.getUser;
    _registration = userProvider.getRegistration;

    messaging = FirebaseMessaging.instance;

    print(_registration.toString());
    if (_registration.fcmToken == null) {
      messaging.getToken().then((value) {
        messagingService.setFCMToken(_user.id, value);
        setListeners(context);
        messagingService.suscribeToTopics(_registration);
      });
    } else
      setListeners(context);
  }

  static setListeners(BuildContext context) {
    Future<dynamic> onSelectNotification(payload) async {
      // implement the navigation logic
      if (payload == "go-to-notification") {
        Navigator.pushNamed(context, 'notifications');
      }
    }

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
}
