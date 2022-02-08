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

  static initialize(BuildContext context) async {
    messaging = FirebaseMessaging.instance;
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    Registration _registration = userProvider.getRegistration;
    MessagingService messagingService = MessagingService();

    setListeners(context); // < - * *

    // verify if token exists
    Device device = await Device.create();
    final existsToken =
        await messagingService.existsFCMToken(_registration.id, device.id);
    print("*************************************");
    print(existsToken);
    if (!existsToken) {
      messaging.getToken().then((token) {
        messagingService.setFCMToken(_registration.id, device.id, token);
        messagingService.suscribeToTopics(_registration);
      });
    }
  }

  static setListeners(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    Future<dynamic> onSelectNotification(payload) async {
      // implement the navigation logic
      if (payload == "go-to-notification") {
        Navigator.pushNamed(context, 'notifications');
      }
    }

    // App on foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("message recieved");

      RemoteNotification notification = message.notification;

      AndroidNotification android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        NotificationModel.Notification appNotification =
            NotificationModel.Notification(
                title: notification.title,
                message: notification.body,
                receivedDate: DateTime.now(),
                sentDate: message.sentTime,
                senderName: message.data["sender"],
                messageId: message.data["messageId"],
                haveAttachments:
                    message.data["haveAttachments"] == "yes" ? true : false,
                read: false);

        messagingService.save(userProvider.getUser.id, appNotification);

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
