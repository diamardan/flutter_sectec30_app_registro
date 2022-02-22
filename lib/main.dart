import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/models/notification_model.dart'
    as NotificationModel;
import 'package:cetis32_app_registro/src/provider/user_provider.dart';
import 'package:cetis32_app_registro/src/routes/routes.dart';
import 'package:cetis32_app_registro/src/screens/login/wrapper_auth.dart';
import 'package:cetis32_app_registro/src/services/MessagingService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';
//import 'package:cetis32_app_registro/src/bloc/deep_link_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification.body}');

  RemoteNotification notification = message.notification;

  AndroidNotification android = message.notification?.android;

  if (notification != null && android != null) {
    await Firebase.initializeApp();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("registration_id");
    NotificationModel.Notification _notification =
        NotificationModel.Notification(
            serverMessageId: message.messageId,
            title: notification.title,
            message: notification.body,
            receivedDate: DateTime.now(),
            sentDate: message.sentTime,
            origin: message.data["origin"],
            senderName: message.data["sender"],
            messageId: message.data["messageId"],
            haveAttachments:
                message.data["haveAttachments"] == "yes" ? true : false,
            inputMode: "background",
            read: false);
    MessagingService().save(userId, _notification);
  }
}

/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance // for ios
      .setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  Future.delayed(const Duration(seconds: 3), () {
    print("10 segundos");
    initializeDateFormatting().then((_) => runApp(MyApp()));
  });
}

class MyApp extends StatelessWidget {
  // DeepLinkBloc _bloc = DeepLinkBloc();
  final ThemeData theme = ThemeData();
  @override
  Widget build(BuildContext context) {
/*DeepLinkBloc _bloc = DeepLinkBloc();
    return Provider<DeepLinkBloc>(
                create: (context) => _bloc,
                dispose: (context, bloc) => bloc.dispose(),
                child:*/

    return ChangeNotifierProvider(
        create: (context) => UserProvider(),
        child: MaterialApp(
            title: 'CETIS 32 APP REGISTRO',
            debugShowCheckedModeBanner: false,
            routes: getApplicationRoutes(context),
            theme: theme.copyWith(
                colorScheme: theme.colorScheme.copyWith(
              primary: AppColors.morenaColor,
              secondary: Colors.blue,
            )),
            /* initialRoute: 'wrapper', */
            home: Wrapper()));
  }
}
