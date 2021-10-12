import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsScreen extends StatefulWidget {
  final RemoteMessage remoteMessage;
  NotificationsScreen(this.remoteMessage);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  RemoteMessage remoteMessage;
  @override
  void initState() {
    
    remoteMessage = widget.remoteMessage;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
      Column(children: [
        Text(remoteMessage.notification.title),
        Text(remoteMessage.notification.body),
      ],)
      
    );
  }
}
