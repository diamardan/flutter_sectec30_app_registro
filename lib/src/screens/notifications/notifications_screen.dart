import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/models/notification_model.dart'
    as NotificationModel;
import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/provider/user_provider.dart';
import 'package:cetis32_app_registro/src/screens/notifications/attachments_screen.dart';
import 'package:cetis32_app_registro/src/services/RegistrationService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';

final school = AppConstants.fsCollectionName;

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  UserProvider userProvider;
  User user;
  Registration registration = Registration();
  final RegistrationService registrationService = RegistrationService();
  bool _downloadingAttachments = false;
  String downloadMessageId = "";
  double fontSize = 14;
  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    user = userProvider.getUser;
    super.initState();
  }

  showDownload(dynamic value) {
    setState(() {
      _downloadingAttachments = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Notificaciones'),
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87),
        body: Stack(children: [
          Container(
            color: Color(0XFFEAEAEA),
            child: PaginateFirestore(
              // Use SliverAppBar in header to make it sticky
              //header: SliverToBoxAdapter(child: Text('HEADER')),
              //footer: SliverToBoxAdapter(child: Text('FOOTER')),

              itemBuilderType:
                  PaginateBuilderType.listView, //Change types accordingly
              itemBuilder: (index, context, documentSnapshot) {
                final data = documentSnapshot.data() as Map;

                NotificationModel.Notification notification =
                    NotificationModel.Notification.fromJson(data);
                var message = notification.message;
                message = message.length > 100
                    ? message.substring(0, 99) + "..."
                    : message;
                return Column(children: [
                  Container(
                    height: 20,
                    color: Color(0XFFEAEAEA),
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        ListTile(
                            leading: CircleAvatar(
                              child: Icon(
                                Icons.message_outlined,
                                color: Colors.white,
                              ),
                              backgroundColor:
                                  AppColors.morenaLightColor.withAlpha(100),
                            ),
                            title: notification.title == null
                                ? Text('No disponible')
                                : Text(notification.title),
                            subtitle: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${notification.receivedDate.day.toString().padLeft(2, '0')}-${notification.receivedDate.month.toString().padLeft(2, '0')}-${notification.receivedDate.year.toString()}",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(" "),
                                  Text(
                                    "${notification.receivedDate.hour.toString().padLeft(2, '0')}-${notification.receivedDate.minute.toString().padLeft(2, '0')}",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ]),
                            trailing: notification.haveAttachments == true
                                ? OutlinedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  AttachmentsScreen(
                                                    messageId:
                                                        notification.messageId,
                                                  )));

                                      /*   downloadMessageId =
                                          notification.messageId;
                                     */
                                    },
                                    icon: Icon(Icons.attach_file),
                                    label: Text("Archivos"))
                                : SizedBox(
                                    width: 10,
                                  )),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: GestureDetector(
                              onTap: () {
                                showMessage(context, notification);
                              },
                              child: Text(message)),
                        )
                      ],
                    ),
                  )
                ]);
              },
              // orderBy is compulsory to enable pagination
              query: FirebaseFirestore.instance
                  .collection('schools')
                  .doc(school)
                  .collection("notifications")
                  .doc(user.id)
                  .collection("received_messages")
                  .orderBy("sent_date", descending: true),
              // to fetch real-time data
              isLive: true,
            ),
          ),
          //  _downloadingAttachments
          //    ? DownloadAttchments(messageId: downloadMessageId)
          // Container()
        ]));
  }

  Future<void> showMessage(
      BuildContext context, NotificationModel.Notification notification) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
              contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              content: Container(
                  // height: 500,
                  child: Column(
                children: [
                  Expanded(
                      child: message(notification.title, notification.message)),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  fontSize -= 2;
                                });
                              },
                              icon: Icon(
                                Icons.zoom_out,
                                size: 40,
                              )),
                          SizedBox(width: 10),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  fontSize += 2;
                                });
                              },
                              icon: Icon(Icons.zoom_in, size: 40))
                        ],
                      ))
                ],
              )));
        });
      },
    );
  }

  message(String title, String body) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: fontSize),
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          body,
          style: TextStyle(fontSize: fontSize),
        )
      ],
    ));
  }
}
