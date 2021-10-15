import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/provider/user_provider.dart';
import 'package:cetis32_app_registro/src/services/RegistrationService.dart';
import 'package:cetis32_app_registro/src/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:cetis32_app_registro/src/models/notification_model.dart'
    as NotificationModel;

final school = "cetis32";

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  UserProvider userProvider;
  User user;
  Registration registration = Registration();
  final RegistrationService registrationService = RegistrationService();
  bool showCnangePassword = false;
  // PaginateRefreshedChangeListener refreshChangeListener = PaginateRefreshedChangeListener();

  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    user = userProvider.getUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificaciones'),
        centerTitle: true,
        backgroundColor: AppColors.yellowNotif,
        foregroundColor: Colors.black45,
      ),
      body: PaginateFirestore(
        // Use SliverAppBar in header to make it sticky
        //header: SliverToBoxAdapter(child: Text('HEADER')),
        //footer: SliverToBoxAdapter(child: Text('FOOTER')),

        itemBuilderType:
            PaginateBuilderType.listView, //Change types accordingly
        itemBuilder: (index, context, documentSnapshot) {
          final data = documentSnapshot.data() as Map;

          print(data.toString());
          NotificationModel.Notification notification =
              NotificationModel.Notification.fromJson(data);

          return ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.message_outlined,
                color: Colors.white,
              ),
              backgroundColor: AppColors.yellowNotif,
            ),
            title: notification.title == null
                ? Text('No disponible')
                : Text(notification.title),
            subtitle: Text(documentSnapshot.id),
          );
        },
        // orderBy is compulsory to enable pagination
        query: FirebaseFirestore.instance
            .collection('schools')
            .doc(school)
            .collection("notifications")
            .orderBy("sent_date"),
        // to fetch real-time data
        isLive: true,
      ),
    );
  }
}
