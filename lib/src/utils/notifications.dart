import 'dart:async';

import 'package:cetis32_app_registro/main.dart';
import 'package:cetis32_app_registro/src/models/notification_model.dart'
    as NotificationModel;
import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/provider/user_provider.dart';
import 'package:cetis32_app_registro/src/services/MessagingService.dart';
import 'package:cetis32_app_registro/src/utils/Device.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

class AppNotifications {
  static MessagingService messagingService = MessagingService();
  static FirebaseMessaging messaging;

  static Future<List<StreamSubscription>> initialize(
      BuildContext context) async {
    messaging = FirebaseMessaging.instance;
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    Registration _registration = userProvider.getRegistration;
    MessagingService messagingService = MessagingService();
    List<StreamSubscription> _suscriptions = setListeners(context); // < - * *
    print(_registration.toString());
    // verify if token exists
    Device device = await Device.create();
    final existsToken =
        await messagingService.existsFCMToken(_registration.id, device.id);

    print(existsToken);
    if (!existsToken) {
      messaging.getToken().then((token) {
        messagingService.setFCMToken(_registration.id, device.id, token);
        messagingService.suscribeToTopics(_registration);
      });
    }
    return _suscriptions;
  }

  static List<StreamSubscription> setListeners(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    Future<dynamic> onSelectNotification(payload) async {
      // implement the navigation logic
      if (payload == "go-to-notification") {
        Navigator.pushNamed(context, 'notifications');
      }
    }

    // App on foreground
    var s1 = FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("message recieved");

      RemoteNotification notification = message.notification;

      AndroidNotification android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        NotificationModel.Notification _notification =
            NotificationModel.Notification(
                serverMessageId: message.messageId,
                title: notification.title,
                message: notification.body,
                receivedDate: DateTime.now(),
                sentDate: message.sentTime,
                senderName: message.data["sender"],
                messageId: message.data["messageId"],
                origin: message.data["origin"],
                haveAttachments:
                    message.data["haveAttachments"] == "yes" ? true : false,
                inputMode: "foreground",
                read: false);

        messagingService.save(userProvider.getUser.id, _notification);

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

    var s2 = FirebaseMessaging.onMessageOpenedApp.listen((message) {
      //click from user on notification when app is backgroud
      print('Message clicked!');
      Navigator.pushNamed(context, 'notifications');
    });
    List<StreamSubscription> subscriptions = [];

    subscriptions.add(s1);
    subscriptions.add(s2);
    return subscriptions;
  }
}
