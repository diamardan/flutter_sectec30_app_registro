import 'package:cetis32_app_registro/main.dart';
import 'package:cetis32_app_registro/src/models/notification_model.dart' as app;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler {
  app.Notification _notification;
  RemoteMessage message;

  NotificationHandler(this.message) {
    RemoteNotification notification = message.notification;
    AndroidNotification android = message.notification?.android;

    if (notification != null && android != null)
      _createObject(message, notification);
  }

  app.Notification get currentNotification => _notification;

  _createObject(RemoteMessage message, RemoteNotification notification) {
    _notification = app.Notification(
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
  }

  showLocalNotification(Function onPress) async {
    onSelectLocalNotification(payload) {
      if (payload == "go-notifications-screen") {
        onPress();
      }
    }

    print("creando notificacion...");

    AndroidInitializationSettings android =
        AndroidInitializationSettings("@mipmap/launch");
    await flutterLocalNotificationsPlugin.initialize(
        InitializationSettings(android: android),
        onSelectNotification: onSelectLocalNotification);

    flutterLocalNotificationsPlugin.show(
        message.notification.hashCode,
        message.notification.title,
        message.notification.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id, channel.name, channel.description,
                icon: "@mipmap/launch"
                // other properties...
                )),
        payload: "go-to-notification");
  }
}
